with source as (

    select pp.player_id, pe.*, pp.timestamp
    from {{ ref('stg_deadpool__people') }} pe
    join {{ ref('stg_deadpool__player_picks') }} pp
    on pe.id = pp.people_id and pp.year = 2024
    
),

transform as (

    select
        pe.id,
        pe.name,
        pe.birth_date,
        pe.death_date,
        pe.age,
        pe.wiki_page,
        pe.wiki_id,
        concat(pl.first_name || ' ' || pl.last_name) as player,
        pe.timestamp as draft_date
    from {{ ref('stg_deadpool__players') }} pl
    join source as pe 
    on pl.id = pe.player_id

)

select * from transform