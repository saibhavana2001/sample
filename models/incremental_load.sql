{{
    config(
        materialized='incremental', --model materialization 
        unique_key='id'  -- primary key of the table
    )
}}

with data as(
    select * from {{ ref('data_1') }}
)


select * from data