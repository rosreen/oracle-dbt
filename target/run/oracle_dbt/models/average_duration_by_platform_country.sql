
      merge  into FAWDBTCORE.average_duration_by_platform_country DBT_INTERNAL_DEST
          using o$pt_average_duration_by_platform_country165346443980 DBT_INTERNAL_SOURCE
          on (
            DBT_INTERNAL_SOURCE.EVENT_ID = DBT_INTERNAL_DEST.EVENT_ID
        )
        when matched then
          update set
          DBT_INTERNAL_DEST.PLATFORM = DBT_INTERNAL_SOURCE.PLATFORM, 
          DBT_INTERNAL_DEST.COUNTRY = DBT_INTERNAL_SOURCE.COUNTRY, 
          DBT_INTERNAL_DEST.EVENT_TIMESTAMP = DBT_INTERNAL_SOURCE.EVENT_TIMESTAMP, 
          DBT_INTERNAL_DEST.AVG_DURATION = DBT_INTERNAL_SOURCE.AVG_DURATION
          when not matched then
          insert(PLATFORM, COUNTRY, EVENT_TIMESTAMP, AVG_DURATION)
          values(
            DBT_INTERNAL_SOURCE.PLATFORM, 
            DBT_INTERNAL_SOURCE.COUNTRY, 
            DBT_INTERNAL_SOURCE.EVENT_TIMESTAMP, 
            DBT_INTERNAL_SOURCE.AVG_DURATION
            )
  