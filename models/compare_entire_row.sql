{{
    config(
        materialized='table'
    )
}}


{% set common_columns = dbt_utils.get_column_values(
    table=ref('diff_col_count'),
    column='column_name')
%}


with data1 as (
    select * from {{ ref('data_1') }}
),

data2 as(
    select * from {{ ref('data2') }}
),

matches as (

    {% for col in common_columns%}
    select
        '{{ col }}' as column_name,

        count(case when a.{{col}} = b.{{col}} then a.id end) as perfect_match,
        count(case when a.{{col}} != b.{{col}} and a.{{col}} is not null and b.{{col}} is not null then a.id end) as values_do_not_match,
        count(case when a.{{col}} is null and b.{{col}} is null then a.id end) as both_null,
        count(case when a.{{col}} is null and b.{{col}} is not null then a.id end) as null_in_a,
        count(case when a.{{col}} is not null and b.{{col}} is null then a.id end) as null_in_b,
        
    from data1 a
    full outer join data2 b using (id)
    ,
        
    
    {% if not loop.last %}
    union all
    {% endif %}
    {% endfor %}

)

select * from matches