{% set source_column_name = 'Date_House_was_Sold'%}

{% set dest_column_name = 'Date_House_was_Sold'%}

with data1 as(
    select * from {{ ref('data_1') }}
),

data2 as(
    select * from {{ ref('data2') }}
),
not_matching as(
    select 
        a.{{ source_column_name }} source_field,
        b.{{dest_column_name}} dest_field,
        count(*) as diff_col_data_count
    from data1 a
    full join data2 b
    using (id)
    case when TYPEOF(a.{{source_column_name}}) = ''
    where a.{{source_column_name}} != b.{{dest_column_name}}
    --where TO_TIMESTAMP(a.{{source_column_name}}) != TO_TIMESTAMP(b.{{dest_column_name}})
    group by a.{{source_column_name}}, b.{{dest_column_name}}
)

select * from not_matching