with source as (

    select * from {{ ref('stg_quickbooks__invoice') }}
)

select * from source