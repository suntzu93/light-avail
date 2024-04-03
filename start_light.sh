#!/bin/bash

# Initialize an infinite loop
while true; do
    # Request the headers of the URL
    response=$(curl --connect-timeout 5 -sI "localhost:7000/health")

    if echo "$response" | grep -q "200 OK"; then
        echo "Service is running fine"
    else
        echo "Service is down, restarting..."

        # Kill tmux session named 'light' if it exists
        tmux kill-session -t light 2>/dev/null

        # Start new tmux session named 'light'
        tmux new-session -d -s light

        # Run the command inside the new 'light' tmux session
        tmux send-keys -t light "curl -sL1 avail.sh | bash" ENTER
        echo "sleep 100s after restart"
        sleep 100
    fi

    echo "Sleep for 5 seconds before next health check ..."
    sleep 5
done
