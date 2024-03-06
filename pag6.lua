local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

local narracaoPag6 = audio.loadStream( "audios/audiopag6.mp3" )
local soundTable = {
	narracaoPag6 = audio.loadSound( "audios/audiopag6.mp3" ),
}


-- create()
function scene:create( event )
    local sceneGroup = self.view
    
    local bgpag6 = display.newImageRect(utils.bgpag6, 768, 1024 )
    bgpag6.x = display.contentCenterX
    bgpag6.y = display.contentCenterY
    sceneGroup:insert( bgpag6 )

    local prev = display.newText( utils.prev, 0, 0, utils.font, 50 )
	prev.x = display.contentWidth * 0.15
	prev.y = display.contentHeight - 60
	prev:setFillColor( 255, 255, 255 )
	sceneGroup:insert( prev )

    prev:addEventListener( "tap", function()
		composer.gotoScene( "pag5", "fade" )
	end )

    local next = display.newText( utils.next, 0, 0, utils.font, 50 )
	next.x = display.contentWidth * 0.85
	next.y = display.contentHeight * 0.94
	next:setFillColor( 255, 255, 255 )
	sceneGroup:insert( next )

    next:addEventListener( "tap", function()
		composer.gotoScene( "contracapa", "fade" )
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
				audio.play( narracaoPag6 )
			end  
			flag = not flag 
			print( flag )
		end				   	

	)


 
end

scene:addEventListener( "create", scene )

return scene