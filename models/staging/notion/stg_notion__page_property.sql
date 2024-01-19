with 

source as (

    select * from {{ source('notion', 'page_property') }}

),

renamed as (

    select
        page_id,
        id,
        _fivetran_deleted,
        multi_select,
        type,
        _fivetran_synced,
        last_edited_time,
        verification,
        has_more,
        relation,
        title,
        people,
        date,
        unique_id,
        rollup,
        status,
        formula,
        rich_text,
        number,
        created_by,
        created_time,
        last_edited_by,
        email,
        url

    from source

)

select * from renamed
