with
    database_tasks as (

        select * from {{ ref("int_notion__database") }} where title = 'Tasks'

    ),
    all_pages as (select * from {{ ref("int_notion__pages") }}),
    task_estimates as (
        select page_id, number as estimates
        from {{ ref("stg_notion__page_property") }}
        where id = 'KUzH'
    ),
    task_actuals as (
        select page_id, number as actuals
        from {{ ref("stg_notion__page_property") }}
        where id = '%5D%7D%40%3A'
    ),
    product_type as (

        select ppid.page_id, pp.title[0]:plain_text::varchar(256) as product
        from {{ ref("stg_notion__page_property") }} ppid
        left join
            {{ ref("stg_notion__page_property") }} pp
            on ppid.relation[0]:id::varchar(256) = pp.page_id
        where ppid.id = 'mcOC' and pp.id = 'title'

    ),
    project as (

        select pid.page_id, pp.title[0]:plain_text::varchar(256) as project
        from {{ ref("stg_notion__page_property") }} pid
        left join
            {{ ref("stg_notion__page_property") }} pp
            on pid.relation[0]:id::varchar(256) = pp.page_id
        where
            pid.id = 'notion%3A%2F%2Ftasks%2Ftask_to_project_relation'
            and pp.id = 'title'
    ),
    price_per_actuals as (

        select page_id, formula:number::number(16) as total_value
        from {{ ref("stg_notion__page_property") }}
        where total_value is not null
        and id = 'fz%3Dg'

    ),
    price_per_estimates as (

        select page_id, formula:number::number(16) as total_value
        from {{ ref("stg_notion__page_property") }}
        where total_value is not null
        and id = 'xNR%5D'

    ),
    status as (

        select page_id, status:name::varchar(256) as status
        from {{ ref("stg_notion__page_property") }}
        where status is not null

    ),
    task_id as (

        select
            page_id,
            concat(
                unique_id:prefix::varchar(10) || '-' || unique_id:number::varchar(10)
            ) as task_id
        from {{ ref("stg_notion__page_property") }}
        where unique_id is not null

    )

select
    p.page_id,
    tk.task_id,
    p.page_title,
    pj.project,
    e.estimates,
    a.actuals,
    ppe.total_value as total_value_estimates,
    ppa.total_value as total_value_actuals,
    pt.product,
    st.status
from all_pages p
join database_tasks d on d.id = p.database_id
join task_estimates e on e.page_id = p.page_id
join task_actuals a on a.page_id = p.page_id
join product_type as pt on pt.page_id = p.page_id
join project as pj on pj.page_id = p.page_id
join price_per_estimates as ppe on ppe.page_id = p.page_id
join price_per_actuals as ppa on ppa.page_id = p.page_id
join status as st on st.page_id = p.page_id
join task_id as tk on tk.page_id = p.page_id
order by pj.project
