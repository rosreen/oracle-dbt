
      insert  into  FAWDBTCORE.stg_web_order_info (ORDER_ID, PRODUCT, PRODUCT_ID, PRICE, QUANTITY, SHIPPING_CITY, ORDER_DATE, CUSTOMER_ID, CATEGORY, PAYMENT_TYPE)
    (
       select ORDER_ID, PRODUCT, PRODUCT_ID, PRICE, QUANTITY, SHIPPING_CITY, ORDER_DATE, CUSTOMER_ID, CATEGORY, PAYMENT_TYPE
       from o$pt_stg_web_order_info102417679667
    )
  