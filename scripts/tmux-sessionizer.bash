#!/usr/bin/env bash
#TODO: This will be a script for handling tmux sessions and windows

session=$(find ~ ~/code -mindepth 1 -maxdepth 1 -type d | fzf)
session_name="$(basename $session | tr . " ")"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
	tmux new -s "$session_name" -c "$session" -d
	tmux rename-window $session_name
fi

tmux switch-client -t "$session_name"
