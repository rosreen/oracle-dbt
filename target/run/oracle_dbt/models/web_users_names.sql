
      insert  into  FAWDBTCORE.web_users_names (NAME, EVENT_TIMESTAMP)
    (
       select NAME, EVENT_TIMESTAMP
       from o$pt_web_users_names123846293464
    )
  