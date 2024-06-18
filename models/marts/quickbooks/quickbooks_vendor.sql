with source as (

    select * from {{ ref('stg_quickbooks__vendor') }}
)

select * from source