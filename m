From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 02/10] small_io_bench*.cc: remove twice included <iostream>
Date: Mon,  4 Feb 2013 17:54:01 +0100
Message-ID: <1359996849-26302-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58028 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756246Ab3BDQyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:15 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included <iostream>.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/bench/small_io_bench.cc      | 1 -
 src/test/bench/small_io_bench_dumb.cc | 1 -
 src/test/bench/small_io_bench_fs.cc   | 1 -
 src/test/bench/small_io_bench_rbd.cc  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/src/test/bench/small_io_bench.cc b/src/test/bench/small_io_bench.cc
index 3fc0eff..2b20027 100644
--- a/src/test/bench/small_io_bench.cc
+++ b/src/test/bench/small_io_bench.cc
@@ -12,7 +12,6 @@
 #include <sstream>
 #include <stdlib.h>
 #include <fstream>
-#include <iostream>
 
 #include "common/Formatter.h"
 
diff --git a/src/test/bench/small_io_bench_dumb.cc b/src/test/bench/small_io_bench_dumb.cc
index 46bdd0f..6d79fdd 100644
--- a/src/test/bench/small_io_bench_dumb.cc
+++ b/src/test/bench/small_io_bench_dumb.cc
@@ -12,7 +12,6 @@
 #include <sstream>
 #include <stdlib.h>
 #include <fstream>
-#include <iostream>
 
 #include "common/Formatter.h"
 
diff --git a/src/test/bench/small_io_bench_fs.cc b/src/test/bench/small_io_bench_fs.cc
index 6ce1394..4a3adc9 100644
--- a/src/test/bench/small_io_bench_fs.cc
+++ b/src/test/bench/small_io_bench_fs.cc
@@ -12,7 +12,6 @@
 #include <sstream>
 #include <stdlib.h>
 #include <fstream>
-#include <iostream>
 
 #include "common/Formatter.h"
 
diff --git a/src/test/bench/small_io_bench_rbd.cc b/src/test/bench/small_io_bench_rbd.cc
index 3f148eb..4c56ffd 100644
--- a/src/test/bench/small_io_bench_rbd.cc
+++ b/src/test/bench/small_io_bench_rbd.cc
@@ -11,7 +11,6 @@
 #include <sstream>
 #include <stdlib.h>
 #include <fstream>
-#include <iostream>
 
 #include "common/Formatter.h"
 
-- 
1.8.1.2

