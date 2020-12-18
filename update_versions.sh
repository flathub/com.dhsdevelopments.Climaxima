#!/bin/sh

set -e

(
    cd deps-parser
#    ./build.sh
)

tac deps-parser/qlbuild/result.json | sed -e '1s/,$//' | tac > result-fixed.json

maxima_rev=`git ls-remote https://git.code.sf.net/p/maxima/code refs/heads/master | awk '{print $1}'`
mcclim_rev=`git ls-remote https://github.com/McCLIM/McCLIM refs/heads/master | awk '{print $1}'`
climaxima_rev=`git ls-remote https://github.com/lokedhs/maxima-client refs/heads/master | awk '{print $1}'`
freetype2_rev=`git ls-remote https://github.com/lokedhs/cl-freetype2 refs/heads/master | awk '{print $1}'`

echo rev: ${climaxima_rev}

sed -e '/^CACHE_FILE_LIST/r result-fixed.json' \
    -e "s/MAXIMA_CODE_REV/$maxima_rev/" \
    -e "s/MCCLIM_REV/$mcclim_rev/" \
    -e "s/CLIMAXIMA_REV/$climaxima_rev/" \
    -e "s/FREETYPE2_REV/$freetype2_rev/" \
    climaxima.json.template | grep -v '^CACHE_FILE_LIST' > com.dhsdevelopments.Climaxima.json 
