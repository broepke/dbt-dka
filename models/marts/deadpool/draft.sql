select 
    pl.id,
    pl.email, 
    do.draft_order, 
    count(pe.id) as pick_count
from {{ ref("stg_deadpool__players") }} pl
left join
    {{ ref('stg_deadpool__player_picks') }} pp on pl.id = pp.player_id
left join
    {{ ref("stg_deadpool__people") }} pe on pp.people_id = pe.id and pp.year = year(current_date)
left join
    {{ ref("stg_deadpool__draft_order") }} do on pl.id = do.player_id and do.year = year(current_date)
where do.draft_order is not null
and pe.death_date is null
group by 1, 2, 3
order by 2, 3 desc
