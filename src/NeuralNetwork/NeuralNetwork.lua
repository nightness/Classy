Classy = Classy or {}
Classy.NeuralNetwork = Classy.NeuralNetwork or {}

-- Neuron class
Classy.NeuralNetwork.Neuron = {
    new = function(constructor, existingData)
        return Classy.createInstance(Classy.NeuralNetwork.Neuron.prototype, constructor, existingData)
    end,

    prototype = {
        constructor = function(self)
            self._className = "Classy.NeuralNetwork.Neuron"
            self._inputs = {}
            self._weights = {}
            self._bias = math.random() * 0.1 - 0.05 -- Initialize bias with small random value
            self._output = 0
        end,

        addConnection = function(self, neuron)
            table.insert(self._inputs, neuron)
            table.insert(self._weights, math.random() * 0.1 - 0.05) -- Initialize weight with small random value
        end,

        activate = function(self, inputs)
            local sum = self._bias
            for i, input in ipairs(inputs) do
                if not self._weights[i] then
                    self._weights[i] = math.random() * 0.1 - 0.05 -- Initialize weight if missing
                end
                sum = sum + input * self._weights[i]
            end
            self._output = 1 / (1 + math.exp(-sum)) -- Sigmoid activation function
            return self._output
        end,

        adjustWeights = function(self, error)
            if error == nil then
                error("adjustWeights: Error is nil!")
            end

            local learningRate = 0.1 -- Increased learning rate
            for i, input in ipairs(self._inputs) do
                if not self._weights[i] then
                    self._weights[i] = math.random() * 0.1 - 0.05
                end
                self._weights[i] = self._weights[i] + learningRate * error * input:getOutput()
            end
            self._bias = self._bias + learningRate * error
        end,

        computeDelta = function(self)
            return self._output * (1 - self._output)
        end,

        getOutput = function(self)
            return self._output
        end
    }
}

