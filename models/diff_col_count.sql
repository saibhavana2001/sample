with data_1_meta as(
    select * from {{ ref('meta_data_1') }}
),

meta_data_2 as(
    select * from {{ ref('meta_data_2') }}
),

diff_columns as(
    select column_name from meta_data_1
    where table_name like 'HOUSE_PRICE' and column_name in (
        select column_name from meta_data_2
        where table_name like 'HOUSE_PRICE'
    )
)


select * from diff_columns
