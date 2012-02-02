require "pongGame"
require "airHockeyGame"
require "ticTacToeGame"
require "eyeContactGame"
require "facebookGame"

function newMiniGame(gameName)
	local l_miniGame = {}

	if gameName == "Pong4One" then
		l_miniGame = newPongGame()
	elseif gameName == "Hockey4One" then
		l_miniGame = newAirHockeyGame()
	elseif gameName == "Tictac4One" then
		l_miniGame = newTicTacGame()
	elseif gameName == "EyeContact" then
		l_miniGame = newEyeContactGame()
	elseif gameName == "Facebook" then
		l_miniGame = newFacebookGame()
	end

	return l_miniGame
end
