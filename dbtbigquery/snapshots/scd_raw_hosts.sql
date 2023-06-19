{% snapshot scd_raw_hosts %}

{{
   config(
       target_schema='airbnb_pipeline_staging',
       unique_key='id',
       strategy='check',
       check_cols=['name','is_superhost']
   )
}}

select * FROM {{ source('airbnb_raw', 'raw_hosts') }}

{% endsnapshot %}