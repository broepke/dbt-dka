with source as (

    select * from {{ ref('stg_google_analytics__conversion_events') }}

)

select * from source