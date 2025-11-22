from flask import Blueprint

agent_bp = Blueprint("agent", __name__, url_prefix="/agent")


@agent_bp.route("/")
def dashboard():
    return "Agent dashboard coming soon."
