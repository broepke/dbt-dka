with 

source as (

    select * from {{ source('hubspot', 'deal_company') }}

),

renamed as (

    select
        deal_id,
        company_id,
        type_id,
        _fivetran_synced

    from source

)

select * from renamed
