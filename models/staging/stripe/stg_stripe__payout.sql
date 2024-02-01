with 

source as (

    select * from {{ source('stripe', 'payout') }}

),

renamed as (

    select
        id,
        connected_account_id,
        amount,
        arrival_date,
        automatic,
        created,
        currency,
        description,
        failure_code,
        failure_message,
        livemode,
        metadata,
        method,
        reconciliation_status,
        source_type,
        statement_descriptor,
        status,
        type,
        destination_card_id,
        destination_bank_account_id,
        balance_transaction_id,
        failure_balance_transaction_id,
        _fivetran_synced

    from source

)

select * from renamed
