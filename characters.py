import json
from pathlib import Path
from flask import Blueprint, send_from_directory, url_for


BASE_DIR = Path(__file__).resolve().parent
CHARACTER_IMAGE_ROOT = BASE_DIR / "characters_image"

CHARACTER_CUTINS_FOLDER = "card_cutins"
CHARACTER_ICONS_FOLDER = "card_icons"

CHARACTER_CUTINS_DIR = CHARACTER_IMAGE_ROOT / CHARACTER_CUTINS_FOLDER
CHARACTER_ICONS_DIR = CHARACTER_IMAGE_ROOT / CHARACTER_ICONS_FOLDER

MANIFEST_PATHS = [
    CHARACTER_CUTINS_DIR / "manifest.json",
    CHARACTER_IMAGE_ROOT / "manifest.json",
]


characters_bp = Blueprint("characters_assets", __name__)


@characters_bp.route("/characters_image/<path:filename>")
def character_image(filename):
    return send_from_directory(CHARACTER_IMAGE_ROOT, filename)


def get_manifest_path():
    for path in MANIFEST_PATHS:
        if path.exists():
            return path
    return None


def load_manifest():
    manifest_path = get_manifest_path()

    if manifest_path is None:
        print("WARN: no manifest.json found")
        return []

    try:
        with manifest_path.open("r", encoding="utf-8") as f:
            manifest = json.load(f)
    except json.JSONDecodeError as exc:
        print(f"WARN: invalid manifest JSON: {manifest_path} -> {exc}")
        return []

    if not isinstance(manifest, list):
        print(f"WARN: manifest should be a list: {manifest_path}")
        return []

    return manifest


def resolve_image_path(filename, folder_name, folder_path):
    if not filename:
        return None

    direct_path = CHARACTER_IMAGE_ROOT / filename
    if direct_path.exists():
        return filename.replace("\\", "/")

    nested_path = folder_path / filename
    if nested_path.exists():
        return f"{folder_name}/{filename}".replace("\\", "/")

    return None


def load_character_image_map():
    image_map = {}
    manifest = load_manifest()

    for item in manifest:
        if not isinstance(item, dict):
            continue

        filename = item.get("numbered_filename")

        cutin_filename = resolve_image_path(
            filename,
            CHARACTER_CUTINS_FOLDER,
            CHARACTER_CUTINS_DIR
        )

        icon_filename = resolve_image_path(
            filename,
            CHARACTER_ICONS_FOLDER,
            CHARACTER_ICONS_DIR
        )

        if not cutin_filename and not icon_filename:
            continue

        db_order = item.get("db_order")

        if db_order is None:
            db_index = item.get("db_index")
            if db_index is not None:
                db_order = int(db_index) + 1

        if db_order is None:
            download_number = item.get("download_number")
            if download_number is not None:
                db_order = int(download_number)

        if db_order is None:
            continue

        image_map[int(db_order)] = {
            "cutin": cutin_filename,
            "icon": icon_filename,
        }

    return image_map


def get_character_image_url(db_char_id, image_map, image_type):
    if db_char_id is None:
        return None

    image_data = image_map.get(int(db_char_id))

    if not image_data:
        return None

    filename = image_data.get(image_type)

    if not filename:
        return None

    return url_for("characters_assets.character_image", filename=filename)


def build_character_summary(row, image_map):
    db_char_id = row[0]

    return {
        "char_id": db_char_id,
        "name": row[1],
        "type": row[2],
        "rarity": row[3],
        "is_ll": row[4],
        "is_zenkai": row[5],
        "image_url": get_character_image_url(db_char_id, image_map, "cutin"),
        "icon_url": get_character_image_url(db_char_id, image_map, "icon"),
    }


def build_character_detail(row, image_map):
    db_char_id = row[0]

    return {
        "char_id": db_char_id,
        "name": row[1],
        "type": row[2],
        "rarity": row[3],
        "is_ll": row[4],
        "is_zenkai": row[5],
        "image_url": get_character_image_url(db_char_id, image_map, "cutin"),
        "icon_url": get_character_image_url(db_char_id, image_map, "icon"),
    }