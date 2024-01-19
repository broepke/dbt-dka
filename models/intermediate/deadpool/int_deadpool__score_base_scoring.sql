select
    pl.id as id,
    concat(pl.first_name || ' ' || pl.last_name) as player,
    pl.email as email,
    pi.year as year,
    sum(50 + 100 - pi.age) as score
from {{ ref("stg_deadpool__players") }} pl
join {{ ref("stg_deadpool__picks") }} pi on pl.id = pi.picked_by
where pi.death_date is not null
group by 1, 2, 3, 4
order by score desc
