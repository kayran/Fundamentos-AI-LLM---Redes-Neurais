# Neural Network Study: Categorization with TensorFlow.js

This project is a practical study module for Neural Networks using **TensorFlow.js** and **Node.js**. It implements a classification model to categorize individuals into three levels: **Premium**, **Medium**, and **Basic**, based on their age, preferred color, and location.

## Core Purpose

The primary objective is to demonstrate how a simple neural network can learn complex patterns from a small dataset using one-hot encoding for categorical variables and normalization for numerical data.

## Network Architecture

The model is built using a sequential approach with the following structure:

- **Input Layer**: 7 dimensions (1 for normalized age + 3 for colors + 3 for locations).
- **Hidden Layer**: 200 neurons with **ReLU** activation. This layer acts as a filter, passing forward relevant features.
- **Output Layer**: 3 neurons with **Softmax** activation, providing a probability distribution across the three categories.

## Training Parameters

- **Optimizer**: `Adam` (Adaptive Moment Estimation) for efficient weight adjustment.
- **Loss Function**: `Categorical Crossentropy`, ideal for multi-class classification where only one category is correct.
- **Epochs**: 1000 iterations over the training set to ensure convergence.
- **Dataset**: A sample of labeled individuals with normalized age ranges (25-40).

## How to Run

1.  **Install dependencies**:
    ```bash
    npm install
    ```
2.  **Execute the script**:
    ```bash
    npm start
    ```
    *Note: The project uses ES modules (`"type": "module"`) and handles data exclusively in-memory for study purposes.*

## Automated Documentation Helper

This project includes an experimental Git hook that uses AI to help maintain documentation.
- **Mechanism**: A `post-commit` hook triggers a script that analyzes commit diffs via Gemini AI.
- **Purpose**: It suggests minor updates to the `README.md` to keep the high-level summary in sync with logic changes, although this main README content is manually curated for educational depth.
