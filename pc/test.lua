local version = 1
os.loadAPI('update')
update.checkForUpdate(version, 'pc/test.lua')

print("hello world " .. version)