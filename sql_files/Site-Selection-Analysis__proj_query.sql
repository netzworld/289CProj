WITH road_sites AS (
  -- Select road segments with specified ROAD_CLASS, without ASE devices within 15m,
  -- and within threshold of a community safety zone
  SELECT
    tr.*,
    COUNT(tc.gid) AS collision_count
  FROM
    toronto_road tr
  LEFT JOIN
    ase a ON ST_DWithin(tr.geom, a.geom, 15)
  LEFT JOIN
    traffic_collisions tc ON ST_DWithin(tr.geom, tc.geom, 100)  -- Adjust the distance as needed
  WHERE
    tr.ROAD_CLASS IN ('Arterial', 'Collector', 'Local / Street')
    AND a.gid IS NULL  -- No ASE device within 15m
    AND EXISTS (
      SELECT 1
      FROM comm_safe_zones csz
      WHERE ST_DWithin(tr.geom, csz.geom, 20)  -- Within threshold of a community safety zone
    )
	AND tc.OCC_YEA5 BETWEEN 2022 AND 2023  -- Traffic collisions between 2022 and 2023
  GROUP BY
    tr.gid
)
-- Rank road segments based on collision count
SELECT
  road_sites.gid, road_sites.ogf_id, road_sites.official_s, road_sites.collision_count
FROM
  road_sites
ORDER BY
  collision_count DESC
LIMIT 10;  -- Output the top 10 road segments
