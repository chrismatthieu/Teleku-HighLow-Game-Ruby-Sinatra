require 'rubygems'
require 'sinatra'
require 'builder'

get '/' do
  'HighLow is a <a href="teleku.com">Teleku Voice Application</a><br>'
  'curl --data-urlencode "caller=test" http://highlow.heroku.com'
end

post '/' do 
  deal = 1 + rand(10)
  builder do |xml|
    xml.instruct!
    xml.phoneml do
      xml.speak "welcome to the game of high low"
      xml.speak "the dealer randomly selected " + deal.to_s
      xml.speak "will his next number be higher or lower? press 1 or say higher or press 2 or say lower"
      xml.input "http://highlow.heroku.com/guess/" + deal.to_s, "options"=>"1,2,higher,lower"
    end
  end
end

post '/guess/:deal' do 
  newdeal = 1 + rand(10)
  guess = params[:callerinput]
  if guess == '1' or guess == 'higher'
    if newdeal > params[:deal].to_i 
      gamestatus = "winner"
    else
      gamestatus = "loser"
    end
  end  

  if guess == '2' or guess == 'lower'
    if newdeal < params[:deal].to_i  
      gamestatus = "winner"
    else
      gamestatus = "loser"
    end
  end  
    
  builder do |xml|
    xml.instruct!
    xml.phoneml do
      xml.speak "the dealer randomly selected " + newdeal.to_s
      xml.speak "you are a " + gamestatus     
      xml.speak "will his next number be higher or lower? press 1 or say higher or press 2 or say lower"
      xml.input "http://highlow.heroku.com/guess/" + newdeal.to_s, "options"=>"1,2,higher,lower"
    end
  end
end
  