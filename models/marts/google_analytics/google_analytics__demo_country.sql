with source as (

    select * from {{ ref('stg_google_analytics__demo_country') }}

)

select * from source