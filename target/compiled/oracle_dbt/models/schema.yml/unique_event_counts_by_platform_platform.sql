
    
    

select
    platform as unique_field,
    count(*) as n_records

from FAWDBTCORE.event_counts_by_platform
where platform is not null
group by platform
having count(*) > 1


