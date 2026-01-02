#!/usr/bin/env ruby
# frozen_string_literal: true

require "time"

# Ensure posts with the same date are ordered by latest push (last_modified_at).
parse_time = lambda do |value|
  return value if value.is_a?(Time)
  return nil if value.nil? || value.to_s.strip.empty?

  Time.parse(value.to_s)
rescue ArgumentError
  nil
end

Jekyll::Hooks.register :site, :post_read do |site|
  posts = site.posts.docs

  posts.sort! do |a, b|
    date_cmp = b.date.to_date <=> a.date.to_date
    next date_cmp unless date_cmp.zero?

    a_mod = parse_time.call(a.data["last_modified_at"]) || a.date
    b_mod = parse_time.call(b.data["last_modified_at"]) || b.date

    mod_cmp = b_mod <=> a_mod
    next mod_cmp unless mod_cmp.zero?

    b.date <=> a.date
  end
end
