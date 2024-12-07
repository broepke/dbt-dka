select
    pl.id as id,
    concat(pl.first_name || ' ' || pl.last_name) as player,
    pl.email as email,
    pp.year as year,
    sum(50 + (100 - pe.age)) as score
from {{ ref("stg_deadpool__players") }} pl
join {{ ref('stg_deadpool__player_picks') }} pp on pl.id = pp.player_id
join {{ ref("stg_deadpool__people") }} pe on pe.id = pp.people_id
where pe.death_date is not null
group by 1, 2, 3, 4
order by year desc, score desc
