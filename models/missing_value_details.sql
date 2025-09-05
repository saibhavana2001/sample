{% set source_column_name = 'Date_House_was_Sold' %}

{% set dest_column_name = 'Date_House_was_Sold' %}

with data1 as(
    select * from {{ ref('data_1') }}
),

data2 as(
    select * from {{ ref('data2') }}
),
value_missing as(
    select 
        a.id as source_column,
        b.id as destination_column,
        case when a.id is null then 'Source' 
             when b.id is null then 'Destination'
        end as missing_table
    from data1 a
    full outer join data2 b
    using (id)
    where a.id is null or b.id is null
)

select * from value_missing
