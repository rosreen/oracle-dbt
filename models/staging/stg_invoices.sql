with invoice as (

    select * from {{ ref('invoices') }}
)

select * from invoice

