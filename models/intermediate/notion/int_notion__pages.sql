with database_object_title as (
    select
        id,
        title,
        value:type::varchar(256) as type,
        value:text::varchar(256) as text,
        value:annotations::varchar(256) as annotations,
        value:plain_text::varchar(256) as plain_text
    FROM
        {{ ref('stg_notion__database_object') }},
        lateral flatten(input => title)
),
databases_with_title as (
    select
        db.id,
        dot.plain_text as db_title,
        db.created_time db_created_time,
        db.last_edited_time db_last_edited_time
    from
        {{ ref('stg_notion__database_object') }} as db
        left join database_object_title as dot on db.id = dot.id
    where
        not _fivetran_deleted
),

all_pages as (
    select
        id,
        url,
        created_by,
        created_time,
        database_id,
        last_edited_time,
        object,
        parent_page_id
    from
        {{ ref('stg_notion__page') }}
    where
        not _fivetran_deleted
        and not archived
),
page_property_title as (
    select
        id,
        page_id,
        value:type::varchar(256) as type,
        value:text::varchar(256) as text,
        value:annotations::varchar(256) as annotations,
        value:plain_text::varchar(256) as plain_text
    FROM
        {{ ref('stg_notion__page_property') }},
        lateral flatten(input => title)
    where
        title is not null
        and not _fivetran_deleted
),

pages_with_title as (

select
        all_pages.id as page_id,
        page_property_title.plain_text as page_title,
        all_pages.url as page_url,
        all_pages.created_by as page_created_by,
        all_pages.created_time as page_created_time,
        all_pages.database_id,
        all_pages.last_edited_time as page_last_edited_time,
        all_pages.parent_page_id
from
    all_pages
    join page_property_title
    on all_pages.id = page_property_title.page_id
)

select * from pages_with_title p
join databases_with_title d
on d.id = p.database_id
order by db_title