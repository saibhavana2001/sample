select 
    * 
from {{ source('house_price1_info_schema', 'COLUMNS') }}