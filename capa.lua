local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()


local narracaoPag4 = audio.loadStream( "audios/narracaocapa.mp3" )
local soundTable = {
	narracaoPag4 = audio.loadSound( "audios/narracaocapa.mp3" ),
}


-- create()
function scene:create( event )
    local sceneGroup = self.view
    
    local capa = display.newImageRect(utils.capa, 768, 1024 )
    capa.x = display.contentCenterX
    capa.y = display.contentCenterY
    sceneGroup:insert( capa )

    local next = display.newText( utils.next, 0, 0, utils.font, 50 )
	next.x = display.contentWidth * 0.85
	next.y = display.contentHeight * 0.94
	next:setFillColor( 255, 255, 255 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pag1", "fade" )
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