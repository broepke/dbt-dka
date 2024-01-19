with source as (

    select * from {{ ref('stg_google_analytics__engagement_page_title_scree_class') }}

)

select * from source