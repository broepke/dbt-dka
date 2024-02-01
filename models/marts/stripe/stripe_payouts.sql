with
    source as (select * from {{ ref("stg_stripe__payout") }}),

    final as (

        select
            id,
            --connected_account_id,
            amount / 100 as amount,
            arrival_date,
            --automatic,
            --created,
            currency,
            --description,
            --failure_code,
            --failure_message,
            --livemode,
            --metadata,
            --method,
            --reconciliation_status,
            source_type,
            --statement_descriptor,
            status,
            type
            --destination_card_id,
            --destination_bank_account_id,
            --balance_transaction_id,
            --failure_balance_transaction_id,
            --_fivetran_synced
        from source

    )

select *
from final
