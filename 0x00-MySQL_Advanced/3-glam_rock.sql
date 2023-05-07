-- This script lists all bands with Glam rock as their main style, ranked by their longevity
-- Select the band name and calculate the lifespan in years using the split and formed attributes
SELECT band_name, YEAR(MAX(split))-YEAR(MIN(formed)) AS lifespan
FROM metal_bands
WHERE style LIKE '%Glam rock%'
GROUP BY band_name
ORDER BY lifespan DESC;
