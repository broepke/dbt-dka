select
    pl.first_name, 
    pl.last_name, 
    pl.email, 
    pl.sms
from {{ ref('stg_deadpool__players') }} pl
where pl.year_two is not null and pl.opt_in = true
