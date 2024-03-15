local utils = require("utils")
local composer = require("composer")
local scene = composer.newScene()

local narracaoPag5 = audio.loadStream("audios/audiopag5.mp3")
local musicaPag5 = audio.loadStream("interacoes/p05/Should_I_Stay_Should_I_Go.mp3")

local isMusicPlaying = false
local shakeThreshold = 1.2 -- ajustar esse valor conforme necessário

local function onShake(event)
    local threshold = shakeThreshold
    if event.isShake and not isMusicPlaying then
        audio.play(musicaPag5, {loops=-1}) 
        isMusicPlaying = true
    elseif event.isShake and isMusicPlaying then
        audio.stop()
        isMusicPlaying = false
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bgpag5 = display.newImageRect(utils.bgpag5, 768, 1024)
    bgpag5.x = display.contentCenterX
    bgpag5.y = display.contentCenterY
    sceneGroup:insert(bgpag5)

    local prev = display.newText(utils.prev, 0, 0, utils.font, 50)
    prev.x = display.contentWidth * 0.15
    prev.y = display.contentHeight - 60
    prev:setFillColor(255, 255, 255)
    sceneGroup:insert(prev)

    prev:addEventListener("tap", function()
        composer.gotoScene("pag4", "fade")
    end)

    local next = display.newText(utils.next, 0, 0, utils.font, 50)
    next.x = display.contentWidth * 0.85
    next.y = display.contentHeight * 0.94
    next:setFillColor(255, 255, 255)
    sceneGroup:insert(next)

    next:addEventListener("tap", function()
        composer.gotoScene("pag6", "fade")
    end)

    local imagecaixa = display.newImage("interacoes/p05/caixasom.png")
    imagecaixa.x = display.contentCenterX
    imagecaixa.y = display.contentCenterY + 160
    sceneGroup:insert(imagecaixa)

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
            audio.play(narracaoPag5)
        end
        flag = not flag
        print(flag)
    end)

    -- Adiciona o evento de aceleração ao entrar na cena
    Runtime:addEventListener("accelerometer", onShake)
end

-- destroy()
function scene:destroy(event)
    Runtime:removeEventListener("accelerometer", onShake)
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
