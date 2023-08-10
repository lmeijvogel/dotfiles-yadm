#!/usr/bin/env ruby

require 'ipaddr'
require 'open3'
require 'socket'

NETWORK_MASK = "24"

SEPARATOR = "-@*@%@*-"

class StatusUnknown < StandardError ; end

class HostNotAvailable < StandardError ; end

def query_mpd_status(mpd_host)
  `ping -c 1 -W 1 -q #{mpd_host}`

  if !$?.success?
    raise HostNotAvailable, "Ping failed"
  end

  format = %w[albumartist artist title].map {|s| "%#{s}%"}.join(SEPARATOR)

  mpd_status, exit_status = Open3.capture2e(
    "mpc",
    "--host", mpd_host,
    "--format", format,
    "status"
  )

  if !exit_status.success?
    raise HostNotAvailable, "Could not contact service"
  end

  mpd_status.lines
end

def main(mpd_host)
  mpd_status = query_mpd_status(mpd_host)

  if mpd_status.length <= 1
    puts ""
    exit
  end

  description, song_status, _ = mpd_status

  playing_state, current, total = read_player_state(song_status)

  playing_mode = case playing_state
                 when "paused" then ""
                 when "playing" then ""
                 when "stopped" then puts ""; return
  end

  albumartist, artist, title = description.strip.split(SEPARATOR)

  title = truncate(title, 70)

  song_description = if albumartist == "Various Artists"
                       "#{artist} - #{title}"
                     else
                       title
                     end

  "#{playing_mode} #{song_description} (#{current}/#{total})"
rescue HostNotAvailable
  puts ""
rescue StatusUnknown
  puts ""
end

def truncate(title, size)
  if title.length > size
    title[0..size - 3] + "..."
  else
    title
  end
end

def read_player_state(song_status)
  if song_status =~ /^ERROR:/
    return ["stopped"]
  end

  matches = song_status.match(%r{\[([^\]]+)\]\s+#(\d+)/(\d+)})

  raise StatusUnknown if !matches
  matches[1, 3]
end

def toggle_play_paused(mpd_host)
  `ruby --disable-gems #{ENV["HOME"]}/bin/toggle-mpd-playing #{mpd_host}`
end

mpd_host = ARGV[-1]

exit 0 if mpd_host.nil?

if ARGV.any?("--status-only")
  mpd_network = IPAddr.new("#{mpd_host}/#{NETWORK_MASK}")
  ip_addresses = Socket.ip_address_list.select(&:ipv4?).map(&:ip_address)

  # If we're not on the same network, I don't want to
  # create a useless entry on the bottom bar.
  if ip_addresses.none? { |ip_address| mpd_network.include?(ip_address) }
    puts # If there is no output, the bottom bar won't be updated. This forces the update.

    exit
  end

  _, song_status, _ = query_mpd_status(mpd_host)

  if song_status && song_status !~ /^ERROR/
    playing_state, _, _ = read_player_state(song_status)

    puts playing_state
  else
    puts "stopped"
  end
elsif ARGV.any?("--toggle")
  toggle_play_paused
else
  title = main(mpd_host)
  puts "%{A1:#{$0} --toggle:}#{title}%{A}"
end

# vim: set ft=ruby
