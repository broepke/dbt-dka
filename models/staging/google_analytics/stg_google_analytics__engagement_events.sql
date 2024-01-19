with 

source as (

    select * from {{ source('google_analytics', 'engagement_events') }}

),

renamed as (

    select
        date,
        property,
        _fivetran_id,
        event_name,
        event_count,
        total_users,
        event_count_per_user,
        total_revenue,
        _fivetran_synced

    from source

)

select * from renamed
