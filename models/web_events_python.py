from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeClassifier
def model(dbt, session):

    dbt.config(materialized="table")

    s_df = dbt.ref( "stg_web_order_info")
    df = s_df.pull()

    x = df[["ORDER_ID", "PRODUCT_ID", "PRICE" , "QUANTITY", "CUSTOMER_ID"]]  
    y = df["SHIPPING_CITY"]  

    label_encoder = LabelEncoder()
    y_encoded = label_encoder.fit_transform(y)

    X_train, X_test, y_train, y_test = train_test_split(x, y_encoded, test_size=0.2, random_state=42)
    classifier = DecisionTreeClassifier()
    classifier.fit(X_train, y_train)

    y_pred = classifier.predict(x)

    y_pred_decoded = label_encoder.inverse_transform(y_pred)

    accuracy = classifier.score(X_test, y_test)
    #res_df  = pd.DataFrame(data={"Shipping_City_Prediction": y_pred_decoded, "Shipping_City_actual": label_encoder.inverse_transform(y_test)})
    df["Shipping_City_Prediction"] = y_pred_decoded
    
    return df