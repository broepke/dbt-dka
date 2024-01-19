with 

source as (

    select * from {{ source('deadpool', 'players') }}

),

renamed as (

    select
        id,
        first_name,
        last_name,
        email,
        year_one,
        year_two,
        opt_in,
        sms

    from source

)

select * from renamed
