with paid_orders as (
    
    select * from {{ ref('paid_order_details') }}

),

final as (
    select
    paid_orders.*,

    -- customer journey analysis 
    ROW_NUMBER() OVER (ORDER BY order_id) as transaction_seq,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_id) as customer_sales_seq,

    -- customer lifetime metrics
    SUM(total_amount_paid) OVER (PARTITION BY customer_id ORDER BY order_id ) as customer_lifetime_value,
    MIN(order_placed_at) OVER (PARTITION BY customer_id) as fdos,
    MAX(order_placed_at) OVER (PARTITION BY customer_id) as most_recent_order_date,
    COUNT(order_id) OVER (PARTITION BY customer_id) as customer_lifetime_alltime,

    CASE WHEN 
        MIN(order_placed_at) OVER (PARTITION BY customer_id)
        = order_placed_at THEN 'new' ELSE 'return' 
    END as nvsr,

    FROM paid_orders 
)

select * from final 