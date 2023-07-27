from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import LabelEncoder

def model(dbt, session):
    dbt.config(materialized="table")

    s_df = dbt.source("FAWDBTCORE", "web_order_info")
    df = s_df.pull()

    X = df[["PRICE", "CATEGORY", "PAYMENT_TYPE"]]
    y = df["QUANTITY"]

    label_encoder = LabelEncoder()
    X_encoded = X.copy()
    for feature in ["CATEGORY", "PAYMENT_TYPE"]:
        X_encoded[feature] = label_encoder.fit_transform(X[feature])

    X_train, X_test, y_train, y_test = train_test_split(X_encoded, y, test_size=0.2, random_state=42)

    regressor = LinearRegression()
    regressor.fit(X_train, y_train)

    y_pred = regressor.predict(X_test)
    result_df = pd.DataFrame({"Predicted Quantity": y_pred, "Actual Quantity": y_test})
    return result_df


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
        sources = {"FAWDBTCORE.web_order_info": "FAWDBTCORE.web_order_info"}
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
        identifier = "regression"
        def __repr__(self):
            return "FAWDBTCORE.regression"


    class dbtObj:
        def __init__(self, load_df_function) -> None:
            self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
            self.ref = lambda *args: ref(*args, dbt_load_df_function=load_df_function)
            self.config = config
            self.this = this()
            self.is_incremental = False

    from sklearn.model_selection import train_test_split
    from sklearn.linear_model import LinearRegression
    from sklearn.preprocessing import LabelEncoder
    
    def model(dbt, session):
        dbt.config(materialized="table")
    
        s_df = dbt.source("FAWDBTCORE", "web_order_info")
        df = s_df.pull()
    
        X = df[["PRICE", "CATEGORY", "PAYMENT_TYPE"]]
        y = df["QUANTITY"]
    
        label_encoder = LabelEncoder()
        X_encoded = X.copy()
        for feature in ["CATEGORY", "PAYMENT_TYPE"]:
            X_encoded[feature] = label_encoder.fit_transform(X[feature])
    
        X_train, X_test, y_train, y_test = train_test_split(X_encoded, y, test_size=0.2, random_state=42)
    
        regressor = LinearRegression()
        regressor.fit(X_train, y_train)
    
        y_pred = regressor.predict(X_test)
        result_df = pd.DataFrame({"Predicted Quantity": y_pred, "Actual Quantity": y_test})
        return result_df




