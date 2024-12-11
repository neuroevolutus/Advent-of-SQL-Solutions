WITH min_max_experience_pairs AS (
    SELECT
        first_value(elf_id) OVER (PARTITION BY primary_skill ORDER BY years_experience DESC,
            elf_id ASC) max_years_experience_elf_id,
        first_value(elf_id) OVER (PARTITION BY primary_skill ORDER BY years_experience ASC,
            elf_id ASC) min_years_experience_elf_id,
        primary_skill
    FROM workshop_elves
)
SELECT DISTINCT
    max_years_experience_elf_id,
    min_years_experience_elf_id,
    primary_skill
FROM
    min_max_experience_pairs
ORDER BY
    primary_skill;

