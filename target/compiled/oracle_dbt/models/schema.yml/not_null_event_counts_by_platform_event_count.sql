
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.event_counts_by_platform
where event_count is null) c where c.null_count != 0


