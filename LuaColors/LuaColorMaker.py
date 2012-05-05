def fix_color_names(name):
	for idx in range(len(name)-1):
		name[idx]+="_"
	for idx in range(len(name)):
		name[idx]=name[idx][0].capitalize()+name[idx][1:]
	name = ''.join(name)
	#name = name.replace(" ","_")
	name = name.replace(",","")
	return name

def readInFile(fn):
	color_names = []
	rgb_values = []
	index = []
	infile = open(fn,'r')
	for line in infile:
		linesplit = line.split()
		color_names.append(fix_color_names(linesplit[4:]))
		rgb_values.append([linesplit[0],linesplit[1],linesplit[2]])
		index.append(linesplit[3])
	infile.close()
	return color_names, rgb_values, index
	
def printOutToLuaFile(outfile,fn):
	color_names, rgb_values, index = readInFile(fn)
	out_file = open(outfile,'w')
	out_file.write("MyColors = {\n")
	out_file.write("\tasVec4 = function(color)\n")
	out_file.write("\t\treturn osg.Vec4(color[1],color[2],color[3],1.0)\n")
	out_file.write("\tend,\n")
	
	for color_idx in range(len(color_names)):
		out_file.write("\t"+color_names[color_idx]+" = {\n")
		out_file.write("\t\trgb = {"+str(rgb_values[color_idx][0])+","+str(rgb_values[color_idx][1])+","+str(rgb_values[color_idx][2])+"},\n")
		out_file.write("\t\tasVec4 = osg.Vec4("+str(rgb_values[color_idx][0])+","+str(rgb_values[color_idx][1])+","+str(rgb_values[color_idx][2])+"),\n")
		out_file.write("\t\tindex = "+str(index[color_idx])+"\n")
		out_file.write("\t},\n")
	out_file.write("}\n")
	
	print("Lua file "+str(outfile)+" created.\n")


printOutToLuaFile("MyColors.lua","colors_list.txt")