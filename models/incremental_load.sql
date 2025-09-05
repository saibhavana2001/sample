{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

with data as(
    select * from {{ ref('data_1') }}
)


select * from data