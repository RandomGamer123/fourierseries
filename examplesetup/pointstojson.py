import json
output = []
with open("svgpoints2.txt","r") as pointsfile:
    line = pointsfile.readline()
    while line:
        line = line[:-1]
        output.append(line.split(","))
        line = pointsfile.readline()
with open("svgpoints2.json","w") as pointsjson:
    json.dump(output,pointsjson)