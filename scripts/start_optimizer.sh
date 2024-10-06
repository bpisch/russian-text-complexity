#! /bin/bash
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt" "dwp_5000" "asl"
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt" "dwp_5000" "asl" "dwp_1000"
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt" "asw" "asl"
python3 optimizer.py "../input_optimizer/training.txt" "../input_optimizer/validation.txt"

