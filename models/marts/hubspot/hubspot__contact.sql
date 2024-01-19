with
    contact as (

        select * from {{ ref("stg_hubspot__contact") }} where is_deleted = false

    ),

    company as (

        select * from {{ ref("stg_hubspot__company") }} where is_deleted = false
    ),

    contact_company as (

        select * from {{ ref("stg_hubspot__contact_company") }} where type_id = 1
    )

select
    con.id,
    concat(con.property_firstname || ' ' || con.property_lastname || ' (' || co.property_name || ')') as contact_id,
    con.property_firstname as first,
    con.property_lastname as last,
    con.property_email as email,
    co.property_name as company,
    co.property_domain as domain,
    to_timestamp(con.property_lastmodifieddate) as updated
from contact con
join contact_company cc on con.id = cc.contact_id
join company co on co.id = cc.company_id
