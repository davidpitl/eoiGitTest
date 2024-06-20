# Usa una imagen base oficial de Python
FROM python:3.10-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo de requisitos y el script en el directorio de trabajo del contenedor
COPY requirements.txt requirements.txt
COPY main.py main.py

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Comando para ejecutar el script
CMD ["python", "main.py"]
