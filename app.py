# Calculadora simples em Python
import json


def calcular(a: float, b: float, operacao: str) -> float:
    operacoes = {
        "+": lambda x, y: x + y,
        "-": lambda x, y: x - y,
        "*": lambda x, y: x * y,
        "/": lambda x, y: x / y if y != 0 else float("nan"),
    }
    return operacoes[operacao](a, b)


if __name__ == "__main__":
    a, b, op = 15.0, 27.0, "+"
    resultado = calcular(a, b, op)
    print(json.dumps({
        "aplicacao": "Calculadora Python Docker",
        "operacao": f"{a} {op} {b}",
        "resultado": resultado,
        "status": "OK",
    }, ensure_ascii=False))
