from flask import Blueprint

staff_bp = Blueprint("staff", __name__, url_prefix="/staff")


@staff_bp.route("/")
def dashboard():
    return "Staff dashboard coming soon."
