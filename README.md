# Summary
This project is a practical study module for Neural Networks developed with **TensorFlow.js** and **Node.js**. It implements a classification model designed to categorize individuals into three distinct levels—**Premium**, **Medium**, and **Basic**—based on input features such as age, preferred color, and location. The core objective is to demonstrate how a neural network can effectively learn complex patterns from small datasets using techniques like one-hot encoding and data normalization.

# Structure
- `.agent/`: Contains internal configuration, logic, and prompt templates used by the AI to maintain documentation consistency.
- `README.md`: The primary documentation file providing the project overview, architecture details, and setup instructions.
- `package.json`: Defines the project dependencies and the execution scripts for the Node.js environment.
- **Source Code**: Includes the implementation of the sequential model, data preprocessing logic, and the training loop.

# Technologies
- **TensorFlow.js**: Core library for building and training the machine learning model.
- **Node.js**: The runtime environment (utilizing ES modules).
- **Adam Optimizer**: Used for adaptive weight adjustment during the training process.
- **Activation Functions**: Employs **ReLU** for the hidden layer and **Softmax** for the output layer.
- **Categorical Crossentropy**: The loss function utilized for multi-class classification.
- **Gemini AI**: Integration used for the experimental automated documentation helper.

# Extra Details
### Recent Updates
The internal AI prompt logic has been updated to strictly maintain the project's purpose. This ensures that automated documentation updates remain consistent and do not alter the high-level project narrative, even when commit diffs suggest significant changes to underlying scripts.

### Network Architecture
- **Input Layer**: 7 dimensions (normalized age, one-hot encoded colors, and locations).
- **Hidden Layer**: 200 neurons with ReLU activation.
- **Output Layer**: 3 neurons with Softmax activation for probability distribution.
- **Training**: Configured for 1000 epochs to ensure convergence on the provided dataset.

### Execution
To run the study module:
1.  **Install dependencies**: `npm install`
2.  **Run the model**: `npm start`
*The system handles data in-memory and includes a Git hook mechanism that suggests README updates based on commit history.*
