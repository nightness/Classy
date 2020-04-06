Classy.Job = {
    new = function (job)
        return Classy.createInstance(Classy.Job.prototype, function (self)
            self.callback = job;
        end);
    end,
    prototype = {
        constructor = function (self)
            self._className = "Classy.Job"
        end,
        invoke = function (self)
            if (type(self.callback) == "function") then
                self.callback();
            end
        end,
    },
}