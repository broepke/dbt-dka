with 

source as (

    select * from {{ source('stripe', 'bank_account') }}

),

renamed as (

    select
        id,
        connected_account_id,
        account,
        account_holder_name,
        account_holder_type,
        bank_name,
        country,
        currency,
        fingerprint,
        last_4,
        routing_number,
        status,
        metadata,
        is_deleted,
        customer_id,
        _fivetran_synced

    from source

)

select * from renamed
