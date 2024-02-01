_G.love = require("love")

function love.load()
    background = love.graphics.newImage("Images/Background1.png")
    Sprite1 = love.graphics.newImage("Images/Sprite-0001.png")
    Sprite2 = love.graphics.newImage("Images/Sprite-0002.png")
    tree = love.graphics.newImage("Images/tree.png")
    _G.var1 = true
    p1 = {
        PosX = 200,
        PosY = 200,
        Velocidade = 200,
        Direcao = "parado",
        largura = Sprite1:getWidth(),
        altura = Sprite1:getHeight()
    }

    arvores = {}
end

function love.update(dt)

    -- Movimentação

    if love.keyboard.isDown("a") then
        p1.PosX = p1.PosX - p1.Velocidade * dt
    end
    if love.keyboard.isDown("d") then
        p1.PosX = p1.PosX + p1.Velocidade * dt
    end
    if love.keyboard.isDown("s") then
        p1.PosY = p1.PosY + p1.Velocidade * dt
    end
    if love.keyboard.isDown("w") then
        p1.PosY = p1.PosY - p1.Velocidade * dt
    end

    -- Limitação de mapa

    if p1.PosX < 0 then
        p1.PosX = 0
    elseif p1.PosX > love.graphics.getWidth() - p1.largura then
        p1.PosX = love.graphics.getWidth() - p1.largura
    end
    if p1.PosY < 0 then
        p1.PosY = 0
    elseif p1.PosY > love.graphics.getWidth() - p1.altura then
        p1.PosY = love.graphics.getWidth() - p1.altura
    end

    -- Arvores

    if var1 then
        for i = 1, 10 do
            local novaArvore = {
                largura = 80,
                altura = 120,
                PosX = math.random(0, love.graphics.getWidth() - 80),
                PosY = math.random(0, love.graphics.getHeight() - 120)
            }
            table.insert(arvores, novaArvore)
        end
        var1 = false
    end

    -- Hitbox
--...
end

function love.draw()
    -- Background
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), love.graphics.getHeight() / background:getHeight())
    love.graphics.draw(Sprite1, p1.PosX,p1.PosY)
    
    -- Arvores II

    for _, arvores in ipairs(arvores) do
        love.graphics.draw(tree, arvores.PosX, arvores.PosY)
    end
end

