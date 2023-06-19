-- set incremental table
{{
  config(
    materialized = 'incremental',
    on_schema_change = 'fail'
    )
}}


WITH src_reviews AS (
    SELECT *,
    
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id
     FROM {{ref("src_reviews")}}
)
SELECT * FROM src_reviews
WHERE review_text IS NOT NULL
-- define whats new record
{% if is_incremental() %}
  and review_date > (select max(review_date) from {{ this }})
{% endif %}