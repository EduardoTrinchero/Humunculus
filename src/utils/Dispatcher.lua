
Dispatcher = {
    tasks = {}
}
Dispatcher.__index = Dispatcher

function Dispatcher:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.tasks = {}
    return obj
end

function Dispatcher:add(key, func)

    if self.tasks[key] == nil then
        self.tasks[key] = func
    end
end

function Dispatcher:dispatch(key)

    for i, task in ipairs(self.tasks) do
        if task[key] ~= nil then
            task[key]()
        end
    end

end

return Dispatcher