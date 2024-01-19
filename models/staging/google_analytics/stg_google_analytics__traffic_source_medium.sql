with 

source as (

    select * from {{ source('google_analytics', 'traffic_source_medium') }}

),

renamed as (

    select
        date,
        property,
        _fivetran_id,
        session_source,
        session_medium,
        event_count,
        events_per_session,
        user_engagement_duration,
        conversions,
        engagement_rate,
        sessions,
        total_users,
        engaged_sessions,
        total_revenue,
        _fivetran_synced

    from source

)

select * from renamed
