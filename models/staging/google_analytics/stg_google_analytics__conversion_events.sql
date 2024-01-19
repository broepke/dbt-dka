with 

source as (

    select * from {{ source('google_analytics', 'conversion_events') }}

),

renamed as (

    select
        name,
        event_name,
        create_time,
        deletable,
        custom,
        _fivetran_synced

    from source

)

select * from renamed
