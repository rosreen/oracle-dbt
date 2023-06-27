
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
    result_df = pd.DataFrame({"Predicted": y_pred, "Actual": y_test})
    return result_df