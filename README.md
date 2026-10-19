# docker-compose-calculadora

Calculadora Python empacotada com **Dockerfile multi-stage** e orquestrada com **Docker Compose**, executada no **GitHub Codespaces**.

## Serviços
| Serviço | Imagem | Função |
|---|---|---|
| calculadora | `calculadora-python:1.0` (build do Dockerfile) | Nginx servindo o resultado da calculadora na porta 8080 |
| db | `postgres:16-alpine` | Histórico das operações (volume `db_data`) |
| cache | `redis:7-alpine` | Cache de resultados (volume `cache_data`, AOF) |

## Redes, volumes e reinício
- `frontend`: só a calculadora é exposta.
- `backend` (`internal: true`): banco e cache isolados da internet.
- Volumes nomeados persistem os dados entre reinícios.
- `restart: always` na infraestrutura e `unless-stopped` no app.
- Healthchecks + `depends_on: service_healthy`: o app só sobe com db e cache prontos.

## Como executar (Codespaces)
Opcional: `cp .env.example .env` para alterar as credenciais (o compose já tem valores padrão).

```bash
docker compose up -d --build
docker compose ps
curl http://localhost:8080/soma
```

## Finalizar
```bash
docker compose down -v
```
Depois: **Code → Codespaces → ⋯ → Stop codespace** (ou Delete).
