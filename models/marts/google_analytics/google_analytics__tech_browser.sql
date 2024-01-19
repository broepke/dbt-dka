with source as (

    select * from {{ ref('stg_google_analytics__tech_browser') }}

)

select * from source