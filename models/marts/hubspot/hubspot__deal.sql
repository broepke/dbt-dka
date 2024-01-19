with
    deals as (

        select
            deal_id,
            property_days_to_close as days_to_close,
            property_closedate as close_date,
            property_hs_tcv as total_contract_value,
            property_dealname as deal_name,
            deal_pipeline_stage_id as stage_id,
            property_amount as final_deal_value,
            property_hs_is_closed as is_closed,
            property_hs_date_entered_closedwon as date_closed_won
        from {{ ref("stg_hubspot__deal") }}
        where is_deleted = false

    ),

    deal_company as (

        select distinct 
            deal_id, 
            company_id 
        from {{ ref("stg_hubspot__deal_company") }}

    ),

    company as (
        
        select
            id,
            property_name as customer
        from {{ ref("stg_hubspot__company") }}
    
    ),

    deal_stages as (

        select 
            stage_id, 
            label as deal_stage
        from {{ ref("stg_hubspot__deal_pipeline_stage") }}

    )

select
    d.deal_id,
    c.customer,
    d.deal_name,
    d.is_closed,
    ds.deal_stage,
    d.date_closed_won,
    d.days_to_close,
    d.total_contract_value,
    d.final_deal_value
from deals d
join deal_company dc on d.deal_id = dc.deal_id
join company c on c.id = dc.company_id
join deal_stages ds on ds.stage_id = d.stage_id
