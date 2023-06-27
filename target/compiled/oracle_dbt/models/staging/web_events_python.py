from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeClassifier
def model(dbt, session):

    dbt.config(materialized="table")

    s_df = dbt.source("FAWDBTCORE", "web_order_info")
    df = s_df.pull()

    x = df[["PRICE"]]  
    y = df["SHIPPING_CITY"]  

    label_encoder = LabelEncoder()
    y_encoded = label_encoder.fit_transform(y)

    X_train, X_test, y_train, y_test = train_test_split(x, y_encoded, test_size=0.2, random_state=42)
    classifier = DecisionTreeClassifier()
    classifier.fit(X_train, y_train)

    y_pred = classifier.predict(X_test)

    y_pred_decoded = label_encoder.inverse_transform(y_pred)

    accuracy = classifier.score(X_test, y_test)
    res_df  = pd.DataFrame(data={"Shipping_City_Prediction": y_pred_decoded, "Shipping_City_Actual": label_encoder.inverse_transform(y_test)})

    return res_df


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
        identifier = "web_events_python"
        def __repr__(self):
            return "FAWDBTCORE.web_events_python"


    class dbtObj:
        def __init__(self, load_df_function) -> None:
            self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
            self.ref = lambda *args: ref(*args, dbt_load_df_function=load_df_function)
            self.config = config
            self.this = this()
            self.is_incremental = False

    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import LabelEncoder
    from sklearn.tree import DecisionTreeClassifier
    def model(dbt, session):
    
        dbt.config(materialized="table")
    
        s_df = dbt.source("FAWDBTCORE", "web_order_info")
        df = s_df.pull()
    
        x = df[["PRICE"]]  
        y = df["SHIPPING_CITY"]  
    
        label_encoder = LabelEncoder()
        y_encoded = label_encoder.fit_transform(y)
    
        X_train, X_test, y_train, y_test = train_test_split(x, y_encoded, test_size=0.2, random_state=42)
        classifier = DecisionTreeClassifier()
        classifier.fit(X_train, y_train)
    
        y_pred = classifier.predict(X_test)
    
        y_pred_decoded = label_encoder.inverse_transform(y_pred)
    
        accuracy = classifier.score(X_test, y_test)
        res_df  = pd.DataFrame(data={"Shipping_City_Prediction": y_pred_decoded, "Shipping_City_Actual": label_encoder.inverse_transform(y_test)})
    
        return res_df




