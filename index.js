import tf from '@tensorflow/tfjs-node';


async function trainModel(inputXs, outputYs) {
    const model = tf.sequential()

    // First layer of the network:
    // 7-position input (normalized age + 3 colors + 3 locations)

    // 200 neurons = I used this many because there is a small training base
    // the more neurons, the more complexity the network can learn
    // and consequently, the more processing power it will use

    // ReLU acts as a filter:
    // It's as if it only lets interesting data continue through the network
    /// If the information reaching this neuron is positive, pass it forward!
    // if it's zero or negative, discard it, it won't be useful
    model.add(tf.layers.dense({ inputShape: [7], units: 200, activation: 'relu' }))

    // Output: 3 neurons
    // one for each category (premium, medium, basic)

    // activation: softmax normalizes the output into probabilities
    model.add(tf.layers.dense({ units: 3, activation: 'softmax' }))

    // Compiling the model
    // optimizer Adam (Adaptive Moment Estimation)
    // is a modern personal trainer for neural networks:
    // adjusts weights efficiently and intelligently
    // learns from the history of errors and successes

    // loss: categoricalCrossentropy
    // It compares what the model "thinks" (the scores for each category)
    // with the correct answer
    // the premium category will always be [1, 0, 0]

    // the further the model's prediction is from the correct answer
    // greater the error (loss)
    // Classic example: image classification, recommendation, user categorization
    // anything where the correct answer is "just one among several possibles"

    model.compile({
        optimizer: 'adam',
        loss: 'categoricalCrossentropy',
        metrics: ['accuracy']
    })

    // Model training
    // verbose: disables internal log (and uses callback instead)
    // epochs: number of times it will run through the dataset
    // shuffle: shuffles the data to avoid bias
    await model.fit(
        inputXs,
        outputYs,
        {
            verbose: 0,
            epochs: 1000,
            shuffle: true,
            callbacks: {
                onEpochEnd: (epoch, log) => console.log(
                    `Epoch: ${epoch}: loss = ${log.loss}, accuracy = ${log.acc}`
                )
            }
        }
    )

    return model
}

async function predict(model, pessoa) {
    // transform the JS array into a tensor (tfjs)
    const tfInput = tf.tensor2d(pessoa)

    // Performs the prediction (output will be a vector of 3 probabilities)
    const pred = model.predict(tfInput)
    const predArray = await pred.array()
    return predArray[0].map((prob, index) => ({ prob, index }))
}
// Training example people (each person with age, color, and location)
// const pessoas = [
//     { name: "Erick", age: 30, color: "azul", location: "São Paulo" },
//     { name: "Ana", age: 25, color: "vermelho", location: "Rio" },
//     { name: "Carlos", age: 40, color: "verde", location: "Curitiba" },
//     { name: "Olivia", age: 36, color: "verde", location: "Entre Rios" },
//     { name: "Maria", age: 26, color: "vermelho", location: "Ouro Preto" },
// ];

// Input vectors with values already normalized and one-hot encoded
// Order: [normalized_age, blue, red, green, São Paulo, Rio, Curitiba]
// const tensorPessoas = [
//     [0.33, 1, 0, 0, 1, 0, 0], // Erick
//     [0, 0, 1, 0, 0, 1, 0],    // Ana
//     [1, 0, 0, 1, 0, 0, 1]     // Carlos
// ]

// We only use numerical data, as the neural network only understands numbers.
// tensorPessoasNormalizado corresponds to the model's input dataset.
const tensorPessoasNormalizado = [
    [0.33, 1, 0, 0, 1, 0, 0], // Erick
    [0, 0, 1, 0, 0, 1, 0],    // Ana
    [1, 0, 0, 1, 0, 0, 1],     // Carlos
    [(36 - 25) / (40 - 25), 0, 0, 1, 0, 0, 1],     // Olivia
    [(26 - 25) / (40 - 25), 0, 1, 0, 0, 1, 0]     // Maria
];

// Labels of the categories to be predicted (one-hot encoded)
// [premium, medium, basic]
const labelsNomes = ["premium", "medium", "basic"]; // Order of labels
const tensorLabels = [
    [1, 0, 0], // premium - Erick
    [0, 1, 0], // medium - Ana
    [0, 0, 1], // basic - Carlos
    [1, 0, 0], // premium - Olivia
    [0, 0, 1]  // basic - Maria
];

// Create input (xs) and output (ys) tensors to train the model
const inputXs = tf.tensor2d(tensorPessoasNormalizado)
const outputYs = tf.tensor2d(tensorLabels)

// the more data, the better!
// this way the algorithm can better understand the complex patterns
// in the data
const model = await trainModel(inputXs, outputYs)

const pessoa = { nome: 'zé', idade: 28, cor: 'verde', localizacao: "Curitiba" }
const kayran = { nome: 'Kayran', idade: 36, cor: 'azul', localizacao: "Ouro Preto" }
// Normalizing the age of the new person using the same training pattern
// Example: min_age = 25, max_age = 40, so (28 - 25) / (40 - 25) = 0.2

const pessoaTensorNormalizado = [
    [
        0.2, // normalized age
        1,    // blue color
        0,    // red color
        0,    // green color
        0,    // São Paulo location
        1,    // Rio location
        0     // Curitiba location
    ]
]

const kayranTensorNormalizado = [
    [
        (36 - 25) / (40 - 25), // normalized age
        1,    // blue color
        0,    // red color
        0,    // green color
        0,    // São Paulo location
        0,    // Rio location
        0     // Curitiba location
    ]
]

const predictions = await predict(model, pessoaTensorNormalizado)
const kayranPredictions = await predict(model, kayranTensorNormalizado)
const results = predictions
    .sort((a, b) => b.prob - a.prob)
    .map(p => `${labelsNomes[p.index]} (${(p.prob * 100).toFixed(2)}%)`)
    .join('\n')
const kayranResults = kayranPredictions
    .sort((a, b) => b.prob - a.prob)
    .map(p => `${labelsNomes[p.index]} (${(p.prob * 100).toFixed(2)}%)`)
    .join('\n')
console.log(`Sample results: \n${results}\n`)
console.log(`Kayran results: \n${kayranResults}\n`)