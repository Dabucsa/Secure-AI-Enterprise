"""Send synthetic MCP and A2A gateway events that trigger each gateway rule.

Usage:
    pip install azure-identity azure-monitor-ingestion
    python send_test_events.py --endpoint <ingestionEndpoint> --dcr <dcrImmutableId>
    python send_test_events.py --dry-run      # validate the events against the schemas only

The deployment outputs ingestionEndpoint and dcrImmutableId. The identity
running the script needs Monitoring Metrics Publisher on the DCR.
"""
import argparse
import json
import uuid
from datetime import datetime, timedelta, timezone
from pathlib import Path

SCHEMAS = Path(__file__).resolve().parent.parent / "schemas"
PYTHON_TYPES = {"datetime": str, "string": str, "dynamic": (list, dict), "long": int, "int": int, "boolean": bool}


def minutes_ago(minutes=0):
    return (datetime.now(timezone.utc) - timedelta(minutes=minutes)).isoformat()


def mcp_events():
    base = {"Usuario": "ana@contoso.com", "Agente": "agente-compras", "Cliente": "copilot-studio",
            "VersionServidor": "1.4.0", "ArgumentosRedactados": "{}", "DestinosEnArgumentos": [],
            "BytesRespuesta": 512, "Resultado": "ok", "DuracionMs": 120}
    events = [
        # MCP-001: approved server with changed definitions, and an unregistered server
        {**base, "TimeGenerated": minutes_ago(5), "Servidor": "erp-tools", "Operacion": "tools/list",
         "Herramienta": "", "HuellaDefiniciones": "f" * 64},
        {**base, "TimeGenerated": minutes_ago(5), "Servidor": "mcp-desconocido", "Operacion": "tools/list",
         "Herramienta": "", "HuellaDefiniciones": "a" * 64},
        # MCP-002 and MCP-003: first use of a tool that emails an external domain
        {**base, "TimeGenerated": minutes_ago(4), "Servidor": "erp-tools", "Operacion": "tools/call",
         "Herramienta": "enviar_correo", "HuellaDefiniciones": "",
         "DestinosEnArgumentos": ["proveedor@externo.example"]},
    ]
    # MCP-004: 120 calls within two minutes
    events += [{**base, "TimeGenerated": minutes_ago(2), "Servidor": "erp-tools", "Operacion": "tools/call",
                "Herramienta": "exportar_tabla", "HuellaDefiniciones": ""} for _ in range(120)]
    return events


def a2a_events():
    base = {"Direccion": "saliente", "Externo": True, "Socio": "logistica-sa",
            "AgenteCliente": "agente-compras", "AgenteRemoto": "cotizador-logistico",
            "Habilidad": "cotizar_envio", "EstadoTarea": "working", "FirmaValida": True,
            "IdClave": "socio-2026", "EtiquetaDatos": "General", "BytesEnviados": 2048}
    long_task = str(uuid.uuid4())
    events = [
        # A2A-001: invalid signature from an unknown key
        {**base, "TimeGenerated": minutes_ago(6), "IdTarea": str(uuid.uuid4()), "Turno": 1,
         "FirmaValida": False, "IdClave": "clave-desconocida"},
        # A2A-002: confidential data sent to an external agent
        {**base, "TimeGenerated": minutes_ago(5), "IdTarea": str(uuid.uuid4()), "Turno": 1,
         "EtiquetaDatos": "Confidencial"},
        # A2A-004: first contact with a new external agent
        {**base, "TimeGenerated": minutes_ago(4), "IdTarea": str(uuid.uuid4()), "Turno": 1,
         "AgenteRemoto": "agente-nuevo-externo"},
    ]
    # A2A-003: one task with 12 turns
    events += [{**base, "TimeGenerated": minutes_ago(3), "IdTarea": long_task, "Turno": turn,
                "EstadoTarea": "input-required"} for turn in range(1, 13)]
    return events


def validate(table, events):
    columns = {c["name"]: c["type"] for c in json.loads((SCHEMAS / f"{table}.json").read_text())}
    for event in events:
        extra, missing = set(event) - set(columns), set(columns) - set(event)
        if extra or missing:
            raise ValueError(f"{table}: extra {extra or '-'}, missing {missing or '-'}")
        for name, value in event.items():
            expected = columns[name]
            # bool is a subclass of int, so reject it explicitly for numeric columns
            if not isinstance(value, PYTHON_TYPES[expected]) or (expected != "boolean" and isinstance(value, bool)):
                raise ValueError(f"{table}.{name}: {value!r} is not {expected}")


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--endpoint", help="ingestionEndpoint output of the deployment")
    parser.add_argument("--dcr", help="dcrImmutableId output of the deployment")
    parser.add_argument("--dry-run", action="store_true", help="validate the events without sending them")
    args = parser.parse_args()

    batches = {"MCPGateway_CL": mcp_events(), "A2AGateway_CL": a2a_events()}
    for table, events in batches.items():
        validate(table, events)
        print(f"{table}: {len(events)} valid events")
    if args.dry_run:
        return
    if not (args.endpoint and args.dcr):
        parser.error("--endpoint and --dcr are required unless --dry-run is set")

    from azure.identity import DefaultAzureCredential
    from azure.monitor.ingestion import LogsIngestionClient

    client = LogsIngestionClient(endpoint=args.endpoint, credential=DefaultAzureCredential())
    for table, events in batches.items():
        client.upload(rule_id=args.dcr, stream_name=f"Custom-{table}", logs=events)
        print(f"{table}: sent")
    print("Rules run every hour; new data takes a few minutes to become queryable.")


if __name__ == "__main__":
    main()
