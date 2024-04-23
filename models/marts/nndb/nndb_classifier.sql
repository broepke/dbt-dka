with source as (select * from {{ ref("stg_nndb__email_nndb") }})

select
    id,
    born,
    gender,
    race,
    occupation,
    nationality,
    age,
    risk_factors,
    wiki_categorized_cause,
    case when died is null then 0 else 1 end as is_dead
from source
