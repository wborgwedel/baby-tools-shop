#!/bin/sh

set -e  # Exit on error

echo "===== Babyshop App Initialization Starts ====="

# Function: Print error and exit
exit_with_error() {
    echo "Error: $1"
    exit 1
}

# Check for required environment variables
[ -z "$SUPERUSER_USERNAME" ] && exit_with_error "SUPERUSER_USERNAME is not set."
[ -z "$SUPERUSER_EMAIL" ] && exit_with_error "SUPERUSER_EMAIL is not set."
[ -z "$SUPERUSER_PASSWORD" ] && exit_with_error "SUPERUSER_PASSWORD is not set."

echo ">> Checking for model changes..."
python babyshop_app/manage.py makemigrations --noinput || echo "   No new migrations found."

echo ">> Applying migrations..."
python babyshop_app/manage.py migrate --noinput || echo "   Migrations not required."

echo ">> Collecting static files..."
python babyshop_app/manage.py collectstatic --noinput || echo "   Static files already up-to-date."

echo ">> Checking/Creating superuser..."
python babyshop_app/manage.py shell -c "
from django.contrib.auth import get_user_model
import os
User = get_user_model()
username = os.environ.get('SUPERUSER_USERNAME')
email = os.environ.get('SUPERUSER_EMAIL')
password = os.environ.get('SUPERUSER_PASSWORD')
if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username, email, password)
    print(f'Superuser created: {username}')
else:
    print('ℹ Superuser already exists.')
" || echo "Error creating superuser (ignored)."

echo "Starting application..."
exec "$@"