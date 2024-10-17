with source as (
    select * from {{ ref('stg_pivots') }}
)

select * from source