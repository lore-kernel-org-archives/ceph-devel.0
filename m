From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 15/15] librados/librados.cc: fix implicitly-defined namespace 'std'
Date: Thu,  7 Feb 2013 20:42:03 +0100
Message-ID: <1360266123-28972-16-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33941 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422639Ab3BGToc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:44:32 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix warning from clang(++):

librados/librados.cc:15:17: warning: using directive refers to
 implicitly-defined namespace 'std'
using namespace std;
                ^
Include what we need and use the related classes.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/librados/librados.cc | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/librados/librados.cc b/src/librados/librados.cc
index 0ac6eb4..5a81a26 100644
--- a/src/librados/librados.cc
+++ b/src/librados/librados.cc
@@ -12,8 +12,6 @@
  *
  */
 
-using namespace std;
-
 #include "common/config.h"
 #include "common/errno.h"
 #include "common/ceph_argparse.h"
@@ -27,6 +25,20 @@ using namespace std;
 #include "librados/PoolAsyncCompletionImpl.h"
 #include "librados/RadosClient.h"
 
+#include <string>
+#include <map>
+#include <set>
+#include <vector>
+#include <list>
+#include <stdexcept>
+
+using std::string;
+using std::map;
+using std::set;
+using std::vector;
+using std::list;
+using std::runtime_error;
+
 #define dout_subsys ceph_subsys_rados
 #undef dout_prefix
 #define dout_prefix *_dout << "librados: "
-- 
1.8.1.2

