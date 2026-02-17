Classy.Math = {
    e = function()
        return 2.71828182845904523536028747135266249775724709369995;
    end,
    -- ReLU activation function
    relu = function(number)
        return math.max(0, number)
    end,
    -- Sigmoid activation function
    sigmoid = function(number)        
        return 1.0 / (1.0 + Classy.Math.e() ^ (-number))
    end,
    round = function (num, n)
        local mult = 10^(n or 0)
        return math.floor(num * mult + 0.5) / mult
    end,
}

-- Gives math, the above functions
-- math = Classy.inheritFrom(Classy.Math, math);

-- Gives Class.Math, the functions from math
Classy.Math = Classy.inheritFrom(math, Classy.Math)
