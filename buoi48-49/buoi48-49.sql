-- Lấy ra danh sách ứng viên có nhiều cv nhất
SELECT candidate.id, candidate.name, candidate.email, COUNT(cv.id) as total_cv
FROM candidate
    JOIN cv on candidate.id = cv.candidate_id
WHERE
    candidate.active = TRUE
    AND cv.active = TRUE
GROUP BY
    candidate.id,
    candidate.name,
    candidate.email
ORDER BY total_cv DESC;

-- Lấy ra danh mục (categrory) có nhieu job nhất
SELECT
    category.id as category_id,
    category.name as category_name,
    COUNT(job.id) as total_jobs
FROM category
    JOIN job on category.id = job.category_id
WHERE
    job.active = TRUE
    AND category.active = TRUE
GROUP BY
    category.id,
    category.name
ORDER BY total_jobs DESC;

/*
- Lấy ra danh mục + jobs ăn theo danh mục đó
+ Trong jobs có ds ứng viên đã apply vào job đó
*/
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