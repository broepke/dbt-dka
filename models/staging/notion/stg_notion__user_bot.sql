with 

source as (

    select * from {{ source('notion', 'user_bot') }}

),

renamed as (

    select
        _fivetran_id,
        user_id,
        workspace_name,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
