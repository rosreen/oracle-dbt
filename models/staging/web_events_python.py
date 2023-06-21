def model(dbt, session):
    # Must be either table or incremental (view is not currently supported)
    dbt.config(materialized="table")
    # dbt.config(conda_env_name="dbt_py_env")
    # oml.core.DataFrame representing a datasource
    s_df = dbt.source("FAWDBTCORE", "raw_users")
    #s_df = s_df.pull()
    med = s_df["USER_ID"].median()

    diff = (s_df["USER_ID"] - med)

    s_df = s_df.concat({"diff_col": diff})

    return s_df