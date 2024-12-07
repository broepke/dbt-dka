{% macro score_quarterly(selected_quarter, year) %}

        select
            pp.player_id as id,
            date_trunc('QUARTER', pe.death_date) as quarter,
            sum(50 + 100 - pe.age) as score,
            5 as points
        from {{ ref('stg_deadpool__people') }} pe
        join {{ ref('stg_deadpool__player_picks') }} pp on pe.id = pp.people_id
        join
            (
                select pp.player_id, max(50 + 100 - age) as max_score
                from {{ ref('stg_deadpool__people') }} pe
                join {{ ref('stg_deadpool__player_picks') }} pp on pe.id = pp.people_id
                where
                    pp.year = {{ year }}
                    and pe.death_date is not null
                    and date_trunc('QUARTER', pe.death_date) = date '{{ selected_quarter }}'
                group by 1
            ) as max_scores
            on pp.player_id = max_scores.player_id
            and 50 + 100 - pe.age = max_scores.max_score
        where pp.year = {{ year }} and pe.death_date is not null
        group by pp.player_id, quarter
        order by score desc
        limit 1

{% endmacro %}
