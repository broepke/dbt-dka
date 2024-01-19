with 

source as (

    select * from {{ source('google_analytics', 'tech_browser') }}

),

renamed as (

    select
        date,
        property,
        _fivetran_id,
        browser,
        event_count,
        total_users,
        conversions,
        engaged_sessions,
        engagement_rate,
        new_users,
        total_revenue,
        _fivetran_synced

    from source

)

select * from renamed
