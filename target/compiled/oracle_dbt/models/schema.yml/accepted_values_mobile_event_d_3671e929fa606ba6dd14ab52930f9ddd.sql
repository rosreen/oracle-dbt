
    
    

with all_values as (

    select distinct
        operating_system as value_field

    from FAWDBTCORE.mobile_event_durations

),

validation_errors as (

    select
        value_field

    from all_values
    where value_field not in (
        'iOS','Windows','Android','Linux'
    )
)

select * from(
    select count(*) as not_accepted_values from validation_errors
                 ) c where c.not_accepted_values != 0


