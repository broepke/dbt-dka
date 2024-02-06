with source as (

    select * from {{ ref('stg_deadpool__picks') }}
    
),

transform as (

    select
        pi.name,
        pi.birth_date,
        pi.death_date,
        to_decimal(coalesce(pi.age, 0)) as age,
        concat(pl.first_name || ' ' || pl.last_name) as player,
        pi.timestamp as draft_date
    from {{ ref('stg_deadpool__players') }} pl
    join source as pi on pl.id = pi.picked_by
    where pi.year = 2024

)

select * from transform