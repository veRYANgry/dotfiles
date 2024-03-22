#!/bin/sh

# Define an array of wallpaper paths (replace with your actual paths)
wallpapers=(
~/wallpapers/anna-lovchikova-anna-lovchikova-full.gif
~/wallpapers/copyimage.gif
~/wallpapers/field.gif
~/wallpapers/futurecity.gif
~/wallpapers/stars.gif
~/wallpapers/yellowthings.gif
~/wallpapers/brokenwar.gif
~/wallpapers/downloading.gif
~/wallpapers/futurecats.gif
~/wallpapers/futuredate.gif
~/wallpapers/work.gif
)

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=144
export SWWW_TRANSITION_STEP=2

# Get the current workspace number (assuming it's less than 10)
current_workspace=$(echo "$wallpapers" | wc -w)

# Function to set wallpaper for a specific workspace
set_wallpaper() {
  workspace_num=$1
  wallpaper_path=${wallpapers[$workspace_num-1]}  # Access by index (0-based)i
  echo "$wallpaper_path"
  swww img "$wallpaper_path" --transition-type none
}

# Function to handle workspace change events
handle_workspace_change() {
  # Check if event relates to workspace change
  if [[ ${1:0:9} == "workspace" ]]; then
    # Get the new workspace number
    new_workspace=$(echo "$1" | sed -n 's/workspace>>\([^ ]*\).*/\1/p')
    echo "$new_workspace"
    # Check if workspace changed and avoid setting if returning to same one
    if [[ "$new_workspace" != "$current_workspace" ]]; then
      # Set the wallpaper for the new workspace
      set_wallpaper "$new_workspace"

      # Update current workspace for tracking
      current_workspace="$new_workspace"
    fi
  fi
}

# Continuously listen for events on the Hyprland socket
socat - UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock | while read -r line; do handle_workspace_change "$line"; done
