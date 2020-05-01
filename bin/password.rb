#!/usr/bin/env ruby
#
require 'securerandom'

trap("SIGINT") { exit 0 }

def main(count)
  words = File.read("/usr/share/dict/words")
    .split("\n")
    .map(&:strip)
    .select { |word| word =~ /\A[A-Za-z]*\z/ }
    .map(&:downcase)

  loop do
    puts words.sample(count).join(" ")
    $stdin.gets
  end
end

count = ARGV.fetch(0, 4).to_i

main(count)
