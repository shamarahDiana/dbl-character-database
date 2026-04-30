from flask import Flask, render_template, request
import psycopg2
import os
from dotenv import load_dotenv

from characters import (
    characters_bp,
    load_character_image_map,
    build_character_summary,
    build_character_detail,
)

load_dotenv()

app = Flask(__name__)
app.register_blueprint(characters_bp)


def get_db_connection():
    conn = psycopg2.connect(
        host="localhost",
        database="dbl_characters",
        user="postgres",
        password=os.environ.get("POSTGRES_LOCAL_PASSWORD", "")
    )
    return conn


@app.route("/")
def index():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT type_name FROM types ORDER BY type_name")
    types = [row[0] for row in cur.fetchall()]

    cur.execute("SELECT rarity_name FROM rarities ORDER BY rarity_name")
    rarities = [row[0] for row in cur.fetchall()]

    cur.execute("SELECT tag_name FROM tags ORDER BY tag_name")
    tags = [row[0] for row in cur.fetchall()]

    search = request.args.get("search", "")
    type_filter = request.args.get("type", "")
    rarity_filter = request.args.get("rarity", "")
    tag_filter = request.args.get("tag", "")
    is_ll_filter = request.args.get("is_ll", "")
    is_zenkai_filter = request.args.get("is_zenkai", "")

    query = """
        SELECT c.char_id, c.name, t.type_name, r.rarity_name, c.is_ll, c.is_zenkai
        FROM characters c
        JOIN types t ON c.type_id = t.type_id
        JOIN rarities r ON c.rarity_id = r.rarity_id
        WHERE 1=1
    """
    params = []

    if search:
        query += " AND c.name ILIKE %s"
        params.append(f"%{search}%")

    if type_filter:
        query += " AND t.type_name = %s"
        params.append(type_filter)

    if rarity_filter:
        query += " AND r.rarity_name = %s"
        params.append(rarity_filter)

    if tag_filter:
        query += """
            AND EXISTS (
                SELECT 1
                FROM charactertags ct
                JOIN tags tg ON ct.tag_id = tg.tag_id
                WHERE ct.char_id = c.char_id
                AND tg.tag_name = %s
            )
        """
        params.append(tag_filter)

    if is_ll_filter:
        query += " AND c.is_ll = %s"
        params.append(is_ll_filter == "true")

    if is_zenkai_filter:
        query += " AND c.is_zenkai = %s"
        params.append(is_zenkai_filter == "true")

    query += """
        ORDER BY
            CASE r.rarity_name
                WHEN 'ULTRA' THEN 1
                WHEN 'SPARKING' THEN 2
                WHEN 'LEGEND' THEN 2
                WHEN 'EXTREME' THEN 3
                WHEN 'HERO' THEN 4
                ELSE 99
            END,
            c.name
    """

    cur.execute(query, params)
    rows = cur.fetchall()

    cur.close()
    conn.close()

    image_map = load_character_image_map()
    characters = [
        build_character_summary(row, image_map)
        for row in rows
    ]

    return render_template(
        "index.html",
        types=types,
        rarities=rarities,
        tags=tags,
        characters=characters
    )


@app.route("/character/<int:char_id>")
def character(char_id):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT c.char_id, c.name, t.type_name, r.rarity_name, c.is_ll, c.is_zenkai
        FROM characters c
        JOIN types t ON c.type_id = t.type_id
        JOIN rarities r ON c.rarity_id = r.rarity_id
        WHERE c.char_id = %s
    """, (char_id,))
    row = cur.fetchone()

    if row is None:
        cur.close()
        conn.close()
        return "Character not found", 404

    cur.execute("""
        SELECT tg.tag_name
        FROM charactertags ct
        JOIN tags tg ON ct.tag_id = tg.tag_id
        WHERE ct.char_id = %s
        ORDER BY tg.tag_name
    """, (char_id,))
    tags = [row[0] for row in cur.fetchall()]

    cur.execute("""
        SELECT st.stat_name, cs.stat_value
        FROM characterstats cs
        JOIN stattypes st ON cs.stat_id = st.stat_id
        WHERE cs.char_id = %s
        ORDER BY st.stat_name
    """, (char_id,))
    stats = cur.fetchall()

    cur.close()
    conn.close()

    image_map = load_character_image_map()
    character_data = build_character_detail(row, image_map)

    return render_template(
        "character.html",
        character=character_data,
        tags=tags,
        stats=stats
    )


if __name__ == "__main__":
    app.run(debug=True)