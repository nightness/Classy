-- Dijkstra's Algorithm - Computerphile... "Maps to shortest path" https://www.youtube.com/watch?v=GazC3A4OQTE
-- ^^ Use in hidden layers ???
--  Along with this would it be better to start with a very small hidden layer and then add neurons with each back propagation
-- 

-- A basic neural network
Classy.NeuralNetwork = {
    new = function (constructor, existingData)
        return Classy.createInstance(Classy.NeuralNetwork.prototype, constructor, existingData);
    end,
    create = function (numInput, numOutputs, hiddenLayers)
        
    end,
    test1 = function()
        -- Create a neural network with 200 inputs, 3 outputs and has two hidden layers.
        -- The first hidden layer has 50 neurons the second hidden layer has 25 neurons
        local network = Classy.NeuralNetwork.create(200, 3, { 50, 25 })
        local inputs = { }
        for i = 1, 200 do
            table.insert(inputs, i);
        end
        network:forwardPropagate(inputs)
        local desired = { 0, 0, 0 }
        network:backwardPropagate(desired);
    end,
    prototype = {
        constructor = function (self)
            self._className = "Classy.NeuralNetwork";
            self._inputs = nil;
        end,
        setInputs = function (...)
            local inputs = nil;
            local arg1 = select(1, ...);
            if (type(arg1) == "table") then
                self._inputs = arg1;
            else
                self._inputs = { ... };
            end
        end,
        forwardPropagate = function (inputs)
            if (inputs) then
                network:setInputs(inputs)
            end
        end,
        getOutputs = function ()
        
        end,
        computeCostDifference = function (desiredOutputs)
            local outputs = self:getOutPuts();
            self._costDifference = Classy.DataSet.new();
            
        end,
        backwardPropagate = function (desiredOutputs)
            if (desiredOutputs) then
                network:computeCostDifference(desiredOutputs);
            end

        end,
    },
    -- A layer is a collection of neurons
    Layer = {
        new = function (neuronCount, existingData)
            return Classy.createInstance(Classy.NeuralNetwork.Layer.prototype, function (self)
                for n = 1, neuronCount do
                    self._neurons:add(Classy.NeuralNetwork.Neuron())
                end                    
            end, existingData);
        end,
        -- Joins two layers, creates the neural connects for forward and backwards propagation
        join = function (inputLayer, outputLayer)

        end,
        prototype = {
            constructor = function (self)
                self._className = "Classy.NeuralNetwork.Layer";
                self._neurons = Classy.DataSet.new();
            end,
            -- Joins the current layer to an output layer
            join = function (self, outputLayer)
                Classy.NeuralNetwork.Layer.join(self, outputLayer)
            end,
        }
    },
    -- A neuron consists for inputs and outputs
    -- Each input also has a corprsponding weight
    Neuron = {
        new = function (constructor, existingData)
            return Classy.createInstance(Classy.NeuralNetwork.Neuron.prototype, constructor, existingData);
        end,
        prototype = {
            constructor = function (self)
                self._className = "Classy.NeuralNetwork.Neuron";
                self._neurons = Classy.DataSet.new();
            end,
        }                
    },
}
