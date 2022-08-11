Meteor = Entity:extend()

function Meteor:new(x, y)
    meteor_img = love.graphics.newImage("sprites/meteor.png")
    meteor_width = meteor_img:getWidth()
    meteor_height = meteor_img:getHeight()
    self.rotation = math.random(0, 100)
    Meteor.super.new(self, x, y, "/sprites/meteor.png", self.rotation/100, 1, 1, meteor_width/2, meteor_height/2)
    self.ySpeed = 150
    self.stronk = math.random(0, 4)
end
