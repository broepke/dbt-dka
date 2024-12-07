select
    pl.first_name,
    pl.last_name,
    to_decimal(coalesce(do.draft_order, 0)) as prior_draft,
    to_decimal(coalesce(sc.total, 0)) as prior_score,
    abs(round((random(55) % 1000000) / 1000000.0, 3) * 100) as random_number,
    (prior_draft * 30) + random_number + (prior_score * -1) as score
from {{ ref("stg_deadpool__players") }} pl
left join {{ ref("score_twenty_four") }} sc on pl.id = sc.id
left join
    {{ ref("stg_deadpool__draft_order") }} do
    on pl.id = do.player_id
    and do.year = 2024 --year(current_date) - 1
    and do.draft_order is not null
order by score desc
