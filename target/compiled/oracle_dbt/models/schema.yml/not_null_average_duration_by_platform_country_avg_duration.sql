
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.average_duration_by_platform_country
where avg_duration is null) c where c.null_count != 0


