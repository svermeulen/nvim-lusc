#!/bin/bash
set -ex
cd `dirname $BASH_SOURCE`/../..
rm -rf ./lua
mkdir ./lua
mkdir ./lua/lusc
mkdir ./lua/lusc/internal
mkdir ./lua/lusc/tests
tl gen src/teal/lusc/init.tl -o lua/lusc/init.lua
tl gen src/teal/lusc/internal/util.tl -o lua/lusc/internal/util.lua
cp src/teal/lusc/internal/queue.lua lua/lusc/internal/queue.lua
tl gen src/teal/lusc/tests/async_helper.tl -o lua/lusc/tests/async_helper.lua
tl gen src/teal/lusc/tests/lusc_spec.tl -o lua/lusc/tests/lusc_spec.lua
tl gen src/teal/lusc/tests/setup.tl -o lua/lusc/tests/setup.lua
tl gen src/teal/lusc/luv_async.tl -o lua/lusc/luv_async.lua
tl gen src/teal/lusc/tests/luv_async_spec.tl -o lua/lusc/tests/luv_async_spec.lua
tl gen src/teal/nvim-lusc.tl -o lua/nvim-lusc.lua
