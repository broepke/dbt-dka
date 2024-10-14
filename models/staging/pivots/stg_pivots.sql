{%- set get_distinct_products -%}
    select distinct(product)
    from {{ ref('seed_pivot_example') }}
{%- endset -%}

{%- set results = run_query(get_distinct_products) -%}

{%- if execute -%} 
{%- set all_products = results.columns[0].values() -%}
{%- else -%} 
{%- set all_products = [] -%}
{%- endif -%}


with
    source as (
        select * from {{ ref('seed_pivot_example') }}
    ),

    final as (

        select
            user,
            {%- for all_product in all_products %}
            count(case when product = '{{ all_product }}' then 1 end) as {{ all_product | replace("-", "_") | replace(" ", "_") | lower }}
            {%- if not loop.last -%}, {% endif -%}
            {% endfor %}
        from source
        group by user

    )

select *
from final