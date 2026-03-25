import json
import sys
import os 



def load_config(filename):
    """Читає конфіг у форматі JSON."""
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"Помилка: Файл '{filename}' не знайдено!")
        sys.exit(1)
    except json.JSONDecodeError:
        print(f"Помилка: Файл '{filename}' містить невалідний JSON!")
        sys.exit(1)



def validate_config(config):
    """Перевіряє, чи файл написаний правильно."""
    required_blocks = ['app', 'server', 'features', 'workflow']
    for block in required_blocks:
        if block not in config:
            print(f"Помилка валідації: Відсутній обов'язковий блок '{block}'")
            sys.exit(1) 

    if config['app'].get('env') not in ['dev', 'test', 'prod']:
        print("Помилка валідації: app.env має бути 'dev', 'test' або 'prod'")
        sys.exit(1)

    if config['server'].get('logLevel') not in ['debug', 'info', 'warning', 'error']:
        print("Помилка валідації: Неправильний server.logLevel")
        sys.exit(1)

    if type(config['server'].get('port')) is not int:
        print("Помилка валідації: server.port має бути цілим числом!")
        sys.exit(1)

    if type(config['features'].get('enableCache')) is not bool:
        print("Помилка валідації: features.enableCache має бути true або false!")
        sys.exit(1)

    steps = config['workflow'].get('steps', [])
    for i, step in enumerate(steps):
        if 'type' not in step:
            print(f"Помилка валідації: У кроці {i+1} відсутнє поле 'type'")
            sys.exit(1)
        
        t = step['type']
        if t == 'print' and 'message' not in step:
            print(f"Помилка валідації (Крок {i+1}): Для команди 'print' потрібне поле 'message'")
            sys.exit(1)
        elif t == 'set' and ('var' not in step or 'value' not in step):
            print(f"Помилка валідації (Крок {i+1}): Для 'set' потрібні 'var' та 'value'")
            sys.exit(1)



def get_value(val, context):
    """Шукає змінну типу ${var} у контексті, або повертає як є, якщо це число."""
    if isinstance(val, str) and val.startswith('${') and val.endswith('}'):
        var_name = val[2:-1] 
        if var_name not in context:
            print(f"Помилка виконання: Змінну '{var_name}' не знайдено!")
            sys.exit(1)
        return context[var_name]
    return val 



def interpolate_string(text, context):
    """Замінює всі ${var} у тексті на їхні значення з контексту."""
    if type(text) is not str:
        return text
    for key, val in context.items():
        text = text.replace(f"${{{key}}}", str(val))
    return text



def execute_steps(steps, context):
    """Виконує список кроків (команд)."""
    for step in steps:
        cmd = step['type']

        if cmd == 'print':
            msg = interpolate_string(step['message'], context)
            print(msg)

        elif cmd == 'set':
            val = get_value(step['value'], context)
            context[step['var']] = val

        elif cmd == 'add' or cmd == 'multiply':
            a = get_value(step['a'], context)
            b = get_value(step['b'], context)
            
            if type(a) not in (int, float) or type(b) not in (int, float):
                print(f"Помилка виконання: {cmd} вимагає чисел! Отримано {a} і {b}")
                sys.exit(1)
                
            if cmd == 'add':
                context[step['var']] = a + b
            elif cmd == 'multiply':
                context[step['var']] = a * b

        elif cmd == 'if':
            left = get_value(step['condition']['left'], context)
            right = get_value(step['condition']['right'], context)
            op = step['condition']['op']

            is_true = False
            if op == '==': is_true = (left == right)
            elif op == '!=': is_true = (left != right)
            elif op == '>': is_true = (left > right)
            elif op == '>=': is_true = (left >= right)
            elif op == '<': is_true = (left < right)
            elif op == '<=': is_true = (left <= right)
            else:
                print(f"Помилка: Невідомий оператор '{op}'")
                sys.exit(1)

            if is_true:
                execute_steps(step.get('then', []), context)
            else:
                execute_steps(step.get('else', []), context)

        elif cmd == 'summary':
            print("\n--- ПІДСУМОК (SUMMARY) ---")
            for field in step['fields']:
                val = context.get(field, "НЕ ЗНАЙДЕНО")
                print(f"{field}: {val}")
            print("--------------------------\n")

        else:
            print(f"Помилка: Невідома команда '{cmd}'")
            sys.exit(1)




if __name__ == "__main__":
    current_dir = os.path.dirname(os.path.abspath(__file__))
    config_path = os.path.join(current_dir, 'config.json')
    
    config = load_config(config_path) 
    validate_config(config)
    
    context = {
        "app.name": config['app']['name'],
        "app.env": config['app']['env']
    }
    
    print("=== Старт виконання DSL ===\n")
    execute_steps(config['workflow']['steps'], context)
    print("\n=== Виконання завершено ===")