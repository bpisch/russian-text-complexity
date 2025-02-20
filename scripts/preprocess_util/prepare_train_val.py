#note: has to be executed from scripts dir for relative paths to work
c = open("out_statistics.txt", "r", encoding="utf-8").read()
fd_train = open("../input_optimizer/training.txt", "w", encoding="utf-8")
fd_val = open("../input_optimizer/validation.txt", "w", encoding="utf-8")
lines = c.split("\n")
header = lines[0]
fd_train.write(header+"\n")
fd_val.write(header+"\n")

for l in lines[1:]:
	if "part11" in l:
		fd_val.write(l+"\n")
	else:
		fd_train.write(l+"\n")

fd_train.close()
fd_val.close()
