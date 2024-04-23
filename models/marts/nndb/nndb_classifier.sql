with source as (select * from {{ ref("stg_nndb__email_nndb") }}),

flattened as ( select * from {{ ref('int_nndb__flattened_risks') }}) 

select
    s.id,
    s.gender,
    s.race,
    s.occupation,
    s.nationality,
    s.age,
    s.wiki_categorized_cause,
    f.* exclude id,
    case when s.death_date is null then 0 else 1 end as is_dead
from source s
left join flattened f 
on f.id = s.id
