csvwriter = {}

local csv = {}


function csv:writeHeaders()
	assert(io.type(self.outfile) == "file", "Can't write if the file isn't open!")
	if not self.headersWritten then
		local row = {}
		for _, v in ipairs(self.cols) do
			table.insert(row, v)
		end
		table.insert(row, "\n")
		self.outfile:write(table.concat(row, ","))

		self.headersWritten = true
	end
end

function csv:writeRow(arg)
	assert(io.type(self.outfile) == "file", "Can't write if the file isn't open!")
	self:writeHeaders()

	local row = {}
	for _, col in ipairs(self.cols) do
		if arg[col] == nil then
			table.insert(row, "")
		else
			table.insert(row, tostring(arg[col]))
		end
	end
	table.insert(row, "\n")
	self.outfile:write(table.concat(row, ","))
end

function csv:flush()
	assert(io.type(self.outfile) == "file", "Can't flush if the file isn't open!")
	self.outfile:flush()
end

function csv:close()
	if self.needsClose then
		self.outfile:close()
		self.needsClose = false
	end
end

local _mt = {
	__index = csv
}

function csvwriter.new(filename)
	local ret = setmetatable({}, _mt)
	if filename ~= nil then
		ret.outfile = io.open(filename, "a")
		ret.needsClose = true
	else
		ret.outfile = io.output()
	end
	return ret
end

