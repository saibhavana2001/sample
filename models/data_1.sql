select 
    *
from {{ source('house_price1', 'house_price') }}