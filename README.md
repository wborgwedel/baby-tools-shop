# Baby Tools Shop

## Table of Contents

1. [Description](#description)
2. [Technologies](#technologies)
3. [Quickstart](#quickstart)
4. [Usage](#Usage)


## Description

This repository contains an e-commerce project for baby tools developed with **Django 4.0.2** and **Python 3.9**.

The goal of this project is to provide a platform where users can:
- Browse a wide range of baby products
- View detailed product information
- Register and log in to their accounts
- Add products to their shopping cart
- Complete purchases through a user-friendly interface

This project is part of a coding assignment and demonstrates backend development, user authentication, templating, and containerization with Docker.


## Technologies

- pyenv
- Python 3.9
- Django 4.0.2
- Virtualenv
- Docker

## Quickstart

1. **Install the project-specific Python version (if it differs from your system Python):**
    
    ```sh
    pyenv install 3.9
    ```

2. **Set the local Python version in the project root:**
    
    ```sh
    pyenv local 3.9
    ```

3. **Create a virtual environment:**

    ```sh
    python -m venv .venv
    ```

4. **Activate the virtual environment:**

    ```sh
    source .venv/bin/activate
    ```

5. **Install Django:**
    
    ```sh
    python -m pip install Django==4.0.2
    ```

6. **Check the project for configuration issues:**
    
    ```sh
    python babyshop_app/manage.py check
    ```

    If you receive an error, **comment out the outdated import** in `babyshop_app/products/models.py`, line 2, and run the check again.

7. **Install missing dependencies (e.g., Pillow):**

    ```sh
    python -m pip install Pillow
    ```

8. **Freeze dependencies to `requirements.txt`:**

    ```sh
    pip freeze > requirements.txt
    ```

9. **Apply database migrations:**

    ```sh
    python manage.py migrate
    ```

10. **Run the development server:**

    ```sh
    python manage.py runserver
    ```

    Open `http://127.0.0.1:8000` in your browser to access the application.

    
## Usage

1. **Create `.env` file with environment variables**

    Before running the container, create a `.env` file in the project root directory.  
    This file is used to define environment variables required for superuser creation.

    Example `.env` file:

    ```env
    DJANGO_SUPERUSER_USERNAME=admin
    DJANGO_SUPERUSER_EMAIL=admin@example.com
    DJANGO_SUPERUSER_PASSWORD=adminpass123
    ```

2. **Build the Docker image**

    In the root of the project (@ the location of manage.py), build the Docker image:  

    ```sh
    docker build -t <your_image_name_here> .
    ```
    Remember the dot at the end.

3. **Run the container**

    Start the container using the `.env` file and expose port 8025:  
    
    ```sh
    docker run -d --env-file .env -p 8025:8025 --restart unless-stopped <your_container_name_here>
    ```
    
    Explanation of flags:
    - `-d`: run container in detached/ background mode
    - `--env-file`: injects the environment variables from `.env`
    - `-p 8025:8025`: maps container port 8025 to host
    - `--restart unless-stopped`: restarts container automatically on system reboot or crash

4. **Access the application**

    Once the container is running, open your browser and visit:
    
    ```sh
    http://localhost:8025
    ```

5. **Access the Django Admin**

    Navigate to:
    ```sh
    http://localhost:8025/admin
    ```
    
    Login with the superuser credentials you defined in the `.env` file.  
    The superuser is automatically created on the first container start if it does not already exist.

6. **First Run Behavior**
    
    On initial container startup, the following actions are executed automatically via `entrypoint.sh`:
    
    - Migrate the Django database schema
    - Collect static files
    - Create the Django superuser if it does not exist
    - Start the development server on port `8025`

7. **To stop the container**
    
    ```sh
    docker ps       # to get the container ID
    docker stop <container_id>
    ```
