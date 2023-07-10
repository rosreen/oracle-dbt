
    
    

with all_values as (

    select distinct
        platform as value_field

    from FAWDBTCORE.event_counts_by_platform

),

validation_errors as (

    select
        value_field

    from all_values
    where value_field not in (
        'Web','Mobile'
    )
)

select * from(
    select count(*) as not_accepted_values from validation_errors
                 ) c where c.not_accepted_values != 0


