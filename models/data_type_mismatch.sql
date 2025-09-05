{% set source_column_name = 'Condition_of_the_House'%}

{% set dest_column_name = 'Condition_of_the_House'%}

{%set relation1 = ref('data_1')%}

{%set relation2 = ref('data2')%}

{%set source_column_type = get_data_type(relation1, source_column_name)%}


with data1 as(
    select * from {{ relation1 }}
),

data2 as(
    select * from {{ relation2 }}
),
not_matching as(
    select 
        a.{{ source_column_name }} source_field,
        b.{{dest_column_name}} dest_field,
        count(*) as diff_col_data_count
    from data1 a
    full join data2 b
    using (id)
    {%if source_column_type | upper == 'TIMESTAMP_NTZ'%}
    where TO_TIMESTAMP(a.{{source_column_name}}) != TO_TIMESTAMP(b.{{dest_column_name}})
    {%else%}
    where a.{{source_column_name}} != b.{{dest_column_name}}
    {%endif%}
    group by a.{{source_column_name}}, b.{{dest_column_name}}
)

select * from not_matching
