{% macro score_first_last_blood(first_last, year) %}

    select pl.id as id, pi.name, pi.death_date, '25' as score
    from {{ ref("stg_deadpool__players") }} pl
    join {{ ref('stg_deadpool__player_picks') }} pp on pl.id = pp.player_id
    join {{ ref('stg_deadpool__people') }} pi on pp.people_id = pi.id
    where
        pi.death_date is not null
        and pp.year = {{ year }}
        and death_date = (
            select {{ first_last }} (death_date)
            from {{ ref("stg_deadpool__people") }} pe
            join {{ ref('stg_deadpool__player_picks') }} pp
                on pe.id = pp.people_id
            where pe.death_date is not null and pp.year = {{ year }}
        )

{% endmacro %}
