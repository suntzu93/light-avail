#!/bin/bash

# Start new tmux session named 'monitor'
tmux new-session -d -s monitor

curl -sLO https://raw.githubusercontent.com/suntzu93/light_moon/main/start_light.sh
chmod +x ./start_light.sh

# Run check_light.sh inside the 'monitor' tmux session
tmux send-keys -t monitor "bash start_light.sh" ENTER
