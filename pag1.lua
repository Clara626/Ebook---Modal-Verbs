local utils = require("utils")
local composer = require("composer")
local scene = composer.newScene()

local narracaoPag1 = audio.loadStream("audios/audiopag1.mp3")

local narracaobook1 = audio.loadStream("interacoes/p01/musicCan.mp3")
local narracaobook2 = audio.loadStream("interacoes/p01/musicMay.mp3")
local narracaobook3 = audio.loadStream("interacoes/p01/musicWill.mp3")
local narracaobook4 = audio.loadStream("interacoes/p01/musicShall.mp3")
local narracaobook5 = audio.loadStream("interacoes/p01/musicMust.mp3")

-- Lista de imagens
local images = {
    "interacoes/p01/bookclose.png",
    "interacoes/p01/book01.png",
    "interacoes/p01/book02.png",
    "interacoes/p01/book03.png",
    "interacoes/p01/book04.png",
    "interacoes/p01/book05.png"
}

-- Variável para controlar o índice da imagem atual
local currentImageIndex = 1

-- Função para trocar a imagem
local function switchImage()
    -- Torna a imagem atual invisível
    scene.view.images[currentImageIndex].isVisible = false
    -- Avança para a próxima imagem
    currentImageIndex = currentImageIndex % #images + 1
    -- Torna a próxima imagem visível
    scene.view.images[currentImageIndex].isVisible = true

    -- Verifica qual narração deve ser tocada
    if currentImageIndex == 2 then
        audio.play(narracaobook1)
    elseif currentImageIndex == 3 then
        audio.play(narracaobook2)
    elseif currentImageIndex == 4 then
        audio.play(narracaobook3)
    elseif currentImageIndex == 5 then
        audio.play(narracaobook4)
    elseif currentImageIndex == 6 then
        audio.play(narracaobook5)
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bgpag1 = display.newImageRect(utils.bgpag1, 768, 1024)
    bgpag1.x = display.contentCenterX
    bgpag1.y = display.contentCenterY
    sceneGroup:insert(bgpag1)

    local prev = display.newText(utils.prev, 0, 0, utils.font, 50)
    prev.x = display.contentWidth * 0.15
    prev.y = display.contentHeight - 60
    prev:setFillColor(255, 255, 255)
    sceneGroup:insert(prev)

    prev:addEventListener("tap", function()
        composer.gotoScene("capa", "fade")
    end)

    local next = display.newText(utils.next, 0, 0, utils.font, 50)
    next.x = display.contentWidth * 0.85
    next.y = display.contentHeight * 0.94
    next:setFillColor(255, 255, 255)
    sceneGroup:insert(next)

    next:addEventListener("tap", function()
        composer.gotoScene("pag2", "fade")
    end)

    local baudio = display.newImage(utils.baudio)
    baudio.x = display.contentCenterX
    baudio.y = display.contentCenterY + 420
    sceneGroup:insert(baudio)

    local flag = false
    local som = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY + 420, 70, 70)
    som:setFillColor(255, 255, 255)
    som.alpha = 0.1

    som:addEventListener("tap", function(event)
        if flag then
            audio.stop()
        else
            audio.play(narracaoPag1)
        end
        flag = not flag
        print(flag)
    end)

    -- Cria e insere todas as imagens no grupo de cena
    sceneGroup.images = {}
    for i, imagePath in ipairs(images) do
        local image = display.newImage(imagePath)
        image.width = 400 -- largura desejada
        image.height = 400 -- altura desejada
        image.x = display.contentCenterX
        image.y = display.contentCenterY + 150
        image.isVisible = false
        sceneGroup:insert(image)
        sceneGroup.images[i] = image
    end

    -- Exibe a primeira imagem
    sceneGroup.images[1].isVisible = true

    -- Adiciona evento de toque para cada imagem
    for i, image in ipairs(sceneGroup.images) do
        image:addEventListener("tap", switchImage)
    end
end

scene:addEventListener("create", scene)

return scene
