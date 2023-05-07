-- This script lists all bands with Glam rock as their main style, ranked by their longevity
-- Select the band name and calculate the lifespan in years using the split and formed attributes
SELECT band_name, 
    	(CASE
		WHEN split IS NULL THEN YEAR(CURDATE()) - formed
		ELSE split - formed
	END) AS lifespan
FROM metal_bands
WHERE style LIKE '%Glam rock%'
ORDER BY lifespan DESC;
