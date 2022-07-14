-- example of using a macro to union tables (e.g. combining x sharded event tables)

-- variables

{% set event_dates = ['20220712','20220711'] %}

-- 
with 
{% for event_date in event_dates %}
events_{{event_date}} as (
    -- dummy table creation 
    select * from {{ ref('stg_payments') }} limit 10
),
{% endfor %}

final as (

    {% for event_date in event_dates -%}
        select * from events_{{event_date}} {% if not loop.last %} union all {% endif %}             
    {% endfor %}

)

select * from final

