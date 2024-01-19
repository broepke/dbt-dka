with 

source as (

    select * from {{ source('hubspot', 'contact_company') }}

),

renamed as (

    select
        contact_id,
        company_id,
        type_id,
        _fivetran_synced

    from source

)

select * from renamed
