def model(dbt, session):
    dbt.config(materialized="table")
    df = dbt.ref("stg_web_order_info")
    df = df.pull()
    
    return df
