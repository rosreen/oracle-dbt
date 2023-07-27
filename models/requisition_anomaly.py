import pandas as pd
from sklearn.ensemble import IsolationForest
from sklearn.preprocessing import LabelEncoder

import numpy as np
from sklearn.preprocessing import OrdinalEncoder
def model(dbt, session):

    dbt.config(materialized="table")
    dbt.config(async_flag=True)  # run the python function in async mode
    dbt.config(timeout=1800)  # timeout of 30 minutes
    data = dbt.source("FAWDBTCORE", "requisitions")
    data = data.pull()
    df = data.dropna(axis = 1, how = "any")
    df = df.dropna(axis = 0, how = "all")
    #df = df.dropna()
    cat = df.select_dtypes(include="object").columns.tolist()

    df[cat]=df[cat].astype("str")
    data = df.apply(LabelEncoder().fit_transform)
    data = data.loc[:, (df != 0).any(axis=0)]
    features = data.columns

    # Train the Isolation Forest model
    model = IsolationForest(n_estimators=100, contamination="auto")
    model.fit(data[features])

    # Predict the anomalies
    anomalies = model.predict(data[features])

    # Add the anomalies to the original data
    data["anomaly"] = anomalies

    # Print the anomalies
    res_df = data[data["anomaly"] == -1]


    return data