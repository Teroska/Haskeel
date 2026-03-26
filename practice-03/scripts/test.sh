cd "$(dirname "$0")/.."

echo "=== Етап Test: Запуск тестів ==="
mkdir -p reports

python -m pytest -q > reports/test_output.txt 2>&1
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo "Тести провалено! Перегляньте reports/test_output.txt"
    exit $EXIT_CODE
fi

echo "Тести успішно пройдені!"
exit 0