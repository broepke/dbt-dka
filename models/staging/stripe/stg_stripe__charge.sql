with 

source as (

    select * from {{ source('stripe', 'charge') }}

),

renamed as (

    select
        id,
        connected_account_id,
        amount,
        amount_refunded,
        application,
        billing_detail_address_city,
        billing_detail_address_country,
        billing_detail_address_line_1,
        billing_detail_address_line_2,
        billing_detail_address_postal_code,
        billing_detail_address_state,
        billing_detail_email,
        billing_detail_name,
        billing_detail_phone,
        application_fee_amount,
        calculated_statement_descriptor,
        captured,
        created,
        currency,
        description,
        destination,
        failure_code,
        failure_message,
        fraud_details_user_report,
        fraud_details_stripe_report,
        livemode,
        metadata,
        on_behalf_of,
        outcome_network_status,
        outcome_reason,
        outcome_risk_level,
        outcome_risk_score,
        outcome_seller_message,
        outcome_type,
        paid,
        receipt_email,
        receipt_number,
        receipt_url,
        refunded,
        shipping_address_city,
        shipping_address_country,
        shipping_address_line_1,
        shipping_address_line_2,
        shipping_address_postal_code,
        shipping_address_state,
        shipping_carrier,
        shipping_name,
        shipping_phone,
        shipping_tracking_number,
        card_id,
        bank_account_id,
        source_id,
        source_transfer,
        statement_descriptor,
        status,
        transfer_data_destination,
        transfer_group,
        balance_transaction_id,
        customer_id,
        invoice_id,
        payment_intent_id,
        payment_method_id,
        transfer_id,
        _fivetran_synced

    from source

)

select * from renamed
