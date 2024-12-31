with
    base_scoring as (select * from {{ ref("int_deadpool__score_base_scoring") }}),

    death_counts as ({{ death_counts_macro("2024") }}),

    first_blood as ({{ score_first_last_blood("min", "2024") }}),

    last_blood as ({{ score_first_last_blood("max", "2024") }}),

    q_one as ({{ score_quarterly("2024-01-01", "2024") }}),

    q_two as ({{ score_quarterly("2024-04-01", "2024") }}),

    q_three as ({{ score_quarterly("2024-07-01", "2024") }}),

    q_four as ({{ score_quarterly("2024-10-01", "2024") }})

select
    b.id,
    b.player,
    b.email,
    b.year,
    to_decimal(b.score)
    + to_decimal(coalesce(f.score, 0))
    + to_decimal(coalesce(l.score, 0))
    + to_decimal(coalesce(qo.points, 0))
    + to_decimal(coalesce(qtw.points, 0))
    + to_decimal(coalesce(qth.points, 0))
    + to_decimal(coalesce(qf.points, 0)) as total,
    b.score as base_score,
    coalesce(dc.death_count, 0) as death_count,
    to_decimal(coalesce(f.score, 0)) as first_blood,
    to_decimal(coalesce(l.score, 0)) as last_blood,
    to_decimal(coalesce(qo.points, 0)) as q_one,
    to_decimal(coalesce(qtw.points, 0)) as q_two,
    to_decimal(coalesce(qth.points, 0)) as q_three,
    to_decimal(coalesce(qf.points, 0)) as q_four
from base_scoring b
left join death_counts dc on b.id = dc.id
left join first_blood f on b.id = f.id
left join last_blood l on b.id = l.id
left join q_one qo on b.id = qo.id
left join q_two qtw on b.id = qtw.id
left join q_three qth on b.id = qth.id
left join q_four qf on b.id = qf.id
where year = 2024
order by total desc
