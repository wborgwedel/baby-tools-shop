FROM python:3.9-alpine

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# install systemtools
RUN apk add --no-cache --virtual .build-deps \
    gcc musl-dev libffi-dev

# install dependencies
COPY requirements.txt .
RUN pip install --trusted-host pypi.python.org --no-cache-dir -r requirements.txt

# copy projectfiles
COPY . .

# copy entrypoint.sh and make it executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# define Port
EXPOSE 8025

# startcommand
ENTRYPOINT ["/app/entrypoint.sh", "python", "babyshop_app/manage.py", "runserver", "0.0.0.0:8025"]