with 

source as (

    select * from {{ source('notion', 'users') }}

),

renamed as (

    select
        id,
        name,
        email,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
