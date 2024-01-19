with source as (

    select * from {{ ref('stg_google_analytics__engagement_path') }}

)

select * from source