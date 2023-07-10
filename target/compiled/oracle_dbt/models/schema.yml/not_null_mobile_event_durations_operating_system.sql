
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.mobile_event_durations
where operating_system is null) c where c.null_count != 0


