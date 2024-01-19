{% macro score_quarterly(selected_quarter, year) %}

        select
            p.picked_by as id,
            date_trunc('QUARTER', p.death_date) as quarter,
            sum(50 + 100 - p.age) as score,
            5 as points
        from deadpool.prod.picks p
        join
            (
                select picked_by, max(50 + 100 - age) as max_score
                from deadpool.prod.picks
                where
                    year = {{ year }}
                    and death_date is not null
                    and date_trunc('QUARTER', death_date) = date '{{ selected_quarter }}'
                group by picked_by
            ) as max_scores
            on p.picked_by = max_scores.picked_by
            and 50 + 100 - p.age = max_scores.max_score
        where p.year = {{ year }} and p.death_date is not null
        group by p.picked_by, quarter
        order by p.picked_by, quarter

{% endmacro %}
