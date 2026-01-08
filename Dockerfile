FROM ubuntu:24.04

# 2. Evitar que apt haga preguntas interactivas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# 3. Actualizar e instalar Python y las librerías que necesites vía apt
# He incluido las más comunes, añade las que tu app necesite
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 4. Crear y definir el directorio de trabajo
WORKDIR /app

# 5. Copiar el archivo explícitamente para evitar errores de "File not found"
COPY app.py /app/app.py

# 6. Comando para ejecutar (usando python3, que es como se llama en Ubuntu)
CMD ["python3", "/app/app.py"]
