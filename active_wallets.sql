WITH top_chains AS (
  SELECT blockchain
  FROM dex.trades
  WHERE block_date >= current_date - INTERVAL '30' DAY
  GROUP BY blockchain
  ORDER BY SUM(amount_usd) DESC
  LIMIT 5
)

SELECT
  block_date,
  t.blockchain,
  COUNT(DISTINCT tx_from) AS active_wallets
FROM dex.trades t
JOIN top_chains tc
  ON t.blockchain = tc.blockchain
WHERE t.block_date >= current_date - INTERVAL '30' DAY
GROUP BY 1, 2
ORDER BY 1
