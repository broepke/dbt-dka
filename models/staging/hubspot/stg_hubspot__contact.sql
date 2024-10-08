with 

source as (

    select * from {{ source('hubspot', 'contact') }}

),

renamed as (

    select
        id,
        _fivetran_deleted,
        is_deleted,
        _fivetran_synced,
        property_hs_all_contact_vids,
        property_hs_date_entered_lead,
        property_hs_marketable_reason_id,
        property_hs_is_unworked,
        property_hs_latest_source_timestamp,
        property_hs_marketable_reason_type,
        property_hs_marketable_status,
        property_hs_is_contact,
        property_hs_email_domain,
        property_hs_object_source_id,
        property_hs_pipeline,
        property_hs_marketable_until_renewal,
        property_hs_sequences_actively_enrolled_count,
        property_hs_object_id,
        property_hs_object_source,
        property_hs_time_in_lead,
        property_num_conversion_events,
        property_num_unique_conversion_events,
        property_hs_v_2_latest_time_in_lead,
        property_hs_v_2_date_entered_lead,
        property_lastmodifieddate,
        property_hs_v_2_cumulative_time_in_lead,
        property_email,
        property_firstname,
        property_lastname,
        property_hs_analytics_num_page_views,
        property_hs_social_facebook_clicks,
        property_hs_analytics_num_event_completions,
        property_hs_analytics_first_timestamp,
        property_hs_social_twitter_clicks,
        property_hs_analytics_num_visits,
        property_hs_social_linkedin_clicks,
        -- property_twitterhandle,
        -- property_twitterprofilephoto,
        property_city,
        property_hs_analytics_source_data_2,
        property_hs_analytics_source_data_1,
        property_hs_latest_source,
        property_hs_analytics_revenue,
        property_hs_analytics_average_page_views,
        property_hs_social_num_broadcast_clicks,
        property_state,
        property_hs_lifecyclestage_lead_date,
        property_hs_analytics_source,
        property_hs_latest_source_data_1,
        property_hs_latest_source_data_2,
        property_hs_social_google_plus_clicks,
        property_jobtitle,
        property_createdate,
        -- property_company,
        -- property_website,
        property_lifecyclestage,
        property_associatedcompanyid,
        property_hs_updated_by_user_id,
        property_hs_created_by_user_id,
        property_hs_object_source_user_id,
        property_hs_date_entered_customer,
        property_hs_time_between_contact_creation_and_deal_close,
        property_hs_v_2_date_entered_customer,
        property_hs_searchable_calculated_phone_number,
        property_hs_count_is_worked,
        -- property_hs_v_2_latest_time_in_customer,
        property_hs_lifecyclestage_customer_date,
        property_days_to_close,
        property_hubspot_owner_assigneddate,
        property_closedate,
        property_hs_time_in_customer,
        property_hs_calculated_phone_number_country_code,
        property_hubspot_owner_id,
        property_hs_calculated_phone_number,
        property_hs_user_ids_of_all_owners,
        -- property_hs_v_2_cumulative_time_in_customer,
        property_hs_all_owner_ids,
        property_hs_count_is_unworked,
        property_phone

    from source

)

select * from renamed
