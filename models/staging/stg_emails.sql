with emails as (

    select * from {{ ref('raw_emails') }}
),

renamed_emails as (

    select
        user_id,
        email as email_address

    from emails

)

select * from renamed_emails

