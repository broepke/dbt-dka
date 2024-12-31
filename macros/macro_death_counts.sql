{% macro death_counts_macro(year) %}

    select
        pp.player_id as id,
        count(pe.id) as death_count
    from {{ ref('stg_deadpool__people') }} pe
    join {{ ref('stg_deadpool__player_picks') }} pp on pe.id = pp.people_id
    where pe.death_date is not null and pp.year = {{ year }}
    group by pp.player_id

{% endmacro %}