require "spec_helper"

describe StockHistory do
  it "has a version number" do
    expect(StockHistory::VERSION).not_to be nil
  end

  it "history in normal situation" do
    results = StockHistory.history('DRYS',  :start_date => '2017-01-25', :stop_date => '2017-01-30')
    results.count.should  == 4
    results.first[:date].should == '20170130'
    results.first[:date_parsed].should == Date.parse('2017-01-30')
    results.first[:open].should == 2.05
    results.first[:high].should == 2.65
    results.first[:low].should == 1.99
    results.first[:close].should == 2.46
    results.first[:volume].should == 50435500.0
    results.first[:adjusted_close].should_not be_nil
    results.first[:split].should be_nil
    results.first[:merge].should be_nil
    results.first[:dividend].should be_nil
  end

  it "history with dividend" do
    results = StockHistory.history('GDXJ',  :start_date => '2016-12-18', :stop_date => '2016-12-21')
    results.count.should  == 4
    results[2][:dividend].should == 1.51
  end

  it "history with split" do
    results = StockHistory.history('DRYS',  :start_date => '2017-01-20', :stop_date => '2017-01-25')
    results.count.should  == 4
    results[2][:split].should == 1
    results[2][:merge].should == 8
  end
end
