"""
report_cli.py
E-Commerce Order Analytics System

Usage Examples
--------------
python report_cli.py --report revenue
python report_cli.py --report top_customers
python report_cli.py --report monthly --start 2024-01-01 --end 2024-12-31
python report_cli.py --report retention
"""

import argparse
import sqlite3
from pathlib import Path

DB_PATH = Path("database") / "ecommerce.db"

QUERIES = {
    "revenue": """
        SELECT ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)),2) AS total_revenue
        FROM orders o
        JOIN order_items oi ON o.order_id=oi.order_id;
    """,
    "top_customers": """
        SELECT
            c.customer_id,
            c.customer_name,
            ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)),2) AS revenue
        FROM customers c
        JOIN orders o ON c.customer_id=o.customer_id
        JOIN order_items oi ON o.order_id=oi.order_id
        GROUP BY c.customer_id,c.customer_name
        ORDER BY revenue DESC
        LIMIT 10;
    """,
    "retention": """
        WITH first_purchase AS (
            SELECT customer_id,
                   strftime('%Y-%m',MIN(order_date)) cohort_month
            FROM orders
            GROUP BY customer_id
        ),
        activity AS (
            SELECT o.customer_id,
                   fp.cohort_month,
                   strftime('%Y-%m',o.order_date) activity_month
            FROM orders o
            JOIN first_purchase fp
            ON o.customer_id=fp.customer_id
        )
        SELECT cohort_month,
               activity_month,
               COUNT(DISTINCT customer_id) active_customers
        FROM activity
        GROUP BY cohort_month,activity_month
        ORDER BY cohort_month,activity_month;
    """
}


def connect():
    if not DB_PATH.exists():
        raise FileNotFoundError(f"Database not found: {DB_PATH}")
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def print_table(rows):
    if not rows:
        print("No records found.")
        return

    headers = rows[0].keys()
    widths = {h: len(h) for h in headers}

    for row in rows:
        for h in headers:
            widths[h] = max(widths[h], len(str(row[h])))

    line = "+".join("-" * (widths[h] + 2) for h in headers)

    print(line)
    print(" | ".join(f"{h:<{widths[h]}}" for h in headers))
    print(line)

    for row in rows:
        print(" | ".join(f"{str(row[h]):<{widths[h]}}" for h in headers))

    print(line)


def monthly_report(conn, start, end):
    query = """
    SELECT
        strftime('%Y-%m',o.order_date) AS month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT o.customer_id) AS unique_customers,
        ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)),2) AS revenue
    FROM orders o
    JOIN order_items oi
    ON o.order_id=oi.order_id
    WHERE date(o.order_date)
    BETWEEN date(?) AND date(?)
    GROUP BY month
    ORDER BY month;
    """
    return conn.execute(query, (start, end)).fetchall()


def main():
    parser = argparse.ArgumentParser(description="E-Commerce Reporting CLI")

    parser.add_argument(
        "--report",
        required=True,
        choices=["revenue", "top_customers", "retention", "monthly"]
    )

    parser.add_argument("--start", help="YYYY-MM-DD")
    parser.add_argument("--end", help="YYYY-MM-DD")

    args = parser.parse_args()

    try:
        conn = connect()

        if args.report == "monthly":
            if not args.start or not args.end:
                raise ValueError("Monthly report requires --start and --end.")
            rows = monthly_report(conn, args.start, args.end)
        else:
            rows = conn.execute(QUERIES[args.report]).fetchall()

        print_table(rows)
        conn.close()

    except Exception as ex:
        print(f"[ERROR] {ex}")


if __name__ == "__main__":
    main()
