#! /bin/bash
mkdir -p "../input_optimizer"
python3 ./preprocess_util/prepare_train_val.py
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt" "dwp_5000" "asl"
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt" "dwp_5000" "asl" "dwp_1000"
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt" "asw" "asl"
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt"

