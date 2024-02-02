with 

source as (

    select * from {{ source('stripe', 'balance_transaction') }}

),

renamed as (

    select
        id,
        connected_account_id,
        amount,
        available_on,
        created,
        currency,
        description,
        exchange_rate,
        fee,
        net,
        source,
        status,
        type,
        reporting_category,
        _fivetran_synced,
        payout_id

    from source

)

select * from renamed
