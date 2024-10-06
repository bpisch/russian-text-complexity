import argparse
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error

from utils import write_to_file_and_stdout

def parse_arguments():
    parser = argparse.ArgumentParser(description='Process feature names and other path arguments.')

    # Collect path arguments
    parser.add_argument('training_path', type=str, help='Path to training values')
    parser.add_argument('validation_path', type=str, help='Path to validation values')

    # Collect feature arguments
    parser.add_argument('features', nargs='*', help='List of feature names')

    return parser.parse_args()


def main():
    args = parse_arguments()
    features = args.features
    output_filename = f"out_optimizer_{'_'.join(features)}.txt"
    df = pd.read_csv(args.training_path, sep='\t')  # Use read_csv to read a tab-separated file
    df_val = pd.read_csv(args.validation_path, sep='\t')

    if features:
        train = np.column_stack([df[feature].to_numpy() for feature in features])
        val = np.column_stack([df_val[feature].to_numpy() for feature in features])
    else:
        train = np.ones((df.shape[0], 1))
        val = np.ones((df_val.shape[0], 1))    
    goal = df['grade'].to_numpy()
    goal_val = df_val['grade'].to_numpy()

    # Initialize and fit the linear regression model on the training set
    model = LinearRegression()
    model.fit(train, goal)

    # Predict on training set
    g_pred_train = model.predict(train)

    # Predict on validation set
    g_pred_val = model.predict(val)

    # Calculate MSE for both training and validation sets
    mse_train = mean_squared_error(goal, g_pred_train)
    mse_val = mean_squared_error(goal_val, g_pred_val)

    # Output the results
    intercept = model.intercept_
    result = np.concatenate(([intercept], model.coef_), axis=None)
    if not features :
        result = result[:-1]
    idx = 0
    with open(output_filename, 'w') as file:
        for coeff in result:
            if idx == 0:
                write_to_file_and_stdout(file, f"{coeff:.4f}")
            else:
                write_to_file_and_stdout(file, f"{coeff:.4f} * {features[idx - 1]}")
            if idx + 1 != len(result):
                write_to_file_and_stdout(file, " + ")
            idx += 1
        write_to_file_and_stdout(file, "\n")
        # write_to_file_and_stdout(file, f"Training set - Predicted:\n{g_pred_train}\n")
        write_to_file_and_stdout(file, f"Training set - MSE: {mse_train:.4f}\n")
        # write_to_file_and_stdout(file, f"Validation set - Predicted:\n{g_pred_val}\n")
        write_to_file_and_stdout(file, f"Validation set - MSE: {mse_val:.4f}\n")


if __name__ == "__main__":
    main()
