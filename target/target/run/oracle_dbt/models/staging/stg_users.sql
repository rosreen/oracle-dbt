
  
  create or replace view FAWDBTCORE.stg_users as
    with users as (

    select * from FAWDBTCORE.raw_users
),

users_cleaned as (
    SELECT DISTINCT *
    FROM users
)

select * from users_cleaned

