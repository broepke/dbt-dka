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
        opt_in,
        sms

    from source

)

select * from renamed
