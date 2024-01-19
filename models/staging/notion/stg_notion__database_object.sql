with 

source as (

    select * from {{ source('notion', 'database_object') }}

),

renamed as (

    select
        id,
        block_id,
        url,
        page_id,
        created_by,
        archived,
        is_inline,
        parent_database_id,
        last_edited_by,
        workspace,
        created_time,
        description,
        last_edited_time,
        _fivetran_deleted,
        icon,
        title,
        cover,
        object,
        _fivetran_synced

    from source

)

select * from renamed
