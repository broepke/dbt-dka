with 

source as (

    select * from {{ source('hubspot', 'product') }}

),

renamed as (

    select
        id,
        portal_id,
        _fivetran_deleted,
        property_hs_sku,
        property_price,
        property_createdate,
        property_hs_lastmodifieddate,
        property_hs_object_id,
        property_hs_updated_by_user_id,
        property_hs_created_by_user_id,
        property_hs_product_type,
        property_hs_object_source,
        property_hs_object_source_user_id,
        property_name,
        _fivetran_synced

    from source

)

select * from renamed
