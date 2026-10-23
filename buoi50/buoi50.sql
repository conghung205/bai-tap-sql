-- Bài tập buổi 50: Thêm index cần thiết để tối ưu lại database
CREATE INDEX idxJob_application_job_id ON job_application (job_id);

CREATE INDEX idxJob_application_candidate_id ON job_application (candidate_id);

CREATE INDEX idxJob_category_id ON job (category_id);

WITH
    job_temp as (
        SELECT
            job.id as job_id,
            job.title as job_name,
            job.category_id,
            json_agg(
                json_build_object(
                    'candidate_id',
                    candidate.id,
                    'candidate_name',
                    candidate.name,
                    'candidate_phone',
                    candidate.phone
                )
            ) as candidates
        FROM
            job
            JOIN job_application on job.id = job_application.job_id
            JOIN candidate on job_application.candidate_id = candidate.id
        GROUP BY
            job.id,
            job.title,
            job.category_id
    )
SELECT
    category.id as category_id,
    category.name as category_name,
    json_agg(
        json_build_object(
            'job_id',
            job_temp.job_id,
            'job_name',
            job_temp.job_name,
            'candidates',
            job_temp.candidates
        )
    ) as jobs
FROM category
    JOIN job_temp on category.id = job_temp.category_id
WHERE
    category.active = TRUE
GROUP BY
    category.id,
    category.name;