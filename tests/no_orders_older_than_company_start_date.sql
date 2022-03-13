select 
    order_id, 
    order_date
from {{ ref('fct_orders') }}
where order_date < '1900-01-01'