# Modulo 2 - Redes Neurais

## Summary
This project is a practical exploration of Artificial Intelligence and Neural Networks using TensorFlow.js within a Node.js environment. Its primary purpose is to demonstrate the implementation of a classification model that categorizes users into specific service tiers (Premium, Medium, or Basic) based on input features such as age, color preferences, and geographic location.

## Structure
The project follows a minimalist structure focused on clarity and ease of execution:
- `index.js`: The core script of the application. It handles data preprocessing (normalization and one-hot encoding), neural network architecture definition, model training, and prediction logic.
- `package.json`: Contains project metadata, execution scripts, and identifies `@tensorflow/tfjs-node` as the primary dependency.
- `scripts/`: Directory for utility scripts, including `update_readme_ai.sh` which automates documentation updates.

## Technologies
- **Runtime**: Node.js (v18+)
- **Machine Learning Library**: TensorFlow.js for Node.js (`@tensorflow/tfjs-node`)
- **Neural Network Architecture**: Sequential Model
- **Optimizers**: Adam (Adaptive Moment Estimation)
- **Loss Functions**: Categorical Crossentropy (for multi-class classification)
- **Activation Functions**: ReLU (Hidden Layer) and Softmax (Output Layer)

## Extra Details
The latest update introduces a fully functional classification neural network. Key features of the implementation include:
- **Data Preprocessing**: Manual normalization of age values and one-hot encoding for categorical data (Colors and Locations) to ensure the neural network can process the information effectively.
- **Model Design**: A dense neural network with a hidden layer of 200 units to capture complex patterns within a small dataset.
- **Training Process**: Configured for 1000 epochs with data shuffling enabled to prevent bias, providing real-time accuracy and loss feedback during the process.
- **Automated Documentation**: Integration of a Shell/Python-based automation script that uses AI to maintain the project's documentation based on git history.
