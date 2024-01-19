with source as (

    select * from {{ ref('int_notion__pages') }}

)

select * from source