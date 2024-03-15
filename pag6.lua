local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

local narracaoPag6 = audio.loadStream( "audios/audiopag6.mp3" )
local soundTable = {
	narracaoPag6 = audio.loadSound( "audios/audiopag6.mp3" ),
}

local musicFrase1 = audio.loadStream("interacoes/p06/audiofrase1.mp3")
local musicFrase2 = audio.loadStream("interacoes/p06audiofrase2.mp3")

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

	local image1 = display.newImage("interacoes/p06/menina.png")
    image1.width = 250  -- largura desejada
    image1.height = 250 -- altura desejada
    image1.x = display.contentCenterX
    image1.y = display.contentCenterY + 250
    sceneGroup:insert(image1)

	local imagefrase1 = display.newImage("interacoes/p06/frase1.png")
    imagefrase1.width = 250 -- largura desejada
    imagefrase1.height = 250 -- altura desejada
    imagefrase1.x = display.contentCenterX + 250
    imagefrase1.y = display.contentCenterY
    sceneGroup:insert(imagefrase1)

	local imagefrase2 = display.newImage("interacoes/p06/frase2.png")
    imagefrase2.width = 250 -- largura desejada
    imagefrase2.height = 250 -- altura desejada
    imagefrase2.x = display.contentCenterX -250
    imagefrase2.y = display.contentCenterY 
    sceneGroup:insert(imagefrase2)


 
end

scene:addEventListener( "create", scene )

return scene