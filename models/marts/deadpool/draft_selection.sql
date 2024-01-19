select
    pl.first_name,
    pl.last_name,
    to_decimal(coalesce(pl.year_one, 0)) as prior_draft,
    to_decimal(coalesce(sc.score, 0)) as score,
    abs(round((random(68) % 1000000) / 1000000.0, 3)) as random_number
from {{ ref('stg_deadpool__players') }} pl
left join {{ ref('score_twenty_three') }} sc on pl.email = sc.email
