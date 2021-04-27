local version = 2
os.loadAPI('api/update.lua')
update.checkForUpdate(version, 'pc/test.lua')

print("hello world " .. version)