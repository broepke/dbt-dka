with
    ranked_players as (
        select
            concat(pl.first_name || ' ' || pl.last_name) as name,
            pl.id,
            pl.email,
            pl.sms,
            pl.year_two as draft_order,
            count(pi.name) as pick_count,
            rank() over (order by count(pi.name) asc, pl.year_two) as rank
        from {{ ref("stg_deadpool__players") }} pl
        left join
            {{ ref("stg_deadpool__picks") }} pi
            on pl.id = pi.picked_by
            and pi.year = 2024
            and pi.death_date is null
        where pl.year_two is not null
        group by 1, 2, 3, 4, 5
    )
select id, name, email, sms, draft_order
from ranked_players
where rank = 1 and pick_count < 20
