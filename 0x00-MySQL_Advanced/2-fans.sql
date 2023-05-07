-- SQL script that ranks country origins of bands
-- ordered by the number of (non-unique) fans
-- Create a temporary table that groups the bands by origin and sums their number of fans
CREATE TEMPORARY TABLE band_counts
SELECT origin, SUM(nb_fans) AS total_fans
FROM bands
GROUP BY origin;

-- Create an index on the total_fans column for performance
CREATE INDEX total_fans_idx ON band_counts (total_fans);

-- Select the origin and total number of fans, ordered by the number of fans in descending order
SELECT origin, total_fans
FROM band_counts
ORDER BY total_fans DESC;
