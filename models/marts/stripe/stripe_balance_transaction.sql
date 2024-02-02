with source as (

    select * from {{ ref('stg_stripe__balance_transaction') }}
),

final as (

    select
        id,
        --connected_account_id,
        amount / 100 as amount,
        available_on,
        --created,
        currency,
        description,
        exchange_rate,
        fee,
        net / 100 as net,
        source,
        --status,
        type,
        reporting_category
        --_fivetran_synced, 
        --payout_id
    from source

)

select * from final