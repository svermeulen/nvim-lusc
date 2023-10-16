
local uv <const> = require("luv")
local lusc <const> = require("lusc")

--- Here, we just adapt the luv api to use lusc
local record luv_async
   record Directory
      _impl:uv.Ldir
   end

   enum FileTypes
      "file"
      "directory"
      -- TODO - what other types are there?  These don't seem to be listed in luv docs
      -- probably sym links
   end

   record FileInfo
      name:string
      type:FileTypes
   end
end

function luv_async.await_close(fd:integer)
   local event = lusc.new_event()
   assert(uv.fs_close(fd, function() event:set() end))
   event:await()
end

function luv_async.await_open(path:string, flags:string|integer, mode:integer):integer
   local event = lusc.new_event()
   local fd:integer
   local err:string

   if mode == nil then
      -- Mode is necessary for some reason even when doing reads
      -- Default to 777
      mode = 438
   end

   assert(uv.fs_open(path, flags, mode, function(e:string, f:integer)
      fd = f
      err = e
      event:set() 
   end))
   event:await()

   assert(fd ~= nil, err)
   return fd
end


function luv_async.await_read(fd:integer, size:integer, offset:integer):string
   local event = lusc.new_event()
   local result:string
   local err:string

   assert(uv.fs_read(fd, size, offset, function(e:string, r:string)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_unlink(path:string):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_unlink(path, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_write(fd:integer, data:any, offset:integer):integer
   local event = lusc.new_event()
   local result:integer
   local err:string

   assert(uv.fs_write(fd, data, offset, function(e:string, r:integer)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_mkdir(path:string, mode:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_mkdir(path, mode, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_mkdtemp(template:string):string
   local event = lusc.new_event()
   local result:string
   local err:string

   assert(uv.fs_mkdtemp(template, function(e:string, r:string)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_mkstemp(template:string):integer | string
   local event = lusc.new_event()
   local result:integer | string
   local err:string

   assert(uv.fs_mkstemp(template, function(e:string, r:integer | string)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_rmdir(path:string):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_rmdir(path, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.try_await_stat(path:string):uv.FsStats
   local event = lusc.new_event()
   local result:uv.FsStats
   assert(uv.fs_stat(path, function(_:string, r:uv.FsStats)
      result = r
      event:set() 
   end))
   event:await()
   return result
end

function luv_async.await_stat(path:string):uv.FsStats
   local event = lusc.new_event()
   local result:uv.FsStats
   local err:string

   assert(uv.fs_stat(path, function(e:string, r:uv.FsStats)
      err = e
      result = r
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fstat(fd:integer):uv.FsStats
   local event = lusc.new_event()
   local result:uv.FsStats
   local err:string

   assert(uv.fs_fstat(fd, function(e:string, r:uv.FsStats)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_lstat(path:string):uv.FsStats
   local event = lusc.new_event()
   local result:uv.FsStats
   local err:string

   assert(uv.fs_lstat(path, function(e:string, r:uv.FsStats)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_rename(path:string, new_path:string):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_rename(path, new_path, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fsync(fd:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_fsync(fd, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fdatasync(fd:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_fdatasync(fd, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_ftruncate(fd:integer, offset:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_ftruncate(fd, offset, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_sendfile(out_fd:integer, in_fd:integer, in_offset:integer, size:integer):integer
   local event = lusc.new_event()
   local result:integer
   local err:string

   assert(uv.fs_sendfile(out_fd, in_fd, in_offset, size, function(e:string, r:integer)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_access(path:string, mode:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_access(path, mode, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_chmod(path:string, mode:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_chmod(path, mode, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fchmod(fd:integer, mode:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_fchmod(fd, mode, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_utime(path:string, atime:number, mtime:number):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_utime(path, atime, mtime, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_futime(fd:integer, atime:number, mtime:number):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_futime(fd, atime, mtime, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_lutime(path:string, atime:number, mtime:number):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_lutime(path, atime, mtime, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_link(path:string, new_path:string):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_link(path, new_path, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_symlink(path:string, new_path:string, flags:any):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_symlink(path, new_path, flags, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_readlink(path:string):string
   local event = lusc.new_event()
   local result:string
   local err:string

   assert(uv.fs_readlink(path, function(e:string, r:string)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_realpath(path:string):string
   local event = lusc.new_event()
   local result:string
   local err:string

   assert(uv.fs_realpath(path, function(e:string, r:string)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_chown(path:string, uid:integer, gid:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_chown(path, uid, gid, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fchown(fd:integer, uid:integer, gid:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_fchown(fd, uid, gid, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_lchown(fd:integer, uid:integer, gid:integer):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_lchown(fd, uid, gid, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_copyfile(path:string, new_path:string, flags:any):boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(uv.fs_copyfile(path, new_path, flags, function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.Directory.new(impl:uv.Ldir):luv_async.Directory
   return setmetatable(
      {
         _impl = impl,
      } as luv_async.Directory,
      { __index = luv_async.Directory } as metatable<luv_async.Directory>)
end

function luv_async.Directory:await_readdir():{luv_async.FileInfo}
   local event = lusc.new_event()
   local result:{luv_async.FileInfo}
   local err:string

   assert(self._impl:readdir(function(e:string, r:{luv_async.FileInfo})
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(err == nil, err)

   if result == nil then
      return {}
   end

   return result
end

function luv_async.Directory:await_closedir():boolean
   local event = lusc.new_event()
   local result:boolean
   local err:string

   assert(self._impl:closedir(function(e:string, r:boolean)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_opendir(path:string, entries:integer):luv_async.Directory
   assert(path ~= nil)
   assert(entries ~= nil, "Must provide a value for entries")

   local event = lusc.new_event()
   local result:uv.Ldir
   local err:string

   assert(uv.fs_opendir(path, function(e:string, r:uv.Ldir)
      result = r
      err = e
      event:set() 
   end, entries))
   event:await()

   assert(result ~= nil, err)
   return luv_async.Directory.new(result)
end

function luv_async.await_statfs(path:string):any
   local event = lusc.new_event()
   local result:any
   local err:string

   assert(uv.fs_statfs(path, function(e:string, r:any)
      result = r
      err = e
      event:set() 
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

return luv_async


