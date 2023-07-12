
  
  create or replace view FAWDBTCORE.stg_invoices as
    with invoice as (

    select * from FAWDBTCORE.invoices
)

select * from invoice

