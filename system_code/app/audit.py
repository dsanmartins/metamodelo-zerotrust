def log_action(request):
    # append to audit store (placeholder)
    print(f"[AUDIT] {getattr(request, 'method', 'N/A')} {getattr(request, 'url', '')}")
