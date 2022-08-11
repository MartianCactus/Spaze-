Bullet = Entity:extend()

function Bullet:new(x, y)
    bullet_sound = love.audio.newSource("/sprites/bullet_sound.ogg", "static")
    bullet_img = love.graphics.newImage("sprites/bullet.png")
    bullet_width = bullet_img:getWidth()
    bullet_height = bullet_img:getHeight()
    Bullet.super.new(self, x, y, "/sprites/bullet.png", 0, 0.5, 0.5, bullet_width/2, bullet_height/2)
    bullet_sound:play()
    self.ySpeed = -150
end