-- Layer class
Classy.NeuralNetwork.Layer = {
    new = function(neuronCount, existingData)
        return Classy.createInstance(Classy.NeuralNetwork.Layer.prototype, function(self)
            self._neurons = {}
            for n = 1, neuronCount do
                table.insert(self._neurons, Classy.NeuralNetwork.Neuron.new())
            end
        end, existingData)
    end,

    join = function(inputLayer, outputLayer)
        print("Joining layers...")
        for _, inputNeuron in ipairs(inputLayer._neurons) do
            for _, outputNeuron in ipairs(outputLayer._neurons) do
                inputNeuron:addConnection(outputNeuron)
            end
        end
    end,

    prototype = {
        constructor = function(self)
            self._className = "Classy.NeuralNetwork.Layer"
            self._neurons = {}
        end,

        join = function(self, outputLayer)
            Classy.NeuralNetwork.Layer.join(self, outputLayer)
        end,

        forwardPropagate = function(self, inputs)
            -- print("Forward propagating...")
            local outputs = {}
            for _, neuron in ipairs(self._neurons) do
                table.insert(outputs, neuron:activate(inputs))
            end
            return outputs
        end,

        backwardPropagate = function(self, errors)
            -- print("Backward propagating... Errors size:", #errors, "Neurons size:", #self._neurons)
            local nextErrors = {}

            for i, neuron in ipairs(self._neurons) do
                -- print("Processing neuron ", i)
                local err = errors[i] or 0 -- Default to 0 if no error provided for this neuron
                neuron:adjustWeights(err)
                table.insert(nextErrors, neuron:computeDelta())
            end

            return nextErrors
        end
    }
}

-- NeuralNetwork class
Classy.NeuralNetwork.new = function(constructor, existingData)
    return Classy.createInstance(Classy.NeuralNetwork.prototype, constructor, existingData)
end

Classy.NeuralNetwork.create = function(numInputs, numOutputs, hiddenLayers)
    return Classy.NeuralNetwork.new(function(self)
        self._inputs = numInputs
        self._outputs = numOutputs
        self._layers = {}

        print("Creating input layer with " .. numInputs .. " neurons...")
        local inputLayer = Classy.NeuralNetwork.Layer.new(numInputs)
        table.insert(self._layers, inputLayer)

        local previousLayer = inputLayer
        for _, numNeurons in ipairs(hiddenLayers) do
            print("Creating hidden layer with " .. numNeurons .. " neurons...")
            local hiddenLayer = Classy.NeuralNetwork.Layer.new(numNeurons)
            table.insert(self._layers, hiddenLayer)
            previousLayer:join(hiddenLayer)
            previousLayer = hiddenLayer
        end

        print("Creating output layer with " .. numOutputs .. " neurons...")
        local outputLayer = Classy.NeuralNetwork.Layer.new(numOutputs)
        table.insert(self._layers, outputLayer)
        previousLayer:join(outputLayer)
    end)
end

Classy.NeuralNetwork.prototype = {
    constructor = function(self)
        self._className = "Classy.NeuralNetwork"
        self._inputs = nil
        self._layers = nil
    end,

    setInputs = function(self, ...)
        local arg1 = select(1, ...)
        if type(arg1) == "table" then
            self._inputs = arg1
        else
            self._inputs = {...}
        end
    end,

    forwardPropagate = function(self, inputs)
        if inputs then
            self:setInputs(inputs)
        end
        local currentInputs = self._inputs
        for _, layer in ipairs(self._layers) do
            currentInputs = layer:forwardPropagate(currentInputs)
        end
        self._outputs = currentInputs
    end,

    getOutputs = function(self)
        return self._outputs
    end,

    computeCostDifference = function(self, desiredOutputs)
        local actualOutputs = self:getOutputs()
        self._costDifference = {}
        for i = 1, #actualOutputs do
            local diff = desiredOutputs[i] - actualOutputs[i]
            table.insert(self._costDifference, diff)
        end
    end,

    backwardPropagate = function(self, desiredOutputs)
        self:computeCostDifference(desiredOutputs)
        local errors = self._costDifference

        for i = #self._layers, 1, -1 do
            local layer = self._layers[i]
            errors = layer:backwardPropagate(errors)
        end
    end
}

-- XOR test function
function xorTest()
    local trainingData = {{{0, 0}, {0}}, {{0, 1}, {1}}, {{1, 0}, {1}}, {{1, 1}, {0}}}

    print("Creating neural network for XOR test...")
    local nn = Classy.NeuralNetwork.create(2, 1, {3, 3})
    print("Neural network created.")

    local epochs = 10000
    for epoch = 1, epochs do
        local totalError = 0
        for _, data in ipairs(trainingData) do
            local inputs, expectedOutput = data[1], data[2]
            -- print("Forward propagating with inputs:", table.concat(inputs, ", "))
            nn:forwardPropagate(inputs)
            local outputs = nn:getOutputs()
            -- print("Debug: Outputs = ", outputs[1], " Expected Output = ", expectedOutput[1])
            if outputs[1] == nil then
                error("outputs[1] is nil. Check forward propagation.")
            end
            local error = expectedOutput[1] - outputs[1]
            totalError = totalError + math.abs(error)
            nn:backwardPropagate(expectedOutput)
        end
        if epoch % 1000 == 0 then
            print("Epoch:", epoch, "Total Error:", totalError)
        end
    end

    local passedTests = true
    for _, data in ipairs(trainingData) do
        local inputs, expectedOutput = data[1], data[2]
        nn:forwardPropagate(inputs)
        local output = nn:getOutputs()[1]
        print("Test with inputs:", table.concat(inputs, ", "), " produced output:", output, "Expected:",
            expectedOutput[1])
        if math.abs(output - expectedOutput[1]) > 0.1 then
            passedTests = false
        end
    end

    if passedTests then
        print("All XOR tests passed!")
    else
        print("Some XOR tests failed.")
    end
end

xorTest()

function testNeuralNetwork()
    print("Creating neural network...")
    local nn = Classy.NeuralNetwork.create(2, 1, {2})    
    print("Neural network created.")
    nn:forwardPropagate({0.1, 0.2})
    print("Forward propagation complete.")
    nn:backwardPropagate({0.3})
    print("Output: " .. nn:getOutputs()[1])
end

-- testNeuralNetwork()

