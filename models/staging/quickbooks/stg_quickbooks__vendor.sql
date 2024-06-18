with 

source as (

    select * from {{ source('quickbooks', 'vendor') }}

),

renamed as (

    select
        id,
        vendor_1099,
        family_name,
        tax_identifier,
        given_name,
        company_name,
        active,
        suffix,
        balance,
        display_name,
        print_on_check_name,
        title,
        middle_name,
        sync_token,
        email,
        web_url,
        alternate_phone,
        primary_phone,
        mobile_phone,
        fax_number,
        billing_address_id,
        currency_id,
        created_at,
        updated_at,
        -- _fivetran_deleted,
        account_number,
        term_id,
        other_contacts
        -- _fivetran_synced

    from source
    where _fivetran_deleted = false

)

select * from renamed
