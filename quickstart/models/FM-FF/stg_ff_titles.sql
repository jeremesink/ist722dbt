select
    title_id,
    title_instant_available
from {{ source('fudgeflix', 'ff_titles') }}
