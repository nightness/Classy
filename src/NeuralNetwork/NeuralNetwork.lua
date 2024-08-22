--[[

    NeuralNetwork.lua
    A simple neural network implementation in Lua

    The Classy.NeuralNetwork class is intended as a basic implementation of a feedforward neural network,
    with support for multiple layers and neurons. The network includes methods for forward propagation,
    backward propagation, and cost computation, which are key components of neural network training.

]]

-- The main class that holds the entire network, manages inputs, and orchestrates the forward and backward propagation.
Classy.NeuralNetwork = {
    -- Creates a new NeuralNetwork instance
    new = function(constructor, existingData)
        return Classy.createInstance(Classy.NeuralNetwork.prototype, constructor, existingData)
    end,

    -- Creates a neural network with specified inputs, outputs, and hidden layers
    create = function(numInputs, numOutputs, hiddenLayers)
        return Classy.NeuralNetwork.new(function(self)
            self._inputs = numInputs
            self._outputs = numOutputs
            self._layers = Classy.LinkedList.new()
            
            -- Create input layer
            local inputLayer = Classy.NeuralNetwork.Layer.new(numInputs)
            self._layers:add(inputLayer)

            -- Create hidden layers
            local previousLayer = inputLayer
            for _, numNeurons in ipairs(hiddenLayers) do
                local hiddenLayer = Classy.NeuralNetwork.Layer.new(numNeurons)
                self._layers:add(hiddenLayer)
                previousLayer:join(hiddenLayer)
                previousLayer = hiddenLayer
            end

            -- Create output layer
            local outputLayer = Classy.NeuralNetwork.Layer.new(numOutputs)
            self._layers:add(outputLayer)
            previousLayer:join(outputLayer)
        end)
    end,

    -- Test method
    test1 = function()
        -- Create a neural network with 200 inputs, 3 outputs, and two hidden layers.
        -- The first hidden layer has 50 neurons, the second hidden layer has 25 neurons.
        local network = Classy.NeuralNetwork.create(200, 3, {50, 25})

        -- Initialize the input data for the network.
        -- Here, we're simply filling the inputs array with sequential numbers from 1 to 200.
        -- In a real scenario, these inputs would likely be features from your dataset.
        local inputs = {}
        for i = 1, 200 do
            table.insert(inputs, i)
        end

        -- Perform forward propagation with the initialized inputs.
        -- This process involves passing the inputs through the network's layers
        -- and calculating the output values at each neuron in the network.
        network:forwardPropagate(inputs)

        -- Define the desired output (or target) values for the network.
        -- These would typically represent the correct labels or results that you want the network to learn.
        -- For this test, we're setting all desired outputs to 0.
        local desired = {0, 0, 0}

        -- Perform backward propagation using the desired outputs.
        -- This step adjusts the network's weights based on the difference between
        -- the actual outputs (from forward propagation) and the desired outputs.
        -- Backpropagation helps the network learn by minimizing the error (cost) over time.
        network:backwardPropagate(desired)
    end,
    
    prototype = {
        constructor = function(self)
            self._className = "Classy.NeuralNetwork"
            self._inputs = nil
            self._layers = nil
        end,

        -- Sets the input values for the network
        setInputs = function(self, ...)
            local arg1 = select(1, ...)
            if type(arg1) == "table" then
                self._inputs = arg1
            else
                self._inputs = {...}
            end
        end,

        -- Forward propagation through the network
        forwardPropagate = function(self, inputs)
            if inputs then
                self:setInputs(inputs)
            end
            local currentInputs = self._inputs
            for _, layer in ipairs(self._layers:get()) do
                currentInputs = layer:forwardPropagate(currentInputs)
            end
            self._outputs = currentInputs
        end,

        -- Retrieves the output values of the network
        getOutputs = function(self)
            return self._outputs
        end,

        -- Computes the cost difference between actual and desired outputs
        computeCostDifference = function(self, desiredOutputs)
            local actualOutputs = self:getOutputs()
            self._costDifference = Classy.DataSet.new()
            for i = 1, #actualOutputs do
                local diff = desiredOutputs[i] - actualOutputs[i]
                self._costDifference:add(diff)
            end
        end,

        -- Backward propagation through the network to adjust weights
        backwardPropagate = function(self, desiredOutputs)
            self:computeCostDifference(desiredOutputs)
            local errors = self._costDifference
            local layers = self._layers:get()

            -- Propagate errors backwards and adjust weights
            for i = #layers, 1, -1 do
                local layer = layers[i]
                errors = layer:backwardPropagate(errors)
            end
        end,
    },

    -- Represents a single layer in the network, containing multiple neurons.
    Layer = {
        new = function(neuronCount, existingData)
            return Classy.createInstance(Classy.NeuralNetwork.Layer.prototype, function(self)
                for n = 1, neuronCount do
                    self._neurons:add(Classy.NeuralNetwork.Neuron.new())
                end
            end, existingData)
        end,

        -- Joins two layers, creating synaptic connections between neurons
        join = function(inputLayer, outputLayer)
            for _, neuron in ipairs(inputLayer._neurons:get()) do
                for _, outputNeuron in ipairs(outputLayer._neurons:get()) do
                    neuron:addConnection(outputNeuron)
                end
            end
        end,

        prototype = {
            constructor = function(self)
                self._className = "Classy.NeuralNetwork.Layer"
                self._neurons = Classy.LinkedList.new()
            end,

            -- Joins the current layer to an output layer
            join = function(self, outputLayer)
                Classy.NeuralNetwork.Layer.join(self, outputLayer)
            end,

            -- Forward propagation through the layer
            forwardPropagate = function(self, inputs)
                local outputs = {}
                for _, neuron in ipairs(self._neurons:get()) do
                    table.insert(outputs, neuron:activate(inputs))
                end
                return outputs
            end,

            -- Backward propagation to adjust weights
            backwardPropagate = function(self, errors)
                local nextErrors = {}
                for i, neuron in ipairs(self._neurons:get()) do
                    local error = errors[i]
                    neuron:adjustWeights(error)
                    table.insert(nextErrors, neuron:computeDelta())
                end
                return nextErrors
            end,
        }
    },

    -- Represents a single neuron in the network, managing its inputs, weights, and output
    Neuron = {
        new = function(constructor, existingData)
            return Classy.createInstance(Classy.NeuralNetwork.Neuron.prototype, constructor, existingData)
        end,

        prototype = {
            constructor = function(self)
                self._className = "Classy.NeuralNetwork.Neuron"
                self._inputs = {}
                self._weights = {}
                self._bias = math.random()  -- Initialize with a random bias
                self._output = 0
            end,

            -- Adds a connection to another neuron
            addConnection = function(self, neuron)
                table.insert(self._inputs, neuron)
                table.insert(self._weights, math.random())  -- Random initial weight
            end,

            -- Activation function (e.g., sigmoid, ReLU)
            activate = function(self, inputs)
                local sum = self._bias
                for i, input in ipairs(inputs) do
                    sum = sum + input * self._weights[i]
                end
                self._output = 1 / (1 + math.exp(-sum))  -- Sigmoid activation
                return self._output
            end,

            -- Adjusts weights based on error gradient (backpropagation)
            adjustWeights = function(self, error)
                local learningRate = 0.01
                for i, input in ipairs(self._inputs) do
                    self._weights[i] = self._weights[i] + learningRate * error * input:getOutput()
                end
                self._bias = self._bias + learningRate * error
            end,

            -- Computes the delta for backpropagation
            computeDelta = function(self)
                return self._output * (1 - self._output)  -- Derivative of sigmoid
            end,

            -- Retrieves the neuron's output
            getOutput = function(self)
                return self._output
            end,
        }
    },
}
