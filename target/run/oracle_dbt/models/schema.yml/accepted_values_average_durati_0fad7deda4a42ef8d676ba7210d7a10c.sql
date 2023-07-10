select
      count(*) as failures,
      case when count(*) != 0 then 1 else 0 end as should_warn,
      case when count(*) != 0 then 1 else 0 end as should_error
    from (
      
    
    

with all_values as (

    select distinct
        country as value_field

    from FAWDBTCORE.average_duration_by_platform_country

),

validation_errors as (

    select
        value_field

    from all_values
    where value_field not in (
        'USA','UK','Germany','Canada','Mexico','China','India'
    )
)

select * from(
    select count(*) as not_accepted_values from validation_errors
                 ) c where c.not_accepted_values != 0



      
    ) dbt_internal_test