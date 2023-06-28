def model(dbt, session):

    dbt.config(materialized="incremental")

    s_df = dbt.source("FAWDBTCORE", "web_order_info")

    df = s_df.pull()

    return df