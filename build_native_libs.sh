#!/usr/bin/env bash

set -euo pipefail

pushd /hadoop-${hadoop_version}-src
grep -rq __WAIT_STATUS . && patch -p1 < /YARN-8498-02.patch
mvn -B -q dependency:resolve
mvn -B package -Pdist,native -DskipTests -Dtar
mkdir -p "${target}" && rmdir "${target}"
mv hadoop-dist/target/hadoop-${hadoop_version}/lib/native "${target}"
popd
