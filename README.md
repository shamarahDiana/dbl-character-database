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

1. Create a virtual environment

Run this command in the project folder:

python -m venv venv

2. Activate the virtual environment

On Windows, run:

.\venv\Scripts\activate

3. Install dependencies

Run:

pip install -r requirements.txt (Below are what is in the txt.)
- flask
- psycopg2-binary
- python-dotenv

4. Create the PostgreSQL database

dbl_characters

5. Restore the database dump

psql -U postgres -d dbl_characters -f database_dump.sql

6. Create a .env file

In the project folder, create a file named .env and add:

POSTGRES_LOCAL_PASSWORD=your_postgres_password

Replace your_postgres_password with your own PostgreSQL password.

7. Run the app

python app.py

8. Open the app

Open a browser and type in:

http://127.0.0.1:5000/