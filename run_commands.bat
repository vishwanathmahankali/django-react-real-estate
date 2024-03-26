@echo off

if exist .env (
    call .env
)

set ENV_FILE_PARAM=--env-file .env

:menu
echo.
echo Select an option:
echo 1. Build Docker containers
echo 2. Start Docker containers
echo 3. Stop Docker containers
echo 4. Show Docker logs
echo 5. Run database migrations
echo 6. Create superuser
echo 7. Collect static files
echo 8. Remove Docker containers and volumes
echo 9. Inspect Docker volume
echo 10. Access PostgreSQL database
echo 11. Run tests
echo 12. Run tests and generate HTML coverage report
echo 13. Run Flake8 linting
echo 14. Check code formatting with Black
echo 15. Show code formatting diff with Black
echo 16. Format code with Black
echo 17. Check import sorting with isort
echo 18. Show import sorting diff with isort
echo 19. Format imports with isort
echo 20. Run makemigrations
echo q. Quit
echo.

set /p choice=Enter your choice: 

if "%choice%"=="1" (
    echo docker-compose up --build -d --remove-orphans
    docker-compose up --build -d --remove-orphans
) else if "%choice%"=="2" (
    echo docker-compose up -d
    docker-compose up -d
) else if "%choice%"=="3" (
    echo docker-compose down
    docker-compose down
) else if "%choice%"=="4" (
    echo docker-compose logs
    docker-compose logs
) else if "%choice%"=="5" (
    echo docker-compose exec api python manage.py migrate
    docker-compose exec api python manage.py migrate
) else if "%choice%"=="6" (
    echo docker-compose exec api python manage.py createsuperuser
    docker-compose exec api python manage.py createsuperuser
) else if "%choice%"=="7" (
    echo docker-compose exec api python manage.py collectstatic --no-input --clear
    docker-compose exec api python manage.py collectstatic --no-input --clear
) else if "%choice%"=="8" (
    echo docker-compose down -v
    docker-compose down -v
) else if "%choice%"=="9" (
    echo docker volume inspect estate-src_postgres_data
    docker volume inspect estate-src_postgres_data
) else if "%choice%"=="10" (
    echo docker-compose exec postgres-db psql --username=postgres --dbname=estate
    docker-compose exec postgres-db psql --username=postgres --dbname=estate
) else if "%choice%"=="11" (
    echo docker-compose exec api pytest -p no:warnings --cov=.
    docker-compose exec api pytest -p no:warnings --cov=.
) else if "%choice%"=="12" (
    echo docker-compose exec api pytest -p no:warnings --cov=. --cov-report=html
    docker-compose exec api pytest -p no:warnings --cov=. --cov-report=html
) else if "%choice%"=="13" (
    echo docker-compose exec api flake8 .
    docker-compose exec api flake8 .
) else if "%choice%"=="14" (
    echo docker-compose exec api black --check --exclude=migrations .
    docker-compose exec api black --check --exclude=migrations .
) else if "%choice%"=="15" (
    echo docker-compose exec api black --diff --exclude=migrations .
    docker-compose exec api black --diff --exclude=migrations .
) else if "%choice%"=="16" (
    echo docker-compose exec api black --exclude=migrations .
    docker-compose exec api black --exclude=migrations .
) else if "%choice%"=="17" (
    echo docker-compose exec api isort . --check-only --skip=env --skip=migrations
    docker-compose exec api isort . --check-only --skip=env --skip=migrations
) else if "%choice%"=="18" (
    echo docker-compose exec api isort . --diff --skip=env --skip=migrations
    docker-compose exec api isort . --diff --skip=env --skip=migrations
) else if "%choice%"=="19" (
    echo docker-compose exec api isort . --skip=env --skip=migrations
    docker-compose exec api isort . --skip=env --skip=migrations
) else if "%choice%"=="20" (
    echo docker-compose exec api python manage.py makemigrations
    docker-compose exec api python manage.py makemigrations
) else if /i "%choice%"=="q" (
    exit
) else (
    echo Invalid choice. Please try again.
)

goto menu
