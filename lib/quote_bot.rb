require "quote_bot/version"
require 'slack-ruby-bot'
require 'sequel'

module QuoteBot
  class Quote < SlackRubyBot::Bot

    DB = Sequel.sqlite('db/quotes.db')

    match /^(\.){2} (?<name>(\S)*) (?<text>.*)/ do |client, data, match|
      quotes = DB[:quotes]
      quotes.insert(:name => match[:name], :quote_text => match[:text])
    end

    match /^(\.){3} (?<name>(\S)*)/ do |client, data, match|
      quotes = DB[:quotes]
      quote = quotes.filter(name: match[:name]).to_a.sample
      client.say(channel: data.channel, text: "#{quote[:quote_text]}")
    end
  end
end

QuoteBot::Quote.run
