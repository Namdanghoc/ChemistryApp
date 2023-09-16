from pathlib import Path

for i, file in enumerate(Path.iterdir(Path.cwd())):
    Path.rename(file, str(i) + '.jpg')
    print(file)