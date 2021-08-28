#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      bio_node.css('span').text.tidy
    end

    def position
      noko.text.tidy.split(/(?:and (?=Minister)|&)/).map(&:tidy)
    end

    private

    # The bios are mouseovered in from a different section
    def bio_node
      noko.xpath("//div[@id='#{bio_id}']")
    end

    def bio_id
      noko.xpath('ancestor::a/@data-src').text
    end
  end

  class Members
    def member_container
      noko.css('.article-links .bordered-item p')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
