
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.most_active_mobile_users
where num_mobile_events is null) c where c.null_count != 0


