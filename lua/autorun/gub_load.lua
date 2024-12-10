gublib = gublib or {}
gublib.loader = {}

local gubpath = "gublib/"

if SERVER then
    print([[
         _____ _    _ ____  _      _____ ____  
        / ____| |  | |  _ \| |    |_   _|  _ \ 
       | |  __| |  | | |_) | |      | | | |_) |
       | | |_ | |  | |  _ <| |      | | |  _ < 
       | |__| | |__| | |_) | |____ _| |_| |_) |
        \_____|\____/|____/|______|_____|____/  ]])
    print("_____________________________________\n")
end

function gublib.loader:IncludeClient(path)
    if CLIENT then
        include(gubpath .. path)
    end

    if SERVER then
        AddCSLuaFile(gubpath .. path)
        print("[GUBLIB] • " .. gubpath .. path)
    end
end

function gublib.loader:IncludeServer(path)
    if SERVER then
        resource.AddFile(path)
        print("[GUBLIB] • " .. gubpath .. path)
    end
end

function gublib.loader:IncludeShared(path)
    self:IncludeServer(path)
    self:IncludeClient(path)
    if SERVER then
        print("[GUBLIB] • " .. gubpath .. path)
    end
end

function gublib.loader:ResourceAddFile(path)
    if SERVER then
        resource.AddFile(path)
        print("[GUBLIB] • Resource added: " .. path)
    end
end

function gublib.loader:ResourceAddFolder(name, recurse)
    local files, folders = file.Find(name .. "/*", "GAME")

    for _, fname in ipairs(files) do
        self:ResourceAddFile(name .. "/" .. fname)
    end

    if recurse then
        for _, fname in ipairs(folders) do
            gublib.loader:ResourceAddFolder(bane .."/" .. fname, recurse)
        end
    end
end

function gublib.loader:ClAddFolder(name,recurse)
	local files, folders = file.Find(gubpath .. name .. "/*", "LUA")
	for k, fname in ipairs(files) do
		local path = name.."/"..fname
		self:IncludeClient(path)
	end
	if recurse then
		for _, fname in ipairs(folders) do
            self:ClAddFolder(name .."/".. fname, recurse)
        end
    end
end

function gublib.loader:SvAddFolder(name,recurse)
	local files, folders = file.Find(gubpath .. name .. "/*", "LUA")
	for k, fname in ipairs(files) do
		local path = name.."/"..fname
		self:IncludeServer(path)
	end
	if recurse then
		for _, fname in ipairs(folders) do
            self:SvAddFolder(name .."/".. fname, recurse)
        end
    end
end

function gublib.loader:ShAddFolder(name,recurse)
	local files, folders = file.Find(gubpath .. name .. "/*", "LUA")
	for k, fname in ipairs(files) do
		local path = name.."/"..fname
		self:IncludeShared(path)
	end
	if recurse then
		for _, fname in ipairs(folders) do
            self:ShAddFolder(name .."/".. fname, recurse)
        end
    end
end

gublib.loader:ResourceAddFile("resource/fonts/BebasNeue-Regular.ttf")
gublib.loader:ResourceAddFile("resource/fonts/YsabeauSC-Regular.ttf")
gublib.loader:ResourceAddFile("resource/fonts/yuruka.ttf")



if CLIENT then
    if not file.Exists("gublib", "DATA") then
        file.CreateDir("gublib")
    end
end

function gublib.loader:Load()
    gublib.loader.finished = false 

    //self:IncludeClient("")
    self:IncludeClient("config/gub_config.lua")
    self:IncludeClient("core/gub_fonts.lua")


    self:ClAddFolder("vgui", true)

    //self:IncludeClient("vgui/gub_circleavatar.lua")


    self:ClAddFolder("core", true)

    if SERVER then
        print("\nLOADING FINISHED")
        print("_____________________________________")
    end

    gublib.loader.finished = true 
end

gublib.loader:Load()
