def model(dbt, session):
    dbt.config(materialized="table")
    raw_users_df = dbt.source("FAWDBTCORE", "raw_users")     

    cr = session.cursor()
    _ = cr.execute("SELECT MAX(user_id) FROM stg_users")
    max_user_id = cr.fetchone()[0]

    max_user_ids = raw_users_df[raw_users_df["USER_ID"] == max_user_id]

    return max_user_ids


def main():
    import oml
    import pandas as pd
    def ref(*args, **kwargs):
        refs = {}
        key = ".".join(args)
        version = kwargs.get("v") or kwargs.get("version")
        if version:
            key += f".v{version}"
        schema, table = refs[key].split(".")
        # Use oml.sync(schema=schema, table=table)
        dbt_load_df_function = kwargs.get("dbt_load_df_function")
        return dbt_load_df_function(schema=schema.upper(), table=table.upper())


    def source(*args, dbt_load_df_function):
        sources = {"FAWDBTCORE.raw_users": "FAWDBTCORE.raw_users"}
        key = ".".join(args)
        schema, table = sources[key].split(".")
        # Use oml.sync(schema=schema, table=table)
        return dbt_load_df_function(schema=schema.upper(), table=table.upper())


    config_dict = {}


    class config:
        def __init__(self, *args, **kwargs):
            pass

        @staticmethod
        def get(key, default=None):
            return config_dict.get(key, default)

    class this:
        """dbt.this() or dbt.this.identifier"""
        database = "None"
        schema = "FAWDBTCORE"
        identifier = "highest_user_id-1"
        def __repr__(self):
            return "FAWDBTCORE.highest_user_id-1"


    class dbtObj:
        def __init__(self, load_df_function) -> None:
            self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
            self.ref = lambda *args: ref(*args, dbt_load_df_function=load_df_function)
            self.config = config
            self.this = this()
            self.is_incremental = False

    def model(dbt, session):
        dbt.config(materialized="table")
        raw_users_df = dbt.source("FAWDBTCORE", "raw_users")     
    
        cr = session.cursor()
        _ = cr.execute("SELECT MAX(user_id) FROM stg_users")
        max_user_id = cr.fetchone()[0]
    
        max_user_ids = raw_users_df[raw_users_df["USER_ID"] == max_user_id]
    
        return max_user_ids




