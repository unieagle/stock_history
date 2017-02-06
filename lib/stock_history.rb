require "stock_history/version"
require 'net/http'
require 'json'
require 'date'
require 'stock_history/utility.rb'
require 'stock_history/exceptions.rb'
include StockHistory::Utility

module StockHistory

  # Get daily history for a symbol
  # Available params:
  # :start_date => '2016-01-01'
  # :end_date => Date.today.to_s
  # :freq => 'd', 'w' or 'm'
  def self.history(symbol, params={})
    his_params = {}
    his_params[:start_date] = to_date(params[:start_date])
    his_params[:stop_date] = to_date(params[:stop_date])
    his_params[:freq] = (%w(d w m).include?(params[:freq]) ? params[:freq] : 'd')

    url = build_url(symbol, his_params)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    parse_response(response)
  end

  private
  def self.parse_response(response)
    results = []
    lines = response.split("\n")

    if lines.count <= 5
      raise ParseException.new("Response format not correct")      
    end

    # Date,Open,High,Low,Close,Volume,Adj Close
    if lines[0] != "Date,Open,High,Low,Close,Volume,Adj Close"
      raise ParseException.new("Header not correct")
    end

    if lines[-1] != "STATUS, 0"
      raise ParseException.new("Status not correct")
    end

    # TOTALSIZE, 24
    total_size = 0
    unless lines[-2].start_with?("TOTALSIZE")
      raise ParseException.new("Size not parsed out")
    else
      total_size = lines[-2].split(',').last.to_i
    end

    # STARTDATE, 20161230
    # ENDDATE, 20170203
    start_date = nil
    end_date = nil
    unless lines[-3].start_with?("ENDDATE") or lines[-4].start_with?("STARTDATE")
      raise ParseException.new("Dates not parsed out")
    else
      start_date = lines[-4].split(',').last.strip
      end_date = lines[-3].split(',').last.strip
    end

    dividends = {}
    splits = {}

    lines[1..-5].each do |line|
      # puts line

      elements = line.split(",").map(&:strip)
      if elements.first == 'SPLIT'
        # this is reverse split (merge), and will apear above the daily history on that day
        # SPLIT, 20170123,1:8
        rates = elements.last.split(':').map(&:to_f)
        splits[elements[1]] = {
          :date => elements[1],
          :split => rates[0] < rates[1] ? 1.0 : rates[0] / rates[1],
          :merge => rates[0] < rates[1] ? rates[1] / rates[0] : 1.0
        }
      elsif elements.first == 'DIVIDEND'
        # this will apear above the daily history on that day
        # DIVIDEND, 20161219,1.507000
        dividends[elements[1]] = {
          :date => elements[1],
          :dividend => elements[2].to_f.round(2)
        }
      else
        # Date,Open,High,Low,Close,Volume,Adj Close
        # 20161219,28.889999,28.92,28.120001,28.43,27938700,28.43
        trading_date = to_date(elements.first)
        if trading_date.nil?
          raise ParseException.new("Format error on line: #{line}")
        end
        results << {
          :date         => elements[0],
          :date_parsed  => to_date(elements[0]),
          :open         => elements[1].to_f.round(2),
          :high         => elements[2].to_f.round(2),
          :low          => elements[3].to_f.round(2),
          :close        => elements[4].to_f.round(2),
          :volume       => elements[5].to_f.round(2),
          :adjusted_close => elements[6].to_f.round(2),
          :split        => splits[elements[0]] == nil ? nil : splits[elements[0]][:split],
          :merge        => splits[elements[0]] == nil ? nil : splits[elements[0]][:merge],
          :dividend     => dividends[elements[0]] == nil ? nil : dividends[elements[0]][:dividend],
        }
      end
    end

    results
  end

  def self.build_url(symbol, params={})
    params[:start_date] ||= Date.parse('2016-01-01')
    params[:stop_date]  ||= Date.today
    params[:freq]  ||= 'd'

    url_params = {}
    url_params['s'] = symbol.upcase
    url_params['a'] = params[:start_date].month - 1
    url_params['b'] = params[:start_date].day
    url_params['c'] = params[:start_date].year
    url_params['d'] = params[:stop_date].month - 1
    url_params['e'] = params[:stop_date].day
    url_params['f'] = params[:stop_date].year
    url_params['g'] = params[:freq]        
    url_params['y'] = '0'
    url_params['z'] = '30000'

    url = 'http://real-chart.finance.yahoo.com/x?'
    url_params.keys.sort.each do |key|
      url += "&#{key}=#{url_params[key]}"
    end

    url
  end
end
