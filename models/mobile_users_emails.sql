{{
    config(
        materialized='incremental'
        )
}}

with start_mobile_events_cleaned as (

    select * from {{ ref('stg_mobile_events') }}
),


start_emails_cleaned as (

    select * from {{ ref('stg_emails') }}
),

mobile_users_emails as (
    select start_emails_cleaned.email_address, start_emails_cleaned.user_id, start_mobile_events_cleaned.event_timestamp
    from start_emails_cleaned
    join start_mobile_events_cleaned on start_mobile_events_cleaned.user_id = start_emails_cleaned.user_id
)

select * from mobile_users_emails

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
where event_timestamp >= (select max(event_timestamp) from {{ this }})

{% endif %}