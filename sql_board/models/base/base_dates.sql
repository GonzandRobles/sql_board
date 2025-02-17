with 

-- import data

    raw_dates as (

       select * from {{ source('raw_data', 'dim_data') }}

    )

select * from raw_dates