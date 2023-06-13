
      merge  into FAWDBTCORE.stg_test DBT_INTERNAL_DEST
          using o$pt_stg_test141745081994 DBT_INTERNAL_SOURCE
          on (
            DBT_INTERNAL_SOURCE.EVENT_ID = DBT_INTERNAL_DEST.EVENT_ID
        )
        when matched then
          update set
          DBT_INTERNAL_DEST.EVENT_TYPE = DBT_INTERNAL_SOURCE.EVENT_TYPE, 
          DBT_INTERNAL_DEST.EVENT_TIMESTAMP = DBT_INTERNAL_SOURCE.EVENT_TIMESTAMP, 
          DBT_INTERNAL_DEST.USER_ID = DBT_INTERNAL_SOURCE.USER_ID
          when not matched then
          insert(EVENT_ID, EVENT_TYPE, EVENT_TIMESTAMP, USER_ID)
          values(
            DBT_INTERNAL_SOURCE.EVENT_ID, 
            DBT_INTERNAL_SOURCE.EVENT_TYPE, 
            DBT_INTERNAL_SOURCE.EVENT_TIMESTAMP, 
            DBT_INTERNAL_SOURCE.USER_ID
            )
  