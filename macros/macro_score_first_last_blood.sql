{% macro score_first_last_blood(first_last, year) %}

    select pl.id as id, pi.name, pi.death_date, '25' as score
    from {{ ref("stg_deadpool__players") }} pl
    join {{ ref("stg_deadpool__picks") }} pi on pl.id = pi.picked_by
    where
        pi.death_date is not null
        and year = {{ year }}
        and death_date = (
            select {{ first_last }} (death_date)
            from {{ ref("stg_deadpool__picks") }}
            where death_date is not null and year = {{ year }}
        )

{% endmacro %}
