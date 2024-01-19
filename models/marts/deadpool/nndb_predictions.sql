{{ config(materialized="table") }}

with source as (select * from {{ ref("seed_nndb_predictions") }})

select *
from source
