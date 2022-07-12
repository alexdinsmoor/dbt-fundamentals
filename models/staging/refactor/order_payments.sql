with final as (
    select 
        order_id
        , max(created_at) as payment_finalized_date
        , sum(amount) as total_amount_paid
    from {{ ref('stg_payments') }}
    where STATUS <> 'fail'
    group by 1
)

select * from final 