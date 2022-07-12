 check 1: look for any rows that are different between the legacy and new model

 {# in dbt Develop #}

 {% set old_etl_relation= ref('legacy_customer_orders') %}

 {% set dbt_relation=ref('customer_orders') %}

 {{ audit_helper.compare_relations(
     a_relation=old_etl_relation,
     b_relation=dbt_relation,
     exclude_columns=["customer_lifetime_alltime", "most_recent_order_date"],
     primary_key="order_id"
 ) }}
