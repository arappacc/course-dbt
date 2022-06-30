
PART 1:
<!-- select 
count(
  distinct
    case when add_to_checkout = 1 then session_id
    end
) / count(distinct session_id)
from dbt.dbt_andre_r.fct_session_events -->
conversion rate = 62%

--same query as above with the added column of product_id and a grouping by such. 

PART 2: 
Created a basic events macro within fct_session_events.sql

Part 3:



Part 4:
Installed all three packages listed in the course section, all under packages.yml.