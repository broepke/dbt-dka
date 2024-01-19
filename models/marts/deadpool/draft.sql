select 
    pl.id,
    pl.email, 
    pl.year_two as draft_order, 
    count(pi.name) as pick_count
from {{ ref("stg_deadpool__players") }} pl
left join
    {{ ref("stg_deadpool__picks") }} pi on pl.id = pi.picked_by and pi.year = 2024
where pl.year_two is not null
and pi.death_date is null
group by 1, 2, 3
order by 2, 3 desc
