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
        b.id as destination_column
    from data1 a
    full outer join data2 b
    using (id)
    where b.id is null
)

select * from value_missing
