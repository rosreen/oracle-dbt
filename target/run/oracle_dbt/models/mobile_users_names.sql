
      insert  into  FAWDBTCORE.mobile_users_names (NAME, EVENT_TIMESTAMP)
    (
       select NAME, EVENT_TIMESTAMP
       from o$pt_mobile_users_names123821290608
    )
  