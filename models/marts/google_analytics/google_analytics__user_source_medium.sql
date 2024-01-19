with source as (

    select * from {{ ref('stg_google_analytics__user_source_medium') }}

)

select * from source