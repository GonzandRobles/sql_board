with 

-- import data

    raw_dates as (

       select *, DATE_FROM_PARTS(year, month, day) AS date
       from {{ source('raw_data', 'dim_data') }}

    )

select * from raw_dates