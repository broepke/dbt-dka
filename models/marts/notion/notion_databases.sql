with source as (

    select * from {{ ref('int_notion__database') }}

)

select * from source