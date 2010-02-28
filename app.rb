require 'rubygems'
require 'sinatra'
require 'builder'

post '/' do 
  session[:deal] = 1 + rand(10)
  builder do |xml|
    xml.instruct!
    xml.phoneml do
      xml.speak "welcome to the game of high low"
      xml.speak "the dealer randomly selected " + session[:deal].to_s
      xml.speak "will his next number be higher or lower? press 1 or say higher or press 2 or say lower"
      xml.input "/guess", "options"=>"1,2,higher,lower"
    end
  end
end

post '/guess' do 
  session[:newdeal] = 1 + rand(10)
  guess = params[:callerinput]
  if guess == '1' or guess == 'higher'
    if session[:newdeal] > session[:deal]
      gamestatus = "winner"
    else
      gamestatus = "loser"
    end
  end  

  if guess == '2' or guess == 'lower'
    if session[:newdeal] < session[:deal]
      gamestatus = "winner"
    else
      gamestatus = "loser"
    end
  end  
    
  session[:deal] = session[:newdeal]
  
  builder do |xml|
    xml.instruct!
    xml.phoneml do
      xml.speak "the dealer randomly selected " + session[:deal].to_s
      xml.speak "you are a " + gamestatus     
      xml.speak "will his next number be higher or lower? press 1 or say higher or press 2 or say lower"
      xml.input "/guess", "options"=>"1,2,higher,lower"
    end
  end
end
  