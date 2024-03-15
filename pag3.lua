local utils = require("utils")
local composer = require("composer")
local scene = composer.newScene()

local narracaoPag3 = audio.loadStream("audios/audiopag3.mp3")
local soundTable = {
    narracaoPag3 = audio.loadSound("audios/audiopag3.mp3"),
}

local narracaoProfMay = audio.loadStream("interacoes/p03/musicProfMay.mp3")
local narracaoProfMight = audio.loadStream("interacoes/p03/musicProfMight.mp3")
local narracaoBoyYes = audio.loadStream("interacoes/p02/musicBoyYes.mp3")

local function onNarracaoProfMayComplete(event)
    if event.completed then
        audio.play(narracaoBoyYes)
    end
end

local function onNarracaoProfMightComplete(event)
    if event.completed then
        audio.play(narracaoBoyYes)
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bgpag3 = display.newImageRect(utils.bgpag3, 768, 1024)
    bgpag3.x = display.contentCenterX
    bgpag3.y = display.contentCenterY
    sceneGroup:insert(bgpag3)

    local prev = display.newText(utils.prev, 0, 0, utils.font, 50)
    prev.x = display.contentWidth * 0.15
    prev.y = display.contentHeight - 60
    prev:setFillColor(255, 255, 255)
    sceneGroup:insert(prev)

    prev:addEventListener("tap", function()
        composer.gotoScene("pag2", "fade")
    end)

    local next = display.newText(utils.next, 0, 0, utils.font, 50)
    next.x = display.contentWidth * 0.85
    next.y = display.contentHeight * 0.94
    next:setFillColor(255, 255, 255)
    sceneGroup:insert(next)

    next:addEventListener("tap", function()
        composer.gotoScene("pag4", "fade")
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
                audio.play(narracaoPag3)
            end
            flag = not flag
            print(flag)
        end
    )

    local image1 = display.newImage("interacoes/p03/startprof.png")
    image1.width = 400 -- largura desejada
    image1.height = 400 -- altura desejada
    image1.x = display.contentCenterX + 130
    image1.y = display.contentCenterY + 235
    sceneGroup:insert(image1)

    local image3 = display.newImage("interacoes/p03/may.png")
    image3.width = 400 -- largura desejada
    image3.height = 400 -- altura desejada
    image3.x = display.contentCenterX + 100
    image3.y = display.contentCenterY + 235
    sceneGroup:insert(image3)
    image3.isVisible = false

    local image4 = display.newImage("interacoes/p03/might.png")
    image4.width = 400 -- largura desejada
    image4.height = 400 -- altura desejada
    image4.x = display.contentCenterX + 100
    image4.y = display.contentCenterY + 235
    sceneGroup:insert(image4)
    image4.isVisible = false

    local image5 = display.newImage("interacoes/p02/start.png")
    image5.width = 300 -- largura desejada
    image5.height = 300 -- altura desejada
    image5.x = display.contentCenterX - 170
    image5.y = display.contentCenterY + 290
    sceneGroup:insert(image5)

    local image6 = display.newImage("interacoes/p02/end.png")
    image6.width = 300 -- largura desejada
    image6.height = 300 -- altura desejada
    image6.x = display.contentCenterX - 185
    image6.y = display.contentCenterY + 290
    sceneGroup:insert(image6)
    image6.isVisible = false

    local imagemay = display.newImage("interacoes/p03/btmay.png")
    imagemay.width = 100 -- largura desejada
    imagemay.height = 80 -- altura desejada
    imagemay.x = display.contentCenterX - 300
    imagemay.y = display.contentCenterY + 1
    sceneGroup:insert(imagemay)

    local imagemight = display.newImage("interacoes/p03/btmight.png")
    imagemight.width = 100 -- largura desejada
    imagemight.height = 80 -- altura desejada
    imagemight.x = display.contentCenterX - 180
    imagemight.y = display.contentCenterY + 1
    sceneGroup:insert(imagemight)

    -- Variáveis para rastrear se as imagens já foram exibidas
    local imagem3Exibida = false
    local imagem4Exibida = false
    local imagem6Exibida = false

    -- Função para verificar a visibilidade das imagens e reproduzir as narrações apropriadas
    local function verificarVisibilidade()
        if image3.isVisible and not imagem3Exibida then
            audio.play(narracaoProfMay, {onComplete=onNarracaoProfMayComplete})
            imagem3Exibida = true
        end
        if image4.isVisible and not imagem4Exibida then
            audio.play(narracaoProfMight, {onComplete=onNarracaoProfMightComplete})
            imagem4Exibida = true
        end
        if image6.isVisible and not imagem6Exibida then
            -- O áudio narracaoBoyYes será reproduzido dentro dos callbacks das narrações dos professores
            imagem6Exibida = true
        end
    end

    -- Adiciona um manipulador de evento de enterFrame para verificar a visibilidade das imagens continuamente
    Runtime:addEventListener("enterFrame", verificarVisibilidade)

    -- Posições iniciais de imagemay e imagemight
    local initialPositions = {
        imagemay = { x = imagemay.x, y = imagemay.y },
        imagemight = { x = imagemight.x, y = imagemight.y }
    }

    -- Função para redefinir a posição de imagemay e imagemight
    local function resetPositions()
        imagemay.x = initialPositions.imagemay.x
        imagemay.y = initialPositions.imagemay.y
        imagemight.x = initialPositions.imagemight.x
        imagemight.y = initialPositions.imagemight.y
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
                        if target == imagemay then
                            image3.isVisible = true
                            image6.isVisible = true
                            image1.isVisible = false
                            image5.isVisible = false
                        elseif target == imagemight then
                            image4.isVisible = true
                            image6.isVisible = true
                            image1.isVisible = false
                            image5.isVisible = false
                        end
                        -- Marca que a transição ocorreu
                        transicaoOcorreu = true
                    end
                    -- Redefine as posições de imagemay e imagemight
                    resetPositions()
                end })

                -- Se a transição já ocorreu uma vez, ao clicar novamente em imagemay ou imagemight, voltar à imagem original
                if transicaoOcorreu then
                    if target == imagemay then
                        image3.isVisible = false
                        image6.isVisible = false
                        image4.isVisible = false
                        image1.isVisible = true
                        image5.isVisible = true
                    elseif target == imagemight then
                        image4.isVisible = false
                        image6.isVisible = false
                        image3.isVisible = false
                        image1.isVisible = true
                        image5.isVisible = true
                    end
                    -- Redefine a variável de transição ocorreu para permitir outra transição
                    transicaoOcorreu = false
                end
            end
        end

        return true
    end

    -- Adiciona o evento de arrastar e soltar para imagemay e imagemight
    imagemay:addEventListener("touch", arrastarESoltar)
    imagemight:addEventListener("touch", arrastarESoltar)
end

scene:addEventListener("create", scene)

return scene
