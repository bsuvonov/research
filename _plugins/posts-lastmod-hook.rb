#!/usr/bin/env ruby
#
# Check for changed posts

require "time"

Jekyll::Hooks.register :posts, :post_init do |post|

  commit_num = `git rev-list --count HEAD "#{ post.path }"`

  if commit_num.to_i > 0
    lastmod_date = `git log -1 --pretty="%ad" --date=iso "#{ post.path }"`
    lastmod_date = lastmod_date.strip
    unless lastmod_date.empty?
      lastmod_time = Time.parse(lastmod_date)
      post.data["last_modified_at"] = lastmod_time

      # Keep the original post date but use last push time to break ties.
      post_date = post.date
      post.date = Time.new(
        post_date.year,
        post_date.month,
        post_date.day,
        lastmod_time.hour,
        lastmod_time.min,
        lastmod_time.sec,
        lastmod_time.utc_offset
      )
    end
  end

end
