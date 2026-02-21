# Summary
This project is a machine learning implementation using TensorFlow.js designed to classify users into specific categories (Premium, Medium, or Basic). By processing demographic and preference data—such as normalized age, color choices, and geographic locations—the application trains a neural network to identify patterns and provide probabilistic predictions for user tiering.

# Structure
- `index.js`: The core script of the application. it contains the data preprocessing logic (normalization and one-hot encoding), the neural network architecture definition, the training loop, and the prediction functions.

# Technologies
- **Node.js**: The runtime environment for the application.
- **TensorFlow.js (@tensorflow/tfjs-node)**: The primary library used for building, compiling, and training the neural network.
- **JavaScript (ES Modules)**: The programming language used for the project logic.

# Extra Details
- **Language Standardization**: The codebase, including comments and documentation within the logic, has been fully standardized to English to ensure better maintainability and global accessibility.
- **Model Complexity**: The hidden layer of the neural network was recently increased to 200 neurons. This adjustment was made to allow the model to learn more complex patterns, which is particularly useful when working with smaller training datasets.
- **Architecture**: The model uses a `dense` layer with `ReLU` activation for feature filtering and a final `dense` layer with `softmax` activation to output probabilities across the three target categories.
- **Optimization**: The training process utilizes the `Adam` optimizer and `categoricalCrossentropy` loss function, which is ideal for multi-class classification tasks.
