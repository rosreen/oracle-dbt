
      
  
    

  create  table FAWDBTCORE.web_events
  
  
    
  as
    

with web_events as (
    select * from FAWDBTCORE.stg_web_events
    
)

select * from web_events
  
  