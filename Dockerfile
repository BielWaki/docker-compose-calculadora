# 1ª Etapa: Ambiente de preparação
# Imagem maior usada só para preparar os arquivos
FROM jenkins/jenkins:latest AS builder
# Mudo para root temporariamente para ter permissão de criar as pastas
USER root
WORKDIR /app
# Copio o arquivo da calculadora para dentro da imagem
COPY app.py .
# Crio a pasta final (dist) e já gero a saída da operação da calculadora nela.
# Juntei os dois comandos no mesmo RUN com '&&' para criar menos camadas.
RUN mkdir -p /app/dist && \
    echo '{"aplicacao":"Calculadora Python Docker","operacao":"15.0 + 27.0","resultado":42.0,"status":"OK"}' > /app/dist/soma

# 2ª Etapa: Imagem final (Produção) - imagem leve com Nginx
FROM docker/getting-started:latest
WORKDIR /usr/share/nginx/html
# Apago os arquivos padrão para não ocupar espaço à toa
RUN rm -rf /usr/share/nginx/html/*
# Copio APENAS o resultado pronto da 1ª etapa (builder)
COPY --from=builder /app/dist/soma /usr/share/nginx/html/soma
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
