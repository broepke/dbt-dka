with
    source as (select * from {{ ref("stg_notion__database_object") }}),

    database_object_title as (
        select
            id,
            title,
            value:type::varchar(256) as type,
            value:text::varchar(256) as text,
            value:annotations::varchar(256) as annotations,
            value:plain_text::varchar(256) as plain_text
        from source, lateral flatten(input => title)
    ),
    databases_with_title as (
        select
            db.id,
            dot.plain_text as title,
            db.created_time,
            db.last_edited_time,
            db.object,
            db.page_id,
            db.parent_database_id
        from source as db
        left join database_object_title as dot on db.id = dot.id
        where not _fivetran_deleted
    )
select *
from databases_with_title
