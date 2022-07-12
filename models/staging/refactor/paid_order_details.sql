
with orders as (
 select * from {{ ref('stg_orders') }}   
),

order_payments as (
 select * from {{ ref('order_payments') }}
),

customers as (
 select * from {{ ref('stg_customers') }}   
),

final as (

 select 
        -- these renames should actually happen in the staging tables
        -- didn't do that here since it's commingled with the order fundamentals model
        orders.order_id,
        orders.customer_id,
        orders.ORDER_DATE AS order_placed_at,
        orders.STATUS AS order_status,
        p.total_amount_paid,
        p.payment_finalized_date,
        C.first_name as customer_first_name,
        C.last_name as customer_last_name
    FROM orders
    left join order_payments
        p ON orders.order_id = p.order_id
    left join customers C on orders.customer_id = C.customer_id 

)

select * from final 