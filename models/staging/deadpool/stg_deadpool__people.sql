with 

source as (

    select * from {{ source('deadpool', 'people') }}

),

renamed as (

    select
        id,
        name,
        birth_date,
        death_date,
        age,
        wiki_page,
        wiki_id

    from source

)

select * from renamed
