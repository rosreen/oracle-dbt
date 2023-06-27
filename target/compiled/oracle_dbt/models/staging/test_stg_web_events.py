# def model(dbt, session):
#     # Must be either table or incremental (view is not currently supported)
#     dbt.config(materialized="table")
#     # dbt.config(conda_env_name="dbt_py_env")
#     # oml.core.DataFrame representing a datasource
#     s_df = dbt.source('FAWDBTCORE', 'web_events')
#     return s_df


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
        sources = {}
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
        identifier = "test_stg_web_events"
        def __repr__(self):
            return "FAWDBTCORE.test_stg_web_events"


    class dbtObj:
        def __init__(self, load_df_function) -> None:
            self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
            self.ref = lambda *args: ref(*args, dbt_load_df_function=load_df_function)
            self.config = config
            self.this = this()
            self.is_incremental = False

    # def model(dbt, session):
    #     # Must be either table or incremental (view is not currently supported)
    #     dbt.config(materialized="table")
    #     # dbt.config(conda_env_name="dbt_py_env")
    #     # oml.core.DataFrame representing a datasource
    #     s_df = dbt.source('FAWDBTCORE', 'web_events')
    #     return s_df




