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