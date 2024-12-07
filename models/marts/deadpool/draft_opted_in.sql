select
    pl.first_name, 
    pl.last_name, 
    pl.email, 
    pl.sms
from {{ ref('stg_deadpool__players') }} pl
join {{ ref('stg_deadpool__draft_order') }} do
on pl.id = do.player_id
where do.year = year(current_date)
and do.draft_order is not null
and pl.opt_in = true
