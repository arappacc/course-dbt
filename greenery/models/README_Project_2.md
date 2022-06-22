/*Week 2 Project
  Andre Rappaccioli
*/


Q1: What is our user repeat rate?

select distinct count(user_id)
from dbt.dbt_andre_r.stg_users
answer: 130 

Q1: What is our user repeat rate?

with users_purchases as (
select u.user_id,
count (distinct o.order_id) as num_purchases
from dbt.dbt_andre_r.stg_users u
left join dbt.dbt_andre_r.stg_orders o on o.user_id = u.user_id
group by u.user_id
),

user_stats as (
  select SUM(case when num_purchases >= 2 
            then 1 else 0 end) as repeat_users,
        SUM(case when num_purchases >= 1
            then 1 else 0 end) as users_who_purchased
  from users_purchases
)

select SUM(repeat_users) / SUM(users_who_purchased)
from user_stats

Answer = 79.84%

Q2: I really just followed the examples outlined in the project instructions and made with what made sense :)

-- PART 2 --



