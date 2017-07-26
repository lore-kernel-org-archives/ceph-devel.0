From: Brad Hubbard <bhubbard@redhat.com>
Subject: kraken + gcc7
Date: Wed, 26 Jul 2017 17:18:58 +1000
Message-ID: <CAF-wwdG6nhqFN85=ONTQ+XUc6mea3=QaqsaSfux_-pQvh2Wrsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38664 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdGZHTF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jul 2017 03:19:05 -0400
Received: by mail-pg0-f52.google.com with SMTP id k190so15065631pgk.5
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jul 2017 00:19:04 -0700 (PDT)
Received: from rskikr.localdomain (124-171-93-177.dyn.iinet.net.au. [124.171.93.177])
        by smtp.gmail.com with ESMTPSA id q199sm28471197pfq.135.2017.07.26.00.19.02
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jul 2017 00:19:03 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Today I needed to build the current Kraken HEAD using gcc7. Unfortunately, the
source of both ceph and the rocksdb submodule are incompatible with gcc7.

I came up with the attached patches which allow the sources to compile. I'm
posting them here as they may help someone make progress until the problems with
gcc7 are fixed in the kraken branch.

-- 
Cheers,
Brad

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ceph-kraken.patch"

diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 93963cf8be..86abc79b01 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -688,7 +688,10 @@ install(TARGETS ceph-mon DESTINATION bin)
 # OSD/ObjectStore
 # make rocksdb statically
 
-set(ROCKSDB_CMAKE_ARGS -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
+set(THE_FLAGS "-Wno-expansion-to-defined -Wno-implicit-fallthrough -Wno-format-truncation")
+set(ROCKSDB_CMAKE_ARGS -DCMAKE_POSITION_INDEPENDENT_CODE=ON
+  -DCMAKE_CXX_FLAGS=${THE_FLAGS}
+  -DCMAKE_C_FLAGS=${THE_FLAGS})
 
 if(ALLOCATOR STREQUAL "jemalloc")
   list(APPEND ROCKSDB_CMAKE_ARGS -DWITH_JEMALLOC=ON)
diff --git a/src/os/FuseStore.h b/src/os/FuseStore.h
index bb9e59f5f4..04681e645c 100644
--- a/src/os/FuseStore.h
+++ b/src/os/FuseStore.h
@@ -7,6 +7,7 @@
 #include <string>
 #include <map>
 #include <mutex>
+#include <functional>
 
 #include "common/Thread.h"
 #include "include/buffer.h"

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rocksdb-kraken.patch"

diff --git a/util/thread_local.h b/util/thread_local.h
index 5806b544..f0af7504 100644
--- a/util/thread_local.h
+++ b/util/thread_local.h
@@ -13,6 +13,7 @@
 #include <memory>
 #include <unordered_map>
 #include <vector>
+#include <functional>
 
 #include "util/autovector.h"
 #include "port/port.h"
diff --git a/utilities/persistent_cache/block_cache_tier.h b/utilities/persistent_cache/block_cache_tier.h
index 9330d053..baefca32 100644
--- a/utilities/persistent_cache/block_cache_tier.h
+++ b/utilities/persistent_cache/block_cache_tier.h
@@ -15,6 +15,7 @@
 #include <stdexcept>
 #include <string>
 #include <thread>
+#include <functional>
 
 #include "rocksdb/cache.h"
 #include "rocksdb/comparator.h"
diff --git a/utilities/persistent_cache/block_cache_tier_file.h b/utilities/persistent_cache/block_cache_tier_file.h
index c2311ffc..c77d1d7b 100644
--- a/utilities/persistent_cache/block_cache_tier_file.h
+++ b/utilities/persistent_cache/block_cache_tier_file.h
@@ -10,6 +10,7 @@
 #include <memory>
 #include <string>
 #include <vector>
+#include <functional>
 
 #include "rocksdb/comparator.h"
 #include "rocksdb/env.h"
diff --git a/utilities/persistent_cache/volatile_tier_impl.h b/utilities/persistent_cache/volatile_tier_impl.h
index a29c4ac3..f3ca79d6 100644
--- a/utilities/persistent_cache/volatile_tier_impl.h
+++ b/utilities/persistent_cache/volatile_tier_impl.h
@@ -12,6 +12,7 @@
 #include <sstream>
 #include <string>
 #include <vector>
+#include <functional>
 
 #include "rocksdb/cache.h"
 #include "utilities/persistent_cache/hash_table.h"

--EeQfGwPcQSOJBaQU--
