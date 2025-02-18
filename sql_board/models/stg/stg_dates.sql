with

-- import cte

    b_dates as (

        select * from {{ ref('base_dates') }}

    ),

-- transformations

    transformations as (

        select
            day,
            week,
            month,
            quarter,
            semester,
            year,
            date_from_parts(year, month, day) AS date
        from b_dates

    ),

-- final cte

    final as (

        select
            week,
            quarter,
            semester,
            date
        from transformations

    )

select * from final