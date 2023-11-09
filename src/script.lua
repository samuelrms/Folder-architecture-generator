local function listItemsInPath(path, rootLength)
  local list = {}
  local pfile = io.popen('find "' .. path .. '" -type f')
  if not pfile then
    return list
  end
  for filename in pfile:lines() do
    local parts = {}
    for part in filename:sub(rootLength + 2):gmatch('[^/]+') do
      table.insert(parts, part)
    end
    table.insert(list, parts)
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

-- List items in path "src" and "public" and write to readme.md
local patterns = { "src", "public" }
if not file then
  print('Error: Could not open file readme.md')
  os.exit(1)
end
file:write('    .' .. '\n')
for _, pattern in ipairs(patterns) do
  local content = listItemsInPath(root .. '/' .. pattern .. '/', rootLength)
  if #content > 0 then
    local tree = generateTreeStructure(content)
    local function printTree(currentNode, indent)
      -- print(indent .. '*')
      for part, node in pairs(currentNode) do
        if node.isFile then
          file:write(indent .. '     ╚══ ' .. part .. '\n')
        else
          file:write(indent .. '    ╚══ ' .. part .. '\n')
          printTree(node, indent .. '    ║ ')
        end
      end
      -- print(indent .. '*')
    end
    printTree(tree, '')
  end
end
file:write('	╚══ [...config file]')


-- Close file
file:close()

-- Print success
print('File readme.md created with success!')
