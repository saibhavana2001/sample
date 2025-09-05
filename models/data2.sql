select 
    *
from {{ source('house_price2', 'house_price') }}