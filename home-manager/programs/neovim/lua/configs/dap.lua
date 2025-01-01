local dap = require("dap")

local config_loaded = false
local config_program_path = nil
local config_args = nil

-- Function to read and parse the configuration file
local function read_config_file()
    if config_loaded then
        config_loaded = false
        return config_program_path, config_args
    end

    local config_path = vim.fn.input("Path to configuration file: ", vim.fn.getcwd() .. "/", "file")

    -- Open the file and read its content
    local file = io.open(config_path, "r")
    if not file then
        print("Could not open file: " .. config_path)
        return nil, nil
    end

    local content = file:read("*a")
    file:close()

    -- Extract the program path and arguments using pattern matching
    config_program_path = content:match("file:%s*(.-)\n")
    local args_string = content:match("args:%s*(.-)\n")

    if not config_program_path then
        print("Could not find 'file:' in the configuration file.")
        config_args = {}
        config_loaded = true
        return nil, config_args
    end

    -- Split the arguments string into a table
    config_args = args_string and vim.fn.split(args_string, " ", true) or {}
    config_loaded = true

    return config_program_path, config_args
end
dap.configurations.cpp = {
    {
        name = "LLDB: Launch with args",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
            local argument_string = vim.fn.input("Program arguments: ", "", "file")
            return vim.fn.split(argument_string, " ", true)
        end,
    },
    {
        name = "LLDB: Launch with args from file",
        type = "codelldb",
        request = "launch",
        program = function()
            local program_path, _ = read_config_file()
            return program_path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
            local _, args = read_config_file()
            return args
        end,
    },
}

dap.configurations.c = vim.deepcopy(dap.configurations.cpp)
