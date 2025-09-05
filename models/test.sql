{# in dbt Develop #}

{% set old_etl_relation_query %}
select * from {{ ref('data_1') }}
{% endset %}


{% set new_etl_relation_query %}
select * from {{ ref('data2') }}
{% endset %}


{% set audit_query = audit_helper.compare_column_values(
    a_query=old_etl_relation_query,
    b_query=new_etl_relation_query,
    primary_key='id',
    column_to_compare=["Date_House_was_Sold", 'Sale_Price']
) %}


{% set audit_results = run_query(audit_query) %}


{% if execute %}
    {% do audit_results.print_table() %}
{% endif %}