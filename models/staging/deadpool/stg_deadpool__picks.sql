with 

source as (

    select * from {{ source('deadpool', 'picks') }}

),

renamed as (

    select
        name,
        birth_date,
        death_date,
        age,
        picked_by,
        wiki_page,
        year,
        timestamp

    from source

)

select * from renamed
