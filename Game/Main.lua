_G.love = require("love")

function love.load()
    background = love.graphics.newImage("Images/Background1.png")
    Sprite1 = love.graphics.newImage("Images/Sprite-0001.png")
    Sprite2 = love.graphics.newImage("Images/Sprite-0002.png")
    tree = love.graphics.newImage("Images/tree.png")
    House = love.graphics.newImage("Images/House.png")
    _G.var1 = true
    _G.var = true
    p1 = {
        PosX = 200,
        PosY = 200,
        Velocidade = 200,
        Direcao = "parado",
        largura = Sprite1:getWidth(),
        altura = Sprite1:getHeight(),
    }

    arvore = {
        PosX = 500,
        PosY = 500,
        altura = 110,
        largura = 80
    }
    casa = {
        PosX = 500,
        PosY = 100,
        altura = 200,
        largura = 500
    }
end

function love.update(dt)
    _G.DT = dt

    -- Movimentação
     novaX = p1.PosX
     novaY = p1.PosY
    if love.keyboard.isDown("a") then
        p1.PosX = novaX - p1.Velocidade * dt
        p1.Direcao = "esquerda"
    end
    if love.keyboard.isDown("d") then
        p1.PosX = novaX + p1.Velocidade * dt
        p1.Direcao = "direita"
    end
    if love.keyboard.isDown("s") then
        p1.PosY = novaY + p1.Velocidade * dt
        p1.Direcao = "baixo"
    end
    if love.keyboard.isDown("w") then
        p1.PosY = novaY - p1.Velocidade * dt
        p1.Direcao = "cima"
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
end

function love.draw()
    -- Background

    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), love.graphics.getHeight() / background:getHeight())

    -- Animação

    if p1.Direcao == "parado" or p1.Direcao == "cima" then
        love.graphics.draw(Sprite1, p1.PosX,p1.PosY)
    elseif p1.Direcao == "baixo" or p1.Direcao == "esquerda" or p1.Direcao == "direita" then
        love.graphics.draw(Sprite2, p1.PosX,p1.PosY)
        p1.Direcao = "parado"
    end

    -- Casa 

    love.graphics.draw(House, casa.PosX, casa.PosY)
    if VerColisao(p1.PosX,p1.PosY,p1.altura,p1.largura, casa.PosX, casa.PosY, casa.largura, casa.altura) then
        if love.keyboard.isDown("a") then
            p1.PosX = novaX + p1.Velocidade * DT
            p1.Direcao = "esquerda"
        end
        if love.keyboard.isDown("d") then
            p1.PosX = novaX - p1.Velocidade * DT
            p1.Direcao = "direita"
        end
    end
    if VerColisao(p1.PosX,p1.PosY,p1.altura,p1.largura, casa.PosX, casa.PosY, casa.largura, casa.altura) then
        if love.keyboard.isDown("s") then
            p1.PosY = novaY - p1.Velocidade * DT
            p1.Direcao = "baixo"
        end
        if love.keyboard.isDown("w") then
            p1.PosY = novaY + p1.Velocidade * DT
            p1.Direcao = "cima"
        end
    end

    -- Arvore
    if var == true then
        love.graphics.draw(tree, arvore.PosX, arvore.PosY)
        if VerColisao(p1.PosX,p1.PosY,p1.altura,p1.largura, arvore.PosX, arvore.PosY, arvore.largura, arvore.altura) then
            if love.keyboard.isDown("a") then
                p1.PosX = novaX + p1.Velocidade * DT
                p1.Direcao = "esquerda"
            end
            if love.keyboard.isDown("d") then
                p1.PosX = novaX - p1.Velocidade * DT
                p1.Direcao = "direita"
            end
        end
        if VerColisao(p1.PosX,p1.PosY,p1.altura,p1.largura, arvore.PosX, arvore.PosY, arvore.largura, arvore.altura) then
            if love.keyboard.isDown("s") then
                p1.PosY = novaY - p1.Velocidade * DT
                p1.Direcao = "baixo"
            end
            if love.keyboard.isDown("w") then
                p1.PosY = novaY + p1.Velocidade * DT
                p1.Direcao = "cima"
            end
        end
        if VerColisao(p1.PosX,p1.PosY,p1.altura + 50,p1.largura + 50, arvore.PosX, arvore.PosY, arvore.largura + 50,arvore.altura + 50) and love.keyboard.isDown("e") then
            var = false
            item = {
                madeira = true
           }
           table.insert(p1, item)
        end
    end

end