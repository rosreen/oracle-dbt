
    
  
    



def main():
    import oml
    import pandas as pd
    def ref(*args, **kwargs):
        refs = {"invoices": "FAWDBTCORE.invoices"}
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
        identifier = "invoice_model"
        def __repr__(self):
            return "FAWDBTCORE.invoice_model"


    class dbtObj:
        def __init__(self, load_df_function) -> None:
            self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
            self.ref = lambda *args: ref(*args, dbt_load_df_function=load_df_function)
            self.config = config
            self.this = this()
            self.is_incremental = False

    import pandas as pd
    from sklearn.ensemble import IsolationForest
    from sklearn.preprocessing import LabelEncoder
    
    import numpy as np
    from sklearn.preprocessing import OrdinalEncoder
    def model(dbt, session):
    
        dbt.config(materialized="table")
        dbt.config(async_flag=True)  # run the python function in async mode
        dbt.config(timeout=1800)  # timeout of 30 minutes
        data = dbt.ref( "invoices")
        data = data.pull()
    # Encode categorical values to numeric values
        def label_encode(df,col):
            categories = df[col].tolist()
            encoder = LabelEncoder()
            labels = encoder.fit_transform(categories)
            return labels
    
        data["HEADER_CREATED_BY_USER_ID_LABELS"] = label_encode(data,"HEADER_CREATED_BY_USER_ID")
        data["HEADER_UPDATED_BY_USER_ID_LABELS"] = label_encode(data,"HEADER_UPDATED_BY_USER_ID")
        data["FISCAL_PERIOD_SET_NAME_LABELS"] = label_encode(data,"FISCAL_PERIOD_SET_NAME")
    
        cols = ["REMAINING_GLOBAL_AMOUNT","HEADER_UPDATED_BY_USER_ID_LABELS","HEADER_CREATED_BY_USER_ID_LABELS","FISCAL_PERIOD_SET_NAME_LABELS","PAYABLES_BU_ID"]
        data = data[cols]
        data = data.dropna()
    
        # Define the features
        features = data.columns
    
        # Train the Isolation Forest model
        model = IsolationForest(n_estimators=100, contamination="auto")
        model.fit(data[features])
    
        # Predict the anomalies
        anomalies = model.predict(data[features])
    
        # Add the anomalies to the original data
        data["anomaly"] = anomalies
    
    
        return data





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

  