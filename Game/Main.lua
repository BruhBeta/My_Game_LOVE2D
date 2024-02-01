_G.love = require("love")

function love.load()
    Sprite1 = love.graphics.newImage("Images/Sprite-0001.png")
    Sprite2 = love.graphics.newImage("Images/Sprite-0002.png")
    background = love.graphics.newImage("Images/Background1.png")
    tree = love.graphics.newImage("Images/tree.png")
    p1 = {
        PosX = 20,
        PosY = 350,
        Velocidade = 200,
        Direcao = "parado",
        largura = Sprite1:getWidth(),
        altura = Sprite1:getHeight(),
    }
    arvores = {}  -- Tabela para armazenar informações sobre as árvores

    for i = 1, 10 do
        local novaArvore = {
            _i = true,
            largura = 80,
            altura = 120,
            PosX = math.random(0, love.graphics.getWidth() - 80),
            PosY = math.random(0, love.graphics.getHeight() - 120)
        }
        table.insert(arvores, novaArvore)
    end
end

function love.update(dt)
    DT = dt

    local novoPosX = p1.PosX
    local novoPosY = p1.PosY

    if love.keyboard.isDown("a") then
        novoPosX = p1.PosX - p1.Velocidade * dt
        p1.Direcao = "esquerda"
    end
    if love.keyboard.isDown("d") then
        novoPosX = p1.PosX + p1.Velocidade * dt
        p1.Direcao = "direita"
    end
    if love.keyboard.isDown("s") then
        novoPosY = p1.PosY + p1.Velocidade * dt
        p1.Direcao = "baixo"
    end
    if love.keyboard.isDown("w") then
        novoPosY = p1.PosY - p1.Velocidade * dt
        p1.Direcao = "cima"
    end

    -- Impedir a passagem do background

    if p1.PosX < 0 then
        p1.PosX = 0
    elseif p1.PosX > love.graphics.getWidth() - p1.largura then
        p1.PosX = love.graphics.getWidth() - p1.largura
    end

    if p1.PosY < 0 then
        p1.PosY = 0
    elseif p1.PosY > love.graphics.getHeight() - p1.altura then
        p1.PosY = love.graphics.getHeight() - p1.altura
    end

    -- Colisoes

        -- Verificar colisão com as árvores
        local colisao = false
        for _, arvore in ipairs(arvores) do
            if VerColisao(novoPosX, novoPosY, p1.largura, p1.altura, arvore.PosX, arvore.PosY, arvore.largura - 30, arvore.altura - 35) then
                colisao = true
                break  -- Não é necessário verificar mais colisões
            end
        end
    
        -- Se não houver colisão, atualiza as posições
        if not colisao then
            p1.PosX = novoPosX
            p1.PosY = novoPosY
            arvores.var = false
        end

end

function love.draw()
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), love.graphics.getHeight() / background:getHeight())

-- Arvores

    for i, arvore in ipairs(arvores) do
        love.graphics.draw(tree, arvore.PosX, arvore.PosY)
    end

-- Movimentacao

    if p1.Direcao == "parado" or p1.Direcao == "cima" then
        love.graphics.draw(Sprite1, p1.PosX, p1.PosY)
    elseif p1.Direcao == "esquerda" or p1.Direcao == "direita" or p1.Direcao == "baixo" then
        love.graphics.draw(Sprite2, p1.PosX, p1.PosY)
    end
    p1.Direcao = "parado"
end

function VerColisao(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2
end