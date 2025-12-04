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
        # Accept either "username(email)" (current form) or legacy "email"
        email = request.form.get("username(email)", "").strip() or request.form.get("email", "").strip()
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
    
    # GET request: show registration form
    return render_template("register.html")




@auth_bp.route("/login", methods=["GET", "POST"])
def login():
    # preserve search filters if the user came from the search results page
    search_origin = request.args.get("origin", "").strip()
    search_destination = request.args.get("destination", "").strip()
    search_date = request.args.get("date", "").strip()

    if request.method == "POST":
        email = request.form.get("email", "").strip()
        password = request.form.get("password", "").strip()
        # grab any forwarded search filters from hidden form fields
        search_origin = request.form.get("origin", search_origin).strip()
        search_destination = request.form.get("destination", search_destination).strip()
        search_date = request.form.get("date", search_date).strip()
        
        # validation
        if email == "" or password == "":
            flash("Please fill in all fields.")
            return redirect(url_for("auth.login"))
        
        # connect to db
        conn = get_connection()
        cur = conn.cursor(dictionary=True)
        
        try:
            # customer
            cur.execute("SELECT * FROM customer WHERE email = %s;", (email,))
            user = cur.fetchone()
            
            if user is not None:
                if not bcrypt.check_password_hash(user["password"], password):
                    flash("Invalid email or password.")
                    return redirect(url_for("auth.login"))
                
                session.clear()
                session["user_email"] = user["email"]
                session["user_name"] = user["name"]
                session["user_role"] = "customer"

                flash("Login successful.")
                if search_date:
                    return redirect(url_for("search_flights.search_flights",
                                            origin=search_origin,
                                            destination=search_destination,
                                            date=search_date))
                return redirect(url_for("customer.dashboard"))

            # agent
            cur.execute("SELECT * FROM booking_agent WHERE email = %s;", (email,))
            user = cur.fetchone()
            
            if user is not None:
                if not bcrypt.check_password_hash(user["password"], password):
                    flash("Invalid email or password.")
                    return redirect(url_for("auth.login"))
                
                session.clear()
                session["user_email"] = user["email"]
                session["user_name"] = user["email"]
                session["user_role"] = "agent"

                flash("Login successful.")
                if search_date:
                    return redirect(url_for("search_flights.search_flights",
                                            origin=search_origin,
                                            destination=search_destination,
                                            date=search_date))
                return redirect(url_for("agent.dashboard"))
            
            # staff
            cur.execute("SELECT * FROM airline_staff WHERE username = %s;", (email,))
            user = cur.fetchone()
            
            if user is not None:
                if not bcrypt.check_password_hash(user["password"], password):
                    flash("Invalid username or password.")
                    return redirect(url_for("auth.login"))
                
                session.clear()
                session["user_id"] = user["username"]
                session["airline_name"] = user["airline_name"]
                session["user_role"] = user["role"]
                session["firstname"] = user["first_name"]
                session["lastname"] = user["last_name"]
                flash("Login successful.")
                return redirect(url_for("staff.dashboard"))
            
        finally:
            cur.close()
            conn.close()
    
    # GET request: show login form
    return render_template(
        "login.html",
        origin=search_origin,
        destination=search_destination,
        date=search_date,
    )


@auth_bp.route("/logout")
def logout():
    session.clear()
    flash("Logged out.")
    return redirect(url_for("customer.index"))
