select
      count(*) as failures,
      case when count(*) != 0 then 1 else 0 end as should_warn,
      case when count(*) != 0 then 1 else 0 end as should_error
    from (
      
    
    

select
    platform as unique_field,
    count(*) as n_records

from FAWDBTCORE.event_counts_by_platform
where platform is not null
group by platform
having count(*) > 1



      
    ) dbt_internal_test