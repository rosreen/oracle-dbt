
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.mobile_event_durations
where avg_duration is null) c where c.null_count != 0


