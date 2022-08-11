function love.load()
    
    Object = require "classic"
    require "entity"
    require "ship"
    require "conf"
    require "bullet"
    require "meteor"
    require "collision"
    
    background = love.graphics.newImage("sprites/background.png")
    ship_img = love.graphics.newImage("sprites/ship.png")
    explosion = love.audio.newSource("/sprites/explosion.ogg", "static")
    space = love.audio.newSource("/sprites/space.mp3", "stream")
    ui = love.audio.newSource("/sprites/ui.ogg", "static")

    ship_width = ship_img:getWidth()
    ship_height = ship_img:getHeight()
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    ship = Ship((screen_width)/2, (3*screen_height)/4, ship_width/2, ship_height/2)
    listOfBullets = {}
    listofMeteors = {}
    listOfSmol = {}

    game_time = 0
    points = 0
    gamestate = 0

    --setting ui colors
    restart_red = 255
    restart_green = 255
    restart_blue = 255

    space_red = 255
    space_green = 255
    space_blue = 255

    menu_red = 255
    menu_green = 255
    menu_blue = 266
end

function love.update(dt)
    
    space:setLooping(true)
    space:play()
    
    --Play state
    if gamestate == 1 then
        game_time = game_time + dt

    --checking for collision between ship and meteor
    for i,v in ipairs(listofMeteors) do
        if checkCollision(ship, v) then
            explosion:play()
            love.load()
        end
    end
  
    --Checking collision bwteeen bullets and meteor
    for i,v in ipairs(listOfBullets) do
        for j,w in ipairs(listofMeteors) do
            if checkCollision(v, w) then 
                v.dead = true
                if w.stronk ~= 1 then
                    w.dead = true
                    points = points + 1
                end
            end
        end
    end

   

    --Randomly generate new meteors
    math.randomseed(os.clock()*100000000000)
    if game_time < 60 then
        if math.random(math.floor(game_time), 100) == 99 then
            table.insert(listofMeteors, Meteor(math.random(200, 600), -100))
        end
    else
        if math.random(0, 40) == 39 then
            table.insert(listofMeteors, Meteor(math.random(200, 600), -100))
        end
    end

     --Checking collision bwteeen meteors so they dont spawn at same place
     for i,v in ipairs(listofMeteors) do
        for j,w in ipairs(listofMeteors) do
            if checkCollision(v, w) and j ~= i then
                v.dead = true
            end
        end
    end

    --Update ship
    ship:update(dt)

    --Update bullets
    for i,v in ipairs(listOfBullets) do
        v:update(dt) 
        
        if v.dead then
            --Remove it from the list
            table.remove(listOfBullets, i)
        end   
    end

    --Update meteors
    for i,v in ipairs(listofMeteors) do
        v:update(dt)
        if v.dead then
            --Remove it from the list
            table.remove(listofMeteors, i)
        end
    end

    --Removing offscreen bullets and meteors
    for i,v in ipairs(listOfBullets) do
        if v.y < 0 then
            v.dead = true
        end   
    end
    for i,v in ipairs(listofMeteors) do
        if v.y > 800 then
            v.dead = true
        end   
    end
    
    
end 
    end
    

function love.draw()
    
    --Draws background
    love.graphics.setColor(1, 1, 1, 0.4)
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end

    --Menu state
    if gamestate == 0 then
        love.graphics.setColor(menu_red/255, menu_green/255, menu_blue/255)
        love.graphics.print("Spaze!", 100, screen_height/2 - 100, 0, 5, 5)
        love.graphics.print("PRESS T TO PLAY.", 100, screen_height/2, 0, 5, 5)
    end

    --Play state
    if gamestate == 1 then
        --Draw Points 
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(points, 10, 10, 0, 2, 2)
        love.graphics.setColor(restart_red/255, restart_green/255, restart_blue/255)
        love.graphics.print("R to restart.", 5, 570, 0, 2, 2)
        love.graphics.setColor(space_red/255, space_green/255, space_blue/255)
        love.graphics.print("SPACE to fire.", 640, 570, 0, 2, 2)
        love.graphics.setColor(1, 1, 1)
        
        --Draws ship
        love.graphics.setColor(204/255, 154/255, 126/255)
        ship:draw()
        love.graphics.setColor(1, 1, 1)

        --Draws bullets
        love.graphics.setColor(186/255, 150/255, 41/255)
        for i,v in ipairs(listOfBullets) do
            v:draw()
        end
        love.graphics.setColor(1, 1, 1)

        --Draws meteors
        for i,v in ipairs(listofMeteors) do
            love.graphics.setColor(112/255, 110/255, 104/255)
            if v.stronk == 1 then
                love.graphics.setColor(245/255, 102/255, 0/255)
            end
            v:draw()
        end
        love.graphics.setColor(1, 1, 1)
    end
end

function love.keypressed(key)
    ship:keyPressed(key)

    if key == "r" then
        restart_red = 224
        restart_green = 121
        restart_blue = 47
    end

    if key == "space" then
        space_red = 224
        space_green = 121
        space_blue = 47
    end

    if key == "t" then
        menu_red = 224
        menu_green = 121
        menu_blue = 47
    end
end

function love.keyreleased(key)

    if key == "r" then
        love.load()
        ui:play()
    end

    if key == "space" then
        space_red = 255
        space_green = 255
        space_blue = 255
    end

    if key == "t" then
        gamestate = 1
        ui:play()
    end
end
