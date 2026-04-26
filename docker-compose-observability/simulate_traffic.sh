#!/bin/bash

BASE_URL="http://localhost:8000"
ROUNDS=20
FASTAPI_CONTAINER=$(docker-compose ps -q fastapi-app | xargs docker inspect --format '{{.Name}}' | sed 's/\///')

echo "Starting memory simulation in background..."
docker exec "$FASTAPI_CONTAINER" python3 -c "
import time
chunks = []
for i in range($ROUNDS):
    chunks.append(b'0' * 10_000_000)
    print(f'Memory allocated: ~{(i+1)*10}MB', flush=True)
    time.sleep(3)
" &
MEMORY_PID=$!

echo "Starting traffic simulation ($ROUNDS rounds)..."

for i in $(seq 1 $ROUNDS); do
  echo "--- Round $i ---"

  # Create a fresh item and capture its ID
  ITEM_ID=$(curl -s -X POST "$BASE_URL/items" \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"Item $i\"}" | grep -o '"id":[0-9]*' | grep -o '[0-9]*')

  # --- Successful requests (bulk) ---
  curl -s "$BASE_URL/" > /dev/null
  curl -s "$BASE_URL/" > /dev/null
  curl -s "$BASE_URL/" > /dev/null

  if [ -n "$ITEM_ID" ]; then
    curl -s "$BASE_URL/items/$ITEM_ID" > /dev/null
    curl -s "$BASE_URL/items/$ITEM_ID" > /dev/null
    curl -s -X PUT "$BASE_URL/items/$ITEM_ID" \
      -H "Content-Type: application/json" \
      -d "{\"name\": \"Updated Item $i\"}" > /dev/null
    curl -s "$BASE_URL/items/$ITEM_ID" > /dev/null
    curl -s -X DELETE "$BASE_URL/items/$ITEM_ID" > /dev/null
  fi

  # --- Simulate errors (1-2 per round) ---

  # 404 - item that doesn't exist
  curl -s "$BASE_URL/items/99999" > /dev/null

  # 422 - POST with invalid body (every other round to reduce error rate)
  if (( i % 2 == 0 )); then
    curl -s -X POST "$BASE_URL/items" \
      -H "Content-Type: application/json" \
      -d '{"wrong_field": 123}' > /dev/null
  fi

  sleep 0.3
done

echo "The request simulation has been completed"

# Wait for memory simulation to finish
wait $MEMORY_PID 2>/dev/null
echo "Memory simulation completed"