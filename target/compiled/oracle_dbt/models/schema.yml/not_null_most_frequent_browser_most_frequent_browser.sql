
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.most_frequent_browser
where most_frequent_browser is null) c where c.null_count != 0


