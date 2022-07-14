{% macro limit_dev_data(date_field = 'order_date' , num_days = 3) %}

    where {{ date_field }} >= date_sub(current_date, INTERVAL {{num_days}} DAY)

{% endmacro %}