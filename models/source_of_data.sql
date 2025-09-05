{%set relation = ref('source_data')%}

with data_source as(
    select
        '{{relation.include(database = false, schema = true, identifier = true)}}' as source
)

select * from data_source