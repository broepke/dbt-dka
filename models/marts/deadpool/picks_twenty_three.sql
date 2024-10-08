with source as (

    select * from {{ ref('stg_deadpool__picks') }}
    
),

transform as (

    select
        pi.name,
        pi.birth_date,
        pi.death_date,
        pi.age,
        concat(pl.first_name || ' ' || pl.last_name) as player,
        pi.timestamp as draft_date
    from {{ ref('stg_deadpool__players') }} pl
    join source as pi on pl.id = pi.picked_by
    where pi.year = 2023

)

select * from transform