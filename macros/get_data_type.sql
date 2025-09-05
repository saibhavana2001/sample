{% macro get_data_type(table_name, column_name)%}
{% set columns = adapter.get_columns_in_relation(table_name) %}
{%for i in columns%}
{%if i.name == column_name%}
{{return (i.data_type)}}
{%endif%}
{%endfor%}
{%endmacro%}