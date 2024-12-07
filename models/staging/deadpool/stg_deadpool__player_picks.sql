with 

source as (

    select * from {{ source('deadpool', 'player_picks') }}

),

renamed as (

    select
        player_id,
        year,
        people_id,
        timestamp

    from source

)

select * from renamed
