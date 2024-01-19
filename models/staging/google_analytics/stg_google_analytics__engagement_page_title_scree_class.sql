with 

source as (

    select * from {{ source('google_analytics', 'engagement_page_title_scree_class') }}

),

renamed as (

    select
        date,
        property,
        _fivetran_id,
        unified_screen_class,
        screen_page_views,
        event_count,
        total_users,
        conversions,
        user_engagement_duration,
        new_users,
        total_revenue,
        _fivetran_synced

    from source

)

select * from renamed
