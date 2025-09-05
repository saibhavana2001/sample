select 
    *
from {{ source('house_price2_info_schema', 'COLUMNS') }}