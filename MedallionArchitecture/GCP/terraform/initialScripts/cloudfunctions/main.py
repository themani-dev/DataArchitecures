# main.py

def entry(event, context):
    import base64
    import json
    print("Triggered by file in GCS.")
    print(f"Event ID: {context.event_id}")
    print(f"Event Type: {context.event_type}")