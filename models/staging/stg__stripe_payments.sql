-- This staging model can either be included in the starter to avoid repeating or be
-- used as a 'you do' for participants if the session is longer
with
    source as (select * from {{ source("stripe", "payment") }}),

    transformed as (

        select

            id as payment_id,
            orderid as order_id,
            paymentmethod as payment_method,
            status as payment_status,
            amount / 100 as payment_amount,
            -- amount in dollars
            created as payment_date,
            _batched_at

        from source

    )

select *
from transformed
