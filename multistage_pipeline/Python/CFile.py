import os
f = open("./commandfiles.txt", "w", encoding="utf-8")
for root, dirs, files in os.walk(".", topdown=False):
    for name in files:
        if len(name) >= 2 and name[-2:] == ".v":
            f.write(os.path.join(root, name) + "\n")
f.close()