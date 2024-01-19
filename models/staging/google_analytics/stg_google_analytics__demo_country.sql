with 

source as (

    select * from {{ source('google_analytics', 'demo_country') }}

),

renamed as (

    select
        date,
        property,
        _fivetran_id,
        country,
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
