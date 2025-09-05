with data_1_meta as (
    select * from Database1.dbt_svandanapu.meta_data_1
),

meta_data_2 as (
    select * from Database1.dbt_svandanapu.meta_data_2
),

diff_data_type as (
    select 
        a.table_catalog as table_catalog_1,
        a.column_name as column_name_1,
        a.data_type as data_type_1,
        b.table_catalog as table_catalog_2,
        b.column_name as column_name_2,
        b.data_type as data_type_2
    from data_1_meta a
    join meta_data_2 b
        on a.column_name = b.column_name
    where a.data_type != b.data_type
      and a.table_name like 'HOUSE_PRICE'
)

select * from diff_data_type
