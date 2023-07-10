
    
    

select
    operating_system as unique_field,
    count(*) as n_records

from FAWDBTCORE.mobile_event_durations
where operating_system is not null
group by operating_system
having count(*) > 1


