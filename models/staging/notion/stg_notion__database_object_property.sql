with

    source as (select * from {{ source("notion", "database_object_property") }}),

    renamed as (

        select
            database_object_id,
            id,
            _fivetran_deleted,
            name,
            type,
            title,
            _fivetran_synced,
            date,
            unique_id,
            relation, rollup,
            status,
            rich_text,
            email,
            people,
            created_by,
            created_time,
            last_edited_by,
            last_edited_time,
            multi_select,
            verification,
            formula,
            number,
            url

        from source

    )

select *
from renamed
