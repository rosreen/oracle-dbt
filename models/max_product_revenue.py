def model(dbt, session):
    dbt.config(materialized="table")
    s_df = dbt.ref("stg_web_order_info")
    total_revenue = (s_df["PRICE"] * s_df["QUANTITY"]).sum()
    cr = session.cursor()
    _ = cr.execute("SELECT MAX(price) FROM stg_web_order_info")
    max_price = cr.fetchone()[0]

    most_expensive_product_orders = s_df[s_df["PRICE"] == max_price]
    most_expensive_product_revenue = (most_expensive_product_orders["PRICE"] * most_expensive_product_orders["QUANTITY"]).sum()
    most_expensive_product_revenue_df = pd.DataFrame([most_expensive_product_revenue], columns=["REVENUE"])

    return most_expensive_product_revenue_df