local utils = require("utils")
local composer = require("composer")
local scene = composer.newScene()

local narracaoPag4 = audio.loadStream("audios/audiopag4.mp3")
local soundTable = {
    narracaoPag4 = audio.loadSound("audios/audiopag4.mp3"),
}

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bgpag4 = display.newImageRect(utils.bgpag4, 768, 1024)
    bgpag4.x = display.contentCenterX
    bgpag4.y = display.contentCenterY
    sceneGroup:insert(bgpag4)

    local prev = display.newText(utils.prev, 0, 0, utils.font, 50)
    prev.x = display.contentWidth * 0.15
    prev.y = display.contentHeight - 60
    prev:setFillColor(255, 255, 255)
    sceneGroup:insert(prev)

    prev:addEventListener("tap", function()
        composer.gotoScene("pag3", "fade")
    end)

    local next = display.newText(utils.next, 0, 0, utils.font, 50)
    next.x = display.contentWidth * 0.85
    next.y = display.contentHeight * 0.94
    next:setFillColor(255, 255, 255)
    sceneGroup:insert(next)

    next:addEventListener("tap", function()
        composer.gotoScene("pag5", "fade")
    end)

    local baudio = display.newImage(utils.baudio)
    baudio.x = display.contentCenterX
    baudio.y = display.contentCenterY + 420
    sceneGroup:insert(baudio)

    local flag = false
    local som = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY + 420, 70, 70)
    som:setFillColor(255, 255, 255)
    som.alpha = 0.1

    som:addEventListener("tap",
        function(event)
            if flag then
                audio.stop()
            else
                audio.play(narracaoPag4)
            end
            flag = not flag
            print(flag)
        end
    )

    local startX = display.contentCenterX - 130
    local startY = display.contentCenterY - 70

    local imagestart1 = display.newImage("interacoes/p04/janelastart.png")
    imagestart1.width = 200
    imagestart1.height = 200
    imagestart1.x = startX
    imagestart1.y = startY
    sceneGroup:insert(imagestart1)

    local imagestart2 = display.newImage("interacoes/p04/janelastart.png")
    imagestart2.width = 200
    imagestart2.height = 200
    imagestart2.x = startX + 250
    imagestart2.y = startY
    sceneGroup:insert(imagestart2)

    local imagestart3 = display.newImage("interacoes/p04/janelastart.png")
    imagestart3.width = 200
    imagestart3.height = 200
    imagestart3.x = startX
    imagestart3.y = startY + 300
    sceneGroup:insert(imagestart3)

    local imagestart4 = display.newImage("interacoes/p04/janelastart.png")
    imagestart4.width = 200
    imagestart4.height = 200
    imagestart4.x = startX + 250
    imagestart4.y = startY + 300
    sceneGroup:insert(imagestart4)

    local image1 = display.newImage("interacoes/p04/janela1.png")
    image1.width = 600
    image1.height = 600
    image1.x = display.contentCenterX
    image1.y = display.contentCenterY + 150
    sceneGroup:insert(image1)
    image1.isVisible = false

    local image2 = display.newImage("interacoes/p04/janela2.png")
    image2.width = 600
    image2.height = 600
    image2.x = display.contentCenterX
    image2.y = display.contentCenterY + 150
    sceneGroup:insert(image2)
    image2.isVisible = false

    local image3 = display.newImage("interacoes/p04/janela3.png")
    image3.width = 600
    image3.height = 600
    image3.x = display.contentCenterX
    image3.y = display.contentCenterY + 150
    sceneGroup:insert(image3)
    image3.isVisible = false

    local image4 = display.newImage("interacoes/p04/janela4.png")
    image4.width = 600
    image4.height = 600
    image4.x = display.contentCenterX
    image4.y = display.contentCenterY + 150
    sceneGroup:insert(image4)
    image4.isVisible = false

    -- Manipuladores de eventos para cada imagestart
    imagestart1:addEventListener("tap", function()
        image1.isVisible = true
        image2.isVisible = false
        image3.isVisible = false
        image4.isVisible = false
        imagestart1.isVisible = false
        imagestart2.isVisible = false
        imagestart3.isVisible = false
        imagestart4.isVisible = false
    end)

    imagestart2:addEventListener("tap", function()
        image1.isVisible = false
        image2.isVisible = true
        image3.isVisible = false
        image4.isVisible = false
        imagestart1.isVisible = false
        imagestart2.isVisible = false
        imagestart3.isVisible = false
        imagestart4.isVisible = false
    end)

    imagestart3:addEventListener("tap", function()
        image1.isVisible = false
        image2.isVisible = false
        image3.isVisible = true
        image4.isVisible = false
        imagestart1.isVisible = false
        imagestart2.isVisible = false
        imagestart3.isVisible = false
        imagestart4.isVisible = false
    end)

    imagestart4:addEventListener("tap", function()
        image1.isVisible = false
        image2.isVisible = false
        image3.isVisible = false
        image4.isVisible = true
        imagestart1.isVisible = false
        imagestart2.isVisible = false
        imagestart3.isVisible = false
        imagestart4.isVisible = false
    end)

    -- Manipuladores de eventos para cada imagem final (image1, image2, image3, image4) para restaurar a visibilidade dos imagestart
    image1:addEventListener("tap", function()
        image1.isVisible = false
        imagestart1.isVisible = true
        imagestart2.isVisible = true
        imagestart3.isVisible = true
        imagestart4.isVisible = true
    end)

    image2:addEventListener("tap", function()
        image2.isVisible = false
        imagestart1.isVisible = true
        imagestart2.isVisible = true
        imagestart3.isVisible = true
        imagestart4.isVisible = true
    end)

    image3:addEventListener("tap", function()
        image3.isVisible = false
        imagestart1.isVisible = true
        imagestart2.isVisible = true
        imagestart3.isVisible = true
        imagestart4.isVisible = true
    end)

    image4:addEventListener("tap", function()
        image4.isVisible = false
        imagestart1.isVisible = true
        imagestart2.isVisible = true
        imagestart3.isVisible = true
        imagestart4.isVisible = true
    end)

end

scene:addEventListener("create", scene)

return scene
