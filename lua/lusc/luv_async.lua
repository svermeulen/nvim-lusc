local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert
local uv = require("luv")
local lusc = require("lusc")


local luv_async = {Directory = {}, FileInfo = {}, }

















function luv_async.await_close(fd)
   local event = lusc.new_event()
   assert(uv.fs_close(fd, function() event:set() end))
   event:await()
end

function luv_async.await_open(path, flags, mode)
   local event = lusc.new_event()
   local fd
   local err

   if mode == nil then


      mode = 438
   end

   assert(uv.fs_open(path, flags, mode, function(e, f)
      fd = f
      err = e
      event:set()
   end))
   event:await()

   assert(fd ~= nil, err)
   return fd
end


function luv_async.await_read(fd, size, offset)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_read(fd, size, offset, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_unlink(path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_unlink(path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_write(fd, data, offset)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_write(fd, data, offset, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_mkdir(path, mode)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_mkdir(path, mode, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_mkdtemp(template)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_mkdtemp(template, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_mkstemp(template)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_mkstemp(template, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_rmdir(path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_rmdir(path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.try_await_stat(path)
   local event = lusc.new_event()
   local result
   assert(uv.fs_stat(path, function(_, r)
      result = r
      event:set()
   end))
   event:await()
   return result
end

function luv_async.await_stat(path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_stat(path, function(e, r)
      err = e
      result = r
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fstat(fd)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_fstat(fd, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_lstat(path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_lstat(path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_rename(path, new_path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_rename(path, new_path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fsync(fd)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_fsync(fd, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fdatasync(fd)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_fdatasync(fd, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_ftruncate(fd, offset)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_ftruncate(fd, offset, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_sendfile(out_fd, in_fd, in_offset, size)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_sendfile(out_fd, in_fd, in_offset, size, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_access(path, mode)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_access(path, mode, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_chmod(path, mode)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_chmod(path, mode, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fchmod(fd, mode)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_fchmod(fd, mode, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_utime(path, atime, mtime)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_utime(path, atime, mtime, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_futime(fd, atime, mtime)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_futime(fd, atime, mtime, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_lutime(path, atime, mtime)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_lutime(path, atime, mtime, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_link(path, new_path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_link(path, new_path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_symlink(path, new_path, flags)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_symlink(path, new_path, flags, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_readlink(path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_readlink(path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_realpath(path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_realpath(path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_chown(path, uid, gid)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_chown(path, uid, gid, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_fchown(fd, uid, gid)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_fchown(fd, uid, gid, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_lchown(fd, uid, gid)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_lchown(fd, uid, gid, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_copyfile(path, new_path, flags)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_copyfile(path, new_path, flags, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.Directory.new(impl)
   return setmetatable(
   {
      _impl = impl,
   },
   { __index = luv_async.Directory })
end

function luv_async.Directory:await_readdir()
   local event = lusc.new_event()
   local result
   local err

   assert(self._impl:readdir(function(e, r)
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

function luv_async.Directory:await_closedir()
   local event = lusc.new_event()
   local result
   local err

   assert(self._impl:closedir(function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

function luv_async.await_opendir(path, entries)
   assert(path ~= nil)
   assert(entries ~= nil, "Must provide a value for entries")

   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_opendir(path, function(e, r)
      result = r
      err = e
      event:set()
   end, entries))
   event:await()

   assert(result ~= nil, err)
   return luv_async.Directory.new(result)
end

function luv_async.await_statfs(path)
   local event = lusc.new_event()
   local result
   local err

   assert(uv.fs_statfs(path, function(e, r)
      result = r
      err = e
      event:set()
   end))
   event:await()

   assert(result ~= nil, err)
   return result
end

return luv_async
