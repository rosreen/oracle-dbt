select
      count(*) as failures,
      case when count(*) != 0 then 1 else 0 end as should_warn,
      case when count(*) != 0 then 1 else 0 end as should_error
    from (
      
    
    

select
    operating_system as unique_field,
    count(*) as n_records

from FAWDBTCORE.mobile_event_durations
where operating_system is not null
group by operating_system
having count(*) > 1



      
    ) dbt_internal_test