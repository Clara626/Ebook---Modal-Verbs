local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()


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

 
end

scene:addEventListener( "create", scene )

return scene