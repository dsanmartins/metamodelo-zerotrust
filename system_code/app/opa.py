def check_policy_opa(policy):
    def decorator(func):
        def wrapper(*args, **kwargs):
            # evaluate OPA policy here
            return func(*args, **kwargs)
        return wrapper
    return decorator
