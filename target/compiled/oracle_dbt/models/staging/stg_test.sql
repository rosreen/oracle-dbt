

select * from FAWDBTCORE.web_events_test






  -- this filter will only be applied on an incremental run
where FAWDBTCORE.web_events_test.event_timestamp >= (select max(event_timestamp) from FAWDBTCORE.stg_test)

