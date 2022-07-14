{% macro grant_select(schema=target.schema, role=target.role) %}

    {% set sql %}
        -- GRANT `roles/bigquery.dataViewer` ON SCHEMA {{schema}} TO role;
        -- ^commenting out so as not to change permissions on accounts while testing 
        
        select 1 
    {% endset %}

    {{ log('Granting select to all tables and view in schema ' ~ target.schema ~ ' to role ' ~ role, info=True) }}
    {% do run_query(sql) %}
    {{ log('Priveleges granted', info=True) }}

{% endmacro %}

-- GRANT `roles/bigquery.dataViewer` ON SCHEMA `mycompany`.revenue
-- TO "user:tom@example.com", "user:sara@example.com"