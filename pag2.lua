local utils = require("utils")
local composer = require("composer")
local scene = composer.newScene()

local narracaoPag2 = audio.loadStream("audios/audiopag2.mp3")
local narracaoCan = audio.loadStream("interacoes/p02/musicBoyCan.mp3")
local narracaoCould = audio.loadStream("interacoes/p02/musicBoyCould.mp3")

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bgpag2 = display.newImageRect(utils.bgpag2, 768, 1024)
    bgpag2.x = display.contentCenterX
    bgpag2.y = display.contentCenterY
    sceneGroup:insert(bgpag2)

    local prev = display.newText(utils.prev, 0, 0, utils.font, 50)
    prev.x = display.contentWidth * 0.15
    prev.y = display.contentHeight - 60
    prev:setFillColor(255, 255, 255)
    sceneGroup:insert(prev)

    prev:addEventListener("tap", function()
        composer.gotoScene("pag1", "fade")
    end)

    local next = display.newText(utils.next, 0, 0, utils.font, 50)
    next.x = display.contentWidth * 0.85
    next.y = display.contentHeight * 0.94
    next:setFillColor(255, 255, 255)
    sceneGroup:insert(next)

    next:addEventListener("tap", function()
        composer.gotoScene("pag3", "fade")
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
                audio.play(narracaoPag2)
            end
            flag = not flag
            print(flag)
        end
    )

    local image1 = display.newImage("interacoes/p02/start.png")
    image1.width = 500 -- largura desejada
    image1.height = 450 -- altura desejada
    image1.x = display.contentCenterX - 100
    image1.y = display.contentCenterY + 214
    sceneGroup:insert(image1)

    local image3 = display.newImage("interacoes/p02/can.png")
    image3.width = 500 -- largura desejada
    image3.height = 450 -- altura desejada
    image3.x = display.contentCenterX - 140
    image3.y = display.contentCenterY + 214
    sceneGroup:insert(image3)
    image3.isVisible = false

    local image4 = display.newImage("interacoes/p02/could.png")
    image4.width = 500 -- largura desejada
    image4.height = 450 -- altura desejada
    image4.x = display.contentCenterX - 140
    image4.y = display.contentCenterY + 214
    sceneGroup:insert(image4)
    image4.isVisible = false

    local imagecan = display.newImage("interacoes/p02/btcan.png")
    imagecan.width = 100 -- largura desejada
    imagecan.height = 80 -- altura desejada
    imagecan.x = display.contentCenterX + 300
    imagecan.y = display.contentCenterY + 70
    sceneGroup:insert(imagecan)

    local imagecould = display.newImage("interacoes/p02/btcould.png")
    imagecould.width = 100 -- largura desejada
    imagecould.height = 80 -- altura desejada
    imagecould.x = display.contentCenterX + 300
    imagecould.y = display.contentCenterY + 185
    sceneGroup:insert(imagecould)

    -- Posições iniciais de imagecan e imagecould
    local initialPositions = {
        imagecan = { x = imagecan.x, y = imagecan.y },
        imagecould = { x = imagecould.x, y = imagecould.y }
    }

    -- Função para redefinir a posição de imagecan e imagecould
    local function resetPositions()
        imagecan.x = initialPositions.imagecan.x
        imagecan.y = initialPositions.imagecan.y
        imagecould.x = initialPositions.imagecould.x
        imagecould.y = initialPositions.imagecould.y
    end

    -- Variável para rastrear se a transição ocorreu uma vez
    local transicaoOcorreu = false

    -- Função para arrastar e soltar
    local function arrastarESoltar(event)
        local phase = event.phase
        local target = event.target

        if "began" == phase then
            -- Definindo a fase de toque
            display.getCurrentStage():setFocus(target, event.id)
            target.isFocus = true

            -- Salva a posição inicial do toque
            target.touchOffsetX = event.x - target.x
            target.touchOffsetY = event.y - target.y

        elseif target.isFocus then
            if "moved" == phase then
                -- Move a imagem conforme o toque
                target.x = event.x - target.touchOffsetX
                target.y = event.y - target.touchOffsetY

            elseif "ended" == phase or "cancelled" == phase then
                local dropTarget = image1
                -- Verifica se a imagem foi arrastada para image1 ou não
                if event.x > image1.x - image1.width / 2 and
                    event.x < image1.x + image1.width / 2 and
                    event.y > image1.y - image1.height / 2 and
                    event.y < image1.y + image1.height / 2 then
                    -- Atualiza o alvo de queda
                    dropTarget = image1
                end
                -- Libera o foco
                display.getCurrentStage():setFocus(target, nil)
                target.isFocus = false

                -- Move a imagem para a posição correta
                transition.to(target, { time = 1600, x = dropTarget.x, y = dropTarget.y, onComplete = function()
                    -- Verifica se a imagem foi solta em image1 e altera a visibilidade das outras imagens
                    if dropTarget == image1 then
                        if target == imagecan then
                            image3.isVisible = true
                            image4.isVisible = false
                            image1.isVisible = false  -- torna image1 invisível quando image3 está visível
                            -- Reproduz a narração para image3
                            audio.play(narracaoCan)
                        elseif target == imagecould then
                            image3.isVisible = false
                            image4.isVisible = true
                            image1.isVisible = false  -- torna image1 invisível quando image4 está visível
                            -- Reproduz a narração para image4
                            audio.play(narracaoCould)
                        end
                        -- Marca que a transição ocorreu
                        transicaoOcorreu = true
                    end
                    -- Redefine as posições de imagecan e imagecould
                    resetPositions()
                end })

                -- Se a transição já ocorreu uma vez, ao clicar novamente em imagecan ou imagecould, voltar à imagem original
                if transicaoOcorreu then
                    if target == imagecan then
                        image3.isVisible = false
                        image4.isVisible = false
                        image1.isVisible = true  -- torna image1 visível novamente
                    elseif target == imagecould then
                        image3.isVisible = false
                        image4.isVisible = false
                        image1.isVisible = true  -- torna image1 visível novamente
                    end
                end
            end
        end

        return true
    end

    -- Adiciona o evento de arrastar e soltar para imagecan e imagecould
    imagecan:addEventListener("touch", arrastarESoltar)
    imagecould:addEventListener("touch", arrastarESoltar)

end

scene:addEventListener("create", scene)

return scene
