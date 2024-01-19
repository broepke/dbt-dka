with

    source as (select * from {{ source("nndb", "nndb") }}),

    renamed as (

        select
            link,
            name,
            aka,
            case
                when length(born) = 4
                then to_date(born, 'YYYY')
                when length(born) > 7
                then to_date(born, 'DD-MON YYYY')
                else null
            end as born,
            birthplace,
            gender,
            race,
            occupation,
            nationality,
            executive_summary,
            case
                when length(died) = 4
                then to_date(died, 'YYYY')
                when length(died) > 7
                then to_date(died, 'DD-MON YYYY')
                else null
            end as died,
            location_of_death,
            cause_of_death,
            risk_factors

        from source

    ),

    add_age as (

        select
            {{ dbt_utils.generate_surrogate_key(["link", "name"]) }} as id,
            link,
            name,
            aka,
            born,
            birthplace,
            gender,
            race,
            case
                when right(occupation, 1) = ','
                then left(occupation, len(occupation) - 1)
                else occupation
            end as occupation,
            nationality,
            executive_summary,
            died,
            location_of_death,
            cause_of_death,
            case
                when died is not null
                then datediff(year, born, died)
                else datediff(year, born, current_date())
            end as age,
            split(risk_factors, ';') as risk_factors
        -- replace(name, ' ', '_') as wiki_page
        from renamed
    ),

    add_wiki as (

        select add_age.*, wiki.wiki_page, wiki.status_code
        from add_age
        join {{ ref("seed_nndb_wiki_pages") }} wiki on add_age.id = wiki.id
        where wiki.status_code = 200

    ),

    add_death_causes as (

        select
            wiki.*,
            cause.wiki_cause_of_death as wiki_cause_of_death,
            cause.wiki_death_summary as wiki_death_summary,
            cause.wiki_categorized_cause as wiki_categorized_cause
        from add_wiki wiki
        left join {{ ref("seed_nndb_death_causes") }} cause on wiki.id = cause.id
    ),

    add_health_issues as (

        select
            cause.id,
            cause.link,
            cause.wiki_page,
            cause.name,
            cause.aka,
            cause.born,
            cause.birthplace,
            cause.gender,
            cause.race,
            cause.occupation,
            cause.nationality,
            cause.executive_summary,
            cause.died,
            cause.location_of_death,
            cause.cause_of_death,
            cause.age as nndb_age,
            cause.risk_factors,
            cause.wiki_cause_of_death,
            cause.wiki_death_summary,
            health.wiki_health_issues,
            coalesce(
                cause.wiki_categorized_cause, health.wiki_categorized_cause
            ) as wiki_categorized_cause
        from add_death_causes cause
        left join {{ ref("seed_nndb_alive_causes") }} as health on cause.id = health.id

    ),

    add_wiki_id as (

        select h.*, w.wiki_id
        from add_health_issues h
        left join {{ ref("seed_nndb_wiki_id") }} w on h.id = w.id

    ),

    wiki_dates as (

        select
            a.*,
            d.birth_date,
            d.death_date,
            case
                when death_date is null
                then datediff(year, birth_date, current_date())
                else datediff(year, birth_date, death_date)
            end as age
        from add_wiki_id a
        join {{ ref("seed_nndb_wiki_dates") }} d on a.id = d.id
    )

select
    id,
    link,
    wiki_page,
    wiki_id,
    name,
    aka,
    birth_date,
    birthplace,
    gender,
    race,
    occupation,
    nationality,
    executive_summary,
    death_date,
    location_of_death,
    cause_of_death,
    age,
    risk_factors,
    wiki_cause_of_death,
    wiki_death_summary,
    wiki_health_issues,
    wiki_categorized_cause
from wiki_dates
where born > '1900-01-01'
and age > 10 and age < 105
