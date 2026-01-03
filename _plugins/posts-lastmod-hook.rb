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

      # Keep post.date stable; sorting ties is handled by posts-sorter.rb.
    end
  end

end
