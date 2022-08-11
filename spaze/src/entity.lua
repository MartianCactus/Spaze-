Entity = Object:extend()

function Entity:new(x, y, image_path, r, sx, sy, ox, oy)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.angle = r
    self.scale = sx
    self.xoff = ox
    self.yoff = oy
    self.xSpeed = 0
    self.ySpeed = 0
end

function Entity:update(dt)
    self.x = self.x + self.xSpeed * dt
    self.y = self.y + self.ySpeed * dt
end

function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y, self.angle, self.scale, self.scale, self.xoff, self.yoff)
end
