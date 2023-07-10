
    
  
    



def main():
    import oml
    import pandas as pd
    def ref(*args, **kwargs):
        refs = {"stg_web_order_info": "FAWDBTCORE.stg_web_order_info"}
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
        identifier = "max_product_revenue"
        def __repr__(self):
            return "FAWDBTCORE.max_product_revenue"


    class dbtObj:
        def __init__(self, load_df_function) -> None:
            self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
            self.ref = lambda *args: ref(*args, dbt_load_df_function=load_df_function)
            self.config = config
            self.this = this()
            self.is_incremental = False

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





    def materialize(df, table, session):
        if isinstance(df, pd.core.frame.DataFrame):
           oml.create(df, table=table)
        elif isinstance(df, oml.core.frame.DataFrame):
           df.materialize(table=table)

    dbt = dbtObj(load_df_function=oml.sync)
    final_df = model(dbt, session=oml)

    
    
    table_name = f"{dbt.this.identifier}__dbt_tmp"
    
    materialize(final_df, table=table_name.upper(), session=oml)
    return pd.DataFrame.from_dict({"result": [1]})

  