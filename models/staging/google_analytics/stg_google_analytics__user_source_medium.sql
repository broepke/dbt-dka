with 

source as (

    select * from {{ source('google_analytics', 'user_source_medium') }}

),

renamed as (

    select
        date,
        property,
        _fivetran_id,
        first_user_medium,
        first_user_source,
        event_count,
        total_users,
        engaged_sessions,
        engagement_rate,
        user_engagement_duration,
        conversions,
        new_users,
        total_revenue,
        _fivetran_synced

    from source

)

select * from renamed
