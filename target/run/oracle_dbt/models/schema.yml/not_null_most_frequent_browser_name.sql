select
      count(*) as failures,
      case when count(*) != 0 then 1 else 0 end as should_warn,
      case when count(*) != 0 then 1 else 0 end as should_error
    from (
      
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.most_frequent_browser
where name is null) c where c.null_count != 0



      
    ) dbt_internal_test