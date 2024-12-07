with
    base_scoring as (select * from {{ ref("int_deadpool__score_base_scoring") }}),

    first_blood as ({{ score_first_last_blood("min", "2023") }}),

    last_blood as ({{ score_first_last_blood("max", "2023") }})

select
    b.id,
    b.player,
    b.email,
    b.year,
    to_decimal(b.score)
    + to_decimal(coalesce(f.score, 0))
    + to_decimal(coalesce(l.score, 0)) as total,
    b.score as base_score,
    to_decimal(coalesce(f.score, 0)) as first_blood,
    to_decimal(coalesce(l.score, 0)) as last_blood
from base_scoring b
left join first_blood f on b.id = f.id
left join last_blood l on b.id = l.id
where year = 2023
order by total desc
