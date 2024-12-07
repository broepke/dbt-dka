with 

source as (

    select * from {{ source('deadpool', 'draft_order') }}

),

renamed as (

    select
        player_id,
        year,
        draft_order

    from source

)

select * from renamed
