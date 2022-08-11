Ship = Entity:extend()

function Ship:new(x, y, xoff, yoff)
    Ship.super.new(self, x, y, "/sprites/ship.png", 0, 1, 1, xoff, yoff)
    self.xSpeed = 20
    time_between_bullets = 0
end

function Ship:update(dt)
    dist = self.x - 400
    if love.keyboard.isDown("right") then
        self.xSpeed = 200 - dist
    elseif love.keyboard.isDown("left") then
        self.xSpeed = -200 - dist
    else 
        if dist > 0 then
            self.xSpeed = -2.7 * dist
        elseif dist < 0 then
            self.xSpeed = -2.7 * dist
        else
            self.xSpeed = 0
        end
    end

    Ship.super.update(self, dt)
    time_between_bullets = time_between_bullets + dt
    
end

function Ship:keyPressed(key)
    --If the spacebar is pressed
    if key == "space" and time_between_bullets > 0.7 then
        --Put a new instance of Bullet inside listOfBullets.
        table.insert(listOfBullets, Bullet(self.x + self.width/2 - 14, self.y - self.height/2 + 10))
        table.insert(listOfBullets, Bullet(self.x - self.width/2 + 13, self.y - self.height/2 + 10))
        time_between_bullets = 0
    end
end