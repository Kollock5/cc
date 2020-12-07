local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'pocket/zollstock.lua')
end

