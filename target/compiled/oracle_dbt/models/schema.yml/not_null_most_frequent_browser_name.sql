
    
    

select * from (
select count(*) as null_count
from FAWDBTCORE.most_frequent_browser
where name is null) c where c.null_count != 0


