def model(dbt, session):
    dbt.config(materialized="table")
    raw_users_df = dbt.source("FAWDBTCORE", "raw_users")     

    cr = session.cursor()
    _ = cr.execute("SELECT MAX(user_id) FROM stg_users")
    max_user_id = cr.fetchone()[0]

    max_user_ids = raw_users_df[raw_users_df["USER_ID"] == max_user_id]

    return max_user_ids