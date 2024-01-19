with 

source as (

    select * from {{ source('notion', 'page') }}

),

renamed as (

    select
        id,
        block_id,
        url,
        created_by,
        archived,
        is_inline,
        last_edited_by,
        workspace,
        database_id,
        created_time,
        parent_page_id,
        description,
        last_edited_time,
        _fivetran_deleted,
        icon,
        cover,
        object,
        _fivetran_synced

    from source

)

select * from renamed
