with
    source as (select * from {{ ref("stg_hubspot__company") }} where is_deleted = false)

select
    id,
    property_name as name,
    coalesce(property_industry, '') as industry,
    coalesce(property_num_associated_contacts, 0) as contacts,
    coalesce(property_description, '') as description,
    coalesce(property_linkedinbio, '') as linkedinbio,
    coalesce(property_founded_year, 0) as founded_year,
    coalesce(property_annualrevenue, 0) as annual_revenue,
    coalesce(property_numberofemployees, 0) as number_of_employees,
    coalesce(property_address, '') as address,
    coalesce(property_zip, '') as zip,
    coalesce(property_city, '') as city,
    coalesce(property_state, '') as state,
    coalesce(property_country, '') as country,
    coalesce(property_phone, '') as phone,
    coalesce(property_timezone, '') as timezone,
    coalesce(property_domain, '') as domain,
    coalesce(property_website, '') as website,
    coalesce(property_linkedin_company_page, '') as linkedin,
    coalesce(property_facebook_company_page, '') as facebook,
    coalesce(property_twitterhandle, '') as twitter

from source
