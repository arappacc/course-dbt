/*Week 1 Project
  Andre Rappaccioli
*/

1. Number of Users: 
Answer = 130

Query:
select distinct count(user_id)
from dbt.dbt_andre_r.stg_users

2. Orders Per Hour:
Answer = 7.52

Query:
with orders_per_hour as (
    select date_part('hour',created_at) || '-' || date_part('day',created_at) as unique_hour,
    count(order_id) as orders_received
    from dbt.dbt_andre_r.stg_orders
    group by unique_hour)

select SUM(orders_received)/count(distinct unique_hour) 
from orders_per_hour

3. Time to Delivery
Answer = 3 days, 21 hours

Query:
with time_to_deliver as (
 select delivered_at - created_at as delivery_time,
 order_id
 from dbt.dbt_andre_r.stg_orders)

select avg(delivery_time)
from time_to_deliver

4. Purchases by User
Answer: 1 = 25, 2 = 28, 3+ = 71

Query:
with purchases_by_user as (
 select u.user_id,
 count(distinct o.order_id) as num_purchases
 from dbt.dbt_andre_r.stg_users u
 left join dbt.dbt_andre_r.stg_orders o on u.user_id = o.user_id
group by u.user_id
)

select num_purchases,
count(user_id)
from purchases_by_user
group by num_purchases
order by num_purchases asc

5. Sessions Per Hour:
Answer = 16.3

Query:
with sessions_per_hour as (
    select date_part('hour',e.created_at) || '-' || date_part('day',e.created_at) as session_hour,
    count(distinct e.session_id) as num_sessions
    from dbt.dbt_andre_r.stg_events e
    group by session_hour
)

select SUM(num_sessions) / count(distinct session_hour)
from sessions_per_hour