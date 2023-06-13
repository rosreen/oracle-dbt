{{
    config(
        materialized='incremental',
        unique_key='event_id'
        )
}}

select * from {{ source('FAWDBTCORE', 'web_events_test') }}



{% if is_incremental() %}
{{ log("This is an incremental run", info=True) }}

  -- this filter will only be applied on an incremental run
where {{ source('FAWDBTCORE', 'web_events_test') }}.event_timestamp >= (select max(event_timestamp) from {{ this }})

{% endif %}
