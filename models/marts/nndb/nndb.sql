with source as (

    select * from {{ ref('stg_nndb__email_nndb') }}
)

select * from source