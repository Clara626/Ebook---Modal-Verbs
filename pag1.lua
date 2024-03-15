local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

local narracaoPag1 = audio.loadStream( "audios/audiopag1.mp3" )

-- create()
function scene:create( event )
    local sceneGroup = self.view
    
    local bgpag1 = display.newImageRect(utils.bgpag1, 768, 1024 )
    bgpag1.x = display.contentCenterX
    bgpag1.y = display.contentCenterY
    sceneGroup:insert( bgpag1 )

    local prev = display.newText( utils.prev, 0, 0, utils.font, 50 )
    prev.x = display.contentWidth * 0.15
    prev.y = display.contentHeight - 60
    prev:setFillColor( 255, 255, 255 )
    sceneGroup:insert( prev )

    prev:addEventListener( "tap", function()
        composer.gotoScene( "capa", "fade" )
    end )

    local next = display.newText( utils.next, 0, 0, utils.font, 50 )
    next.x = display.contentWidth * 0.85
    next.y = display.contentHeight * 0.94
    next:setFillColor( 255, 255, 255 )
    sceneGroup:insert( next )

    next:addEventListener( "tap", function()
        composer.gotoScene( "pag2", "fade" )
    end )

    local baudio = display.newImage(utils.baudio)
    baudio.x = display.contentCenterX
    baudio.y = display.contentCenterY + 420
    sceneGroup:insert( baudio )

    local flag = false
    local som = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY + 420, 70, 70 )
    som:setFillColor( 255, 255, 255 )
    som.alpha = 0.1

    som:addEventListener( "tap", function(event)
        if flag then 
            audio.stop( )
        else 
            audio.play( narracaoPag1 )
        end  
        flag = not flag 
        print( flag )
    end)

    local image1 = display.newImage("interacoes/p01/bookclose.png")
    image1.width = 400  -- largura desejada
    image1.height = 400 -- altura desejada
    image1.x = display.contentCenterX
    image1.y = display.contentCenterY + 150
    sceneGroup:insert(image1)

    local image2 = display.newImage("interacoes/p01/book1.png")
    image2.width = 400  -- largura desejada
    image2.height = 400 -- altura desejada
    image2.x = display.contentCenterX
    image2.y = display.contentCenterY + 150
    sceneGroup:insert(image2)
    image2.isVisible = false

    local image3 = display.newImage("interacoes/p01/book2.png")
    image3.width = 400  -- largura desejada
    image3.height = 400 -- altura desejada
    image3.x = display.contentCenterX
    image3.y = display.contentCenterY + 150
    sceneGroup:insert(image3)
    image3.isVisible = false

    -- Função para alternar imagens
    local function switchImage(event)
        if image1.isVisible then
            image1.isVisible = false
            image2.isVisible = true
        elseif image2.isVisible then
            image2.isVisible = false
            image3.isVisible = true
        else
            image3.isVisible = false
            image1.isVisible = true
        end
    end

    -- Adiciona evento de toque para cada imagem
    image1:addEventListener("tap", switchImage)
    image2:addEventListener("tap", switchImage)
    image3:addEventListener("tap", switchImage)
end

scene:addEventListener( "create", scene )

return scene
