select
    title_id,
    title_instant_available
from {{ source('fudgeflix_v3', 'ff_titles') }}
