with
    source as (select * from {{ ref("stg_hubspot__product") }}
    
)

select
    property_hs_sku as sku,
    property_name as name,
    property_price as price,
    property_hs_product_type as type
from source

