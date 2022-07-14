select
    id as order_id,
    user_id as customer_id,
    order_date,
    status
from {{ source('jaffle_shop', 'orders') }}

{%- if target.name == 'default' -%}
{{ limit_dev_data('order_date', num_days = 1000) }}
{%- endif -%}