with 

source as (

    select * from {{ source('quickbooks', 'invoice') }}

),

renamed as (

    select
        id,
        currency_id,
        exchange_rate,
        email_status,
        allow_online_achpayment,
        allow_ipnpayment,
        doc_number,
        print_status,
        private_note,
        deposit,
        allow_online_payment,
        home_balance,
        allow_online_credit_card_payment,
        balance,
        apply_tax_after_discount,
        sync_token,
        global_tax_calculation,
        delivery_time,
        delivery_type,
        created_at,
        updated_at,
        billing_email,
        billing_cc_email,
        billing_bcc_email,
        customer_memo,
        total_tax,
        tax_code_id,
        shipping_address_id,
        billing_address_id,
        due_date,
        ship_date,
        -- _fivetran_deleted,
        tracking_number,
        home_total_amount,
        total_amount,
        transaction_source,
        transaction_date,
        department_id,
        sales_term_id,
        customer_id,
        class_id,
        deposit_to_account_id
        -- _fivetran_synced

    from source
    where _fivetran_deleted = false

)

select * from renamed
