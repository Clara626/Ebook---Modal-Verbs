local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

local narracaoPag4 = audio.loadStream( "audios/narracaocontracapa.mp3" )
local soundTable = {
	narracaoPag4 = audio.loadSound( "audios/narracaocontracapa.mp3" ),
}

-- create()
function scene:create( event )
    local sceneGroup = self.view
    
    local contracapa = display.newImageRect(utils.contracapa, 768, 1024 )
    contracapa.x = display.contentCenterX
    contracapa.y = display.contentCenterY
    sceneGroup:insert( contracapa )

    local prev = display.newText( utils.prev, 0, 0, utils.font, 50 )
	prev.x = display.contentWidth * 0.15
	prev.y = display.contentHeight - 60
	prev:setFillColor( 255, 255, 255 )
	sceneGroup:insert( prev )

    prev:addEventListener( "tap", function()
		composer.gotoScene( "pag6", "fade" )
	end )

    local start = display.newText( utils.start, 0, 0, utils.font, 50 )
	start.x = display.contentWidth * 0.85
	start.y = display.contentHeight * 0.94
	start:setFillColor( 255, 255, 255 )
	sceneGroup:insert( start )

	start:addEventListener( "tap", function()
		composer.gotoScene( "capa", "fade" )
	end )

	local baudio = display.newImage(utils.baudio)
	baudio.x = display.contentCenterX
    baudio.y = display.contentCenterY + 420
	sceneGroup:insert( baudio )

	local flag = false
	local som = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY + 420, 70, 70 )
	som:setFillColor( 255, 255, 255 )
	som.alpha = 0.1

	som:addEventListener( "tap", 
		function(event)
			if flag then 
				audio.stop( )
			else 
				audio.play( narracaoPag4 )
			end  
			flag = not flag 
			print( flag )
		end				   	

	)

 
end

scene:addEventListener( "create", scene )

return scene