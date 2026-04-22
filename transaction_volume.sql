WITH top_chains AS (
  SELECT blockchain
  FROM dex.trades
  GROUP BY blockchain
  ORDER BY SUM(amount_usd) DESC
  LIMIT 5
)

SELECT
  block_date,
  t.blockchain,
  SUM(amount_usd) AS volume_usd
FROM dex.trades t
JOIN top_chains tc
  ON t.blockchain = tc.blockchain
GROUP BY 1, 2
ORDER BY 1
