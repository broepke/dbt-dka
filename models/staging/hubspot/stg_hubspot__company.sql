with 

source as (

    select * from {{ source('hubspot', 'company') }}

),

renamed as (

    select
        id,
        portal_id,
        is_deleted,
        _fivetran_deleted,
        property_description,
        property_industry,
        property_num_associated_contacts,
        property_hs_analytics_first_timestamp,
        property_hs_num_contacts_with_buying_roles,
        property_hs_time_in_lead,
        property_name,
        property_linkedinbio,
        property_hs_lastmodifieddate,
        property_founded_year,
        property_country,
        property_hs_pipeline,
        property_timezone,
        property_annualrevenue,
        property_hs_object_source,
        property_city,
        property_hs_num_decision_makers,
        property_hs_num_open_deals,
        property_hs_num_child_companies,
        property_hs_num_blockers,
        property_website,
        property_web_technologies,
        property_hs_analytics_num_visits,
        property_hs_analytics_source,
        property_linkedin_company_page,
        property_hs_target_account_probability,
        property_hs_analytics_latest_source_data_2,
        property_hs_user_ids_of_all_owners,
        property_hs_analytics_latest_source_data_1,
        property_first_contact_createdate,
        property_zip,
        property_state,
        property_hs_date_entered_lead,
        property_type,
        property_hs_analytics_latest_source,
        property_hs_analytics_latest_source_timestamp,
        property_hs_analytics_source_data_2,
        property_num_conversion_events,
        property_hs_analytics_num_page_views,
        property_hs_analytics_source_data_1,
        property_domain,
        property_hs_updated_by_user_id,
        property_hs_created_by_user_id,
        property_lifecyclestage,
        property_hubspot_owner_assigneddate,
        property_hs_object_source_id,
        property_createdate,
        property_hubspot_owner_id,
        property_hs_object_id,
        property_is_public,
        property_hs_all_owner_ids,
        property_hs_object_source_user_id,
        property_numberofemployees,
        _fivetran_synced,
        property_hs_avatar_filemanager_key,
        property_address,
        property_facebook_company_page,
        property_twitterhandle,
        property_phone

    from source

)

select * from renamed
