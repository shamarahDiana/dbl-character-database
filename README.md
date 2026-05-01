# Tech Stack

- Python
- Flask
- PostgreSQL
- HTML
- CSS
- JavaScript
- psycopg2
- python-dotenv

# Setup Instructions

## 1. Create a virtual environment

Run this command in the project folder:

```bash
python -m venv venv
```

## 2. Activate the virtual environment

On Windows, run:

```bash
.\venv\Scripts\activate
```

## 3. Install dependencies

Run:

```bash
pip install -r requirements.txt
```

Below are what is in the txt.

- flask
- psycopg2-binary
- python-dotenv

## 4. Create the PostgreSQL database

```text
dbl_characters
```

## 5. Restore the database dump

```bash
psql -U postgres -d dbl_characters -f sql/database_dump.sql
```

## 6. Create a .env file

In the project folder, create a file named .env and add:

```text
POSTGRES_LOCAL_PASSWORD=your_postgres_password
```

Replace your_postgres_password with your own PostgreSQL password.

## 7. Run the app

```bash
python app.py
```

## 8. Open the app

Open a browser and type in:

```text
http://127.0.0.1:5000/
```
