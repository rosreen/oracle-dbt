select
      count(*) as failures,
      case when count(*) != 0 then 1 else 0 end as should_warn,
      case when count(*) != 0 then 1 else 0 end as should_error
    from (
      
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.average_duration_by_platform_country
where platform is null) c where c.null_count != 0



      
    ) dbt_internal_test