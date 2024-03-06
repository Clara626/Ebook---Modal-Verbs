local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

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

 
end

scene:addEventListener( "create", scene )

return scene