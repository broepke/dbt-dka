with 

source as (

    select * from {{ source('hubspot', 'line_item') }}

),

renamed as (

    select
        id,
        _fivetran_deleted,
        product_id,
        property_hs_margin_acv,
        property_hs_sku,
        property_hs_arr,
        property_hs_recurring_billing_number_of_payments,
        property_hs_position_on_quote,
        property_hs_total_discount,
        property_hs_tcv,
        property_name,
        property_hs_lastmodifieddate,
        property_amount,
        property_quantity,
        property_hs_margin_arr,
        property_hs_acv,
        property_hs_product_type,
        property_hs_pre_discount_amount,
        property_hs_object_source,
        property_hs_margin,
        property_price,
        property_hs_post_tax_amount,
        property_hs_updated_by_user_id,
        property_hs_created_by_user_id,
        property_hs_margin_mrr,
        property_hs_margin_tcv,
        property_hs_mrr,
        property_hs_object_source_id,
        property_createdate,
        property_hs_object_id,
        property_hs_object_source_user_id,
        _fivetran_synced

    from source

)

select * from renamed
