with 

source as (

    select * from {{ source('hubspot', 'line_item_deal') }}

),

renamed as (

    select
        line_item_id,
        deal_id,
        type_id,
        _fivetran_synced

    from source

)

select * from renamed
