with source as (select * from {{ ref("stg_nndb__email_nndb") }})

select
    id,
    gender,
    race,
    occupation,
    nationality,
    birth_date,
    age,
    risk_factors,
    wiki_categorized_cause,
    case when death_date is null then 0 else 1 end as is_dead
from source
