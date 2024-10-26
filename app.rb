require "sinatra"
require "sinatra/reloader"

get("/") do
  "
  <h1>Dice Roll</h1>
  <form action='/process_roll' method='get'>
    <label for='dice'>Number of dice to roll?</label>
    <input type='number' id='dice' name='dice' min='1' required>
    <label for='sides'>How many sides per die?</label>
    <input type='number' id='sides' name='sides' min='2' required>
    <button type='submit'>Roll!</button>
  </form>
  "
end

get("/process_roll") do
  begin
    dice = params[:dice].to_i
    sides = params[:sides].to_i
    results = Array.new(dice) { rand(1..sides) }
    "
    <h1>#{dice}d#{sides}</h1>
    <a href='/process_roll?dice=#{dice}&sides=#{sides}'>Roll again</a> | <a href='/'>Go back home</a>
    <ol>
      #{results.map { |result| "<li><strong>Result:</strong> #{result}</li>" }.join}
    </ol>
    "
  rescue
    status 400
    "Invalid input. Please provide valid numbers for 'dice' and 'sides'."
  end
end

