{%- set get_distinct_types -%}
    with
        flattened as (
            select id, trim(value::varchar(256)) as value
            from {{ ref("stg_nndb__email_nndb") }}, lateral flatten(input => risk_factors)
        ),

        unique_values as (select distinct value from flattened)

    select *
    from unique_values

{%- endset -%}

{%- set results = run_query(get_distinct_types) -%}

{%- if execute -%} {%- set risks = results.columns[0].values() -%}

{%- else -%} {%- set risks = [] -%}

{%- endif -%}


with
    flattened as (
        select id, trim(value::varchar(256)) as value
        from {{ ref("stg_nndb__email_nndb") }}, lateral flatten(input => risk_factors)
    )

select
    id,

    {% for risk in risks %}

    max(case when value = '{{ risk | replace("'", "") }}' 
    then 1 else 0 end) as {{ risk | replace("'", "") | replace("č", "c")  | replace("ť", "t")  | replace("é", "e") | replace(" ", "_") | replace("-", "_") | lower }}

    {%- if not loop.last -%}, {%- endif -%}

    {%- endfor %}

from flattened
group by id
