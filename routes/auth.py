from flask import Blueprint, redirect, url_for, session, flash, request, render_template
from flask_bcrypt import Bcrypt
from db import get_connection

auth_bp = Blueprint("auth", __name__, url_prefix="/auth")

# create bcrypt ob
bcrypt = Bcrypt()

@auth_bp.record_once
def init_bcrypt(setup_state):
    # attach bcryp
    bcrypt.init_app(setup_state.app)
    
@auth_bp.route("/register", methods=["GET", "POST"])
def register():
    # use post when sending sensitive info
    if request.method == "POST":
        email = request.form.get("email", "").strip()
        name = request.form.get("name", "").strip()
        password = request.form.get("password", "").strip()
        confirm = request.form.get("confirm", "").strip()
        
        # validation
        if email == "" or name == "" or password == "" or confirm == "":
            flash("Please fill in all fields.")
            return redirect(url_for("auth.register"))
        
        if password != confirm:
            flash("Passwords do not match.")
            return redirect(url_for("auth.register"))
        
        # connect to db
        conn = get_connection()
        cur = conn.cursor()
        
        # check email
        cur.execute("SELECT COUNT(*) FROM Customer WHERE email = %s;", (email,))
        if cur.fetchone()[0] > 0:
            flash("Email already registered.")
            cur.close()
            conn.close()
            return redirect(url_for("auth.register"))
        
        # hash password
        pwd_hash = bcrypt.generate_password_hash(password).decode("utf-8")
        
        # insert user
        sql = """
            INSERT INTO customer
                (email, name, password,
                    building_number, street, city, state,
                    phone_number, passport_number, passport_expiration,
                    passport_country, date_of_birth)
            VALUES
                (%s, %s, %s,
                    %s, %s, %s, %s,
                    %s, %s, %s,
                    %s, %s)
        """
        
        params = (
                email, name, pwd_hash,
                "0", "", "", "",
                "", "", "2030-01-01",
                "", "2000-01-01",
            )
        cur.execute(sql, params)
        conn.commit()
        cur.close()
        conn.close()
        flash("Registration successful. Please log in.")
        return redirect(url_for("auth.login"))
    return render_template("register.html")




@auth_bp.route("/login")
def login():
    flash("Login coming soon.")
    return redirect(url_for("customer.index"))


@auth_bp.route("/logout")
def logout():
    session.clear()
    flash("Logged out.")
    return redirect(url_for("customer.index"))
