with source as (

    select * from {{ ref('stg_google_analytics__engagement_events') }}

)

select * from source