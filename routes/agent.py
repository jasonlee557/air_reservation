from flask import Blueprint, render_template, session, redirect, url_for, flash, request
from functools import wraps
from db import get_connection

agent_bp = Blueprint("agent", __name__, url_prefix="/agent")


def agent_login_required(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if session.get("user_role") != "agent":
            return redirect(url_for("auth.login"))
        return f(*args, **kwargs)
    return wrapper


@agent_bp.route("/dashboard", methods=["GET"])
@agent_login_required
def dashboard():
    # view flights
    agent_email = session.get("user_email")

    date_from = request.args.get("date_from", "").strip()
    date_to   = request.args.get("date_to", "").strip()
    origin    = request.args.get("origin", "").strip()
    dest      = request.args.get("dest", "").strip()

    conn = get_connection()
    cur = conn.cursor(dictionary=True)

    sql = """
        SELECT f.airline_name, f.flight_num,
               f.departure_airport, f.arrival_airport,
               f.departure_time, f.arrival_time,
               f.status,
               p.customer_email,
               p.purchase_date,
               p.purchase_price,
               a_dep.airport_city AS origin_city,
               a_arr.airport_city AS dest_city
        FROM purchases AS p
        JOIN ticket AS t
          ON p.ticket_id = t.ticket_id
        JOIN flight AS f
          ON t.airline_name = f.airline_name
         AND t.flight_num   = f.flight_num
        JOIN airport AS a_dep
          ON f.departure_airport = a_dep.airport_name
        JOIN airport AS a_arr
          ON f.arrival_airport   = a_arr.airport_name
        WHERE p.booking_agent_email = %s
    """
    params = [agent_email]

    if date_from:
        sql += " AND p.purchase_date >= %s"
        params.append(date_from)
    if date_to:
        sql += " AND p.purchase_date <= %s"
        params.append(date_to)

    if origin:
        sql += " AND (a_dep.airport_name = %s OR a_dep.airport_city = %s)"
        params.extend([origin, origin])
    if dest:
        sql += " AND (a_arr.airport_name = %s OR a_arr.airport_city = %s)"
        params.extend([dest, dest])

    sql += " ORDER BY p.purchase_date DESC"

    cur.execute(sql, tuple(params))
    flights = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "agent_dashboard.html",
        flights=flights,
        date_from=date_from,
        date_to=date_to,
        origin=origin,
        dest=dest,
    )
    
@agent_bp.route("/search_flights", methods=["GET"])
@agent_login_required
def search_flights_agent():
    agent_email = session["user_email"]
    origin      = request.args.get("origin", "").strip()
    destination = request.args.get("destination", "").strip()
    date        = request.args.get("date", "").strip()

    flights = []

    if date:
        conn = get_connection()
        cur = conn.cursor(dictionary=True)

        sql = """
            SELECT f.airline_name, f.flight_num,
                   f.departure_airport, f.arrival_airport,
                   f.departure_time, f.arrival_time,
                   f.status, f.base_price,
                   f.airplane_id,
                   a1.airport_city AS origin_city,
                   a2.airport_city AS dest_city
            FROM flight AS f
            JOIN airport AS a1 ON f.departure_airport = a1.airport_name
            JOIN airport AS a2 ON f.arrival_airport   = a2.airport_name
            JOIN agent_airline_authorization AS auth
              ON auth.airline_name = f.airline_name

            WHERE DATE(f.departure_time) = %s
              AND auth.agent_email = %s
        """
        params = [date, agent_email]

        if origin:
            sql += " AND (a1.airport_name = %s OR a1.airport_city = %s)"
            params.extend([origin, origin])

        if destination:
            sql += " AND (a2.airport_name = %s OR a2.airport_city = %s)"
            params.extend([destination, destination])

        sql += " ORDER BY f.departure_time"

        cur.execute(sql, tuple(params))
        flights = cur.fetchall()

        cur.close()
        conn.close()

    return render_template(
        "search_flights.html",
        flights=flights,
        origin=origin,
        destination=destination,
        date=date,
        is_agent=True
    )