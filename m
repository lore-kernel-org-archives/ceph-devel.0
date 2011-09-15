From: Sage Weil <sage@newdream.net>
Subject: [PATCH 3/4] rbd: update comment heading
Date: Thu, 15 Sep 2011 14:11:10 -0700
Message-ID: <1316121071-7690-4-git-send-email-sage@newdream.net>
References: <1316121071-7690-1-git-send-email-sage@newdream.net>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1316121071-7690-1-git-send-email-sage@newdream.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

Properly document the configuration string syntax and semantics.  Remove
(out of date) details about the librbd implementation.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 43f0e63..202e7ec 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -13,35 +13,33 @@
 
 #include "qemu-common.h"
 #include "qemu-error.h"
-
 #include "block_int.h"
 
 #include <rbd/librbd.h>
 
-
-
 /*
  * When specifying the image filename use:
  *
  * rbd:poolname/devicename[@snapshotname][:option1=value1[:option2=value2...]]
  *
- * poolname must be the name of an existing rados pool
+ * poolname must be the name of an existing rados pool.
  *
- * devicename is the basename for all objects used to
- * emulate the raw device.
+ * devicename is the name of the rbd image.
  *
- * Each option given is used to configure rados, and may be
- * any Ceph option, or "conf". The "conf" option specifies
- * a Ceph configuration file to read.
+ * Each option given is used to configure rados, and may be any valid
+ * Ceph option, "id", or "conf".
  *
- * Metadata information (image size, ...) is stored in an
- * object with the name "devicename.rbd".
+ * The "id" option indicates what user we should authenticate as to
+ * the Ceph cluster.  If it is excluded we will use the Ceph default
+ * (normally 'admin').
  *
- * The raw device is split into 4MB sized objects by default.
- * The sequencenumber is encoded in a 12 byte long hex-string,
- * and is attached to the devicename, separated by a dot.
- * e.g. "devicename.1234567890ab"
+ * The "conf" option specifies a Ceph configuration file to read.  If
+ * it is not specified, we will read from the default Ceph locations
+ * (e.g., /etc/ceph/ceph.conf).  To avoid reading _any_ configuration
+ * file, specify conf=/dev/null.
  *
+ * Configuration values containing :, @, or = can be escaped with a
+ * leading "\".
  */
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
-- 
1.7.2.5
