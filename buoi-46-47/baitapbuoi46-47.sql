-- lấy la danh sách công ty và các job của công ty đó (jobs là dạng json_agg)
SELECT company.id as company_id, json_agg(
        json_build_object(
            'id', job.id, 'name', job.title, 'description', job.description
        )
    ) as jobs
FROM company
    JOIN job ON company.id = job.company_id
WHERE
    company.active = TRUE
    AND job.active = TRUE
GROUP BY
    company.id;

-- lấy ra 3 tỉnh thành có nhiều công ty trong hệ thống nhất
SELECT
    province.id,
    province.name,
    COUNT(DISTINCT company.id) as total_companies,
    json_agg(
        json_build_object(
            'company_id',
            company.id,
            'company_tax',
            company.tax,
            'company_name',
            company.name
        )
    ) as companies
FROM
    province
    JOIN company_address on province.id = company_address.province_id
    JOIN company ON company_address.company_id = company.id
WHERE
    province.active = TRUE
    AND company.active = TRUE
GROUP BY
    province.id,
    province.name
ORDER BY total_companies DESC
LIMIT 3

-- lấy ra ds công cty và các địa chỉ của công ty đó
-- (address dưới dạng json_agg bao gồm id-tên tỉnh- tên xã-địa chỉ chi tiết)
WITH
    company_address_temp as (
        SELECT
            company_address.id,
            company_address.company_id,
            province.id as province_id,
            province.name as province_name,
            ward.id as ward_id,
            ward.name as ward_name,
            company_address.address_detail
        FROM
            company_address
            JOIN province ON company_address.province_id = province.id
            JOIN ward ON company_address.ward_id = ward.id
        WHERE
            company_address.active = TRUE
            AND province.active = TRUE
            AND ward.active = TRUE
    )
SELECT company.id, company.name, json_agg(
        json_build_object(
            'id', company_address_temp.id, 'provice_name', company_address_temp.province_name, 'ward_id', company_address_temp.ward_id, 'ward_name', company_address_temp.ward_name, 'address_detail', company_address_temp.address_detail
        )
    ) as address
FROM
    company
    JOIN company_address_temp ON company.id = company_address_temp.company_id
GROUP BY
    company.id,
    company.name
ORDER BY company.id ASC;