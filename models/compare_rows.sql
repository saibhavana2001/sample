with data1 as(
    select * from {{ ref('data_1') }}
),


data2 as(
    select * from {{ ref('data2') }}
),

data1_meta_data as(
    select * from {{ ref('meta_data_1') }}
),

data2_meta_data as(
    select * from {{ ref('meta_data_2') }}
),

common_columns as(
    select 
        COLUMN_NAME 
    from data1_meta_data
    where table_name like 'HOUSE_PRICE' and 
    COLUMN_NAME in (select COLUMN_NAME
                           from data2_meta_data)
),

perfect_match as(
    select 
        'date_house_was_sold' column_name,
        count(a.id) perfect_match
    from data1 a
    full outer join data2 b
    using (id)
    where a.date_house_was_sold = b.date_house_was_sold 
) ,

not_matched as(
    select 
        'date_house_was_sold' column_name,
        count(a.id) not_perfect_match
    from data1 a
    full outer join data2 b
    using (id)
    where a.date_house_was_sold != b.date_house_was_sold
),

both_null as(
    select 
    'date_house_was_sold' column_name,
    count(a.id) both_null
    from data1 a
    full outer join data2 b
    using (id)
    where a.date_house_was_sold is null and b.date_house_was_sold is null
),

null_in_a as(
    select 
    'date_house_was_sold' column_name,
    count(a.id) null_in_a from data1 a
    full outer join data2 b
    on a.id = b.id
    where a.date_house_was_sold is null and b.date_house_was_sold is not null and a.id = b.id
),

null_in_b as(
    select 
    'date_house_was_sold' column_name,
    count(a.id) null_in_b from data1 a
    full outer join data2 b
    on a.id = b.id
    where a.date_house_was_sold is not null and b.date_house_was_sold is null and a.id = b.id
),

data_compare as(
    select * from perfect_match
    join not_matched
    using (column_name)
    join both_null
    using (column_name)
    join null_in_a
    using (column_name)
    join null_in_b
    using (column_name)
)

select * from data_compare