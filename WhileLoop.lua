local WhileLoop = {}
WhileLoop.__index = WhileLoop

function WhileLoop.new(condition, callback)
    local self = setmetatable({}, WhileLoop)
    self.condition = condition
    self.callback = callback
    self.running = false
    return self
end

function WhileLoop:Start()
    if self.running then
        return
    end
    self.running = true
    task.spawn(function()
        while self.running and self.condition() do
            self.callback()
            task.wait()
        end
        self.running = false
    end)
end

function WhileLoop:Stop()
    self.running = false
end
