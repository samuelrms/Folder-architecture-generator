local excludedPatterns = require('excludePaths')

local function isExcluded(filename)
  for _, pattern in ipairs(excludedPatterns) do
    if filename:match(pattern) then
      return true
    end
  end
  return false
end

local function listItemsInPath(path, rootLength)
  local list = {}
  local excludedPatternsString = table.concat(excludedPatterns, '|')
  local pfile = io.popen(string.format(
    'find "%s" -type f -not -path "*/.git/*" -not -path "*/node_modules/*" -not -path "*/.next/*" | grep -E -v "%s"',
    path, excludedPatternsString))

  if not pfile then
    return list
  end
  for filename in pfile:lines() do
    local parts = {}
    for part in filename:sub(rootLength + 2):gmatch('[^/]+') do
      table.insert(parts, part)
    end
    if not isExcluded(parts[#parts]) then
      table.insert(list, parts)
    end
  end
  pfile:close()
  return list
end


local function generateTreeStructure(items)
  local tree = {}
  for _, parts in ipairs(items) do
    local currentNode = tree
    for i, part in ipairs(parts) do
      currentNode[part] = currentNode[part] or {}
      currentNode = currentNode[part]
      if i == #parts then
        currentNode.isFile = true
      end
    end
  end
  return tree
end

-- Root directory
local root = arg[1] or '.'

local fileName = arg[2] or 'README.md'

-- Not root directory
if not root then
  print('Usage: lua tree.lua <path>')
  os.exit(1)
end

if not fileName then
  print('Usage: lua tree.lua <path> <fileName or default readme.md>')
end

-- Get the length of the root path
local rootLength = #root

-- Create tree .md
local file = io.open(root .. '/' .. (fileName or 'readme.md'), 'a+') -- Open file in write mode (create if not exists)

if not file then
  print('Error: Could not open file readme.md')
  os.exit(1)
end

file:write('    .' .. '\n')
local content = listItemsInPath(root, rootLength)
if #content > 0 then
  local tree = generateTreeStructure(content)
  local function printTree(currentNode, indent)
    if type(currentNode) == "table" then
      local count = 0
      local total = 0
      for _, _ in pairs(currentNode) do
        total = total + 1
      end
      for part, node in pairs(currentNode) do
        count = count + 1
        local newIndent = indent .. '    ║'
        local linePrefix = count == total and '    ╚══ ' or '    ╠══ '
        local lineSuffix = count == total and '' or (node.isFile and '' or '/')
        local connector = count == total and '' or (linePrefix == '    ╠══ ' and '  ' or '║')
        if part ~= 'isFile' then
          file:write(indent .. linePrefix .. part .. lineSuffix .. (lineSuffix == '/' and '' or connector) .. '\n')
          printTree(node, newIndent)
        end
      end
      -- Handling case where a file is marked as the last one
    end
  end
  printTree(tree, '')
end


-- Close file
file:close()

-- Print success
print('File readme.md created with success!')
