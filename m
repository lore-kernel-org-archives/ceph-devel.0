From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] rbd: remove RBD_DEBUG
Date: Mon, 17 Jun 2013 12:15:51 +0200
Message-ID: <1371464151.26299.12.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The RBD_DEBUG macro is always defined, so it serves no purpose.
Removing it has the benefit that readers of the code won't be tricked
into thinking that rbd_assert() will compile away because they didn't
define RBD_DEBUG themselves.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Compile tested only.

 drivers/block/rbd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b8a58178..d3869b4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -44,8 +44,6 @@
 
 #include "rbd_types.h"
 
-#define RBD_DEBUG	/* Activate rbd_assert() calls */
-
 /*
  * The basic unit of block I/O is a sector.  It is interpreted in a
  * number of contexts in Linux (blk, bio, genhd), but the default is
@@ -444,7 +442,6 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
 	va_end(args);
 }
 
-#ifdef RBD_DEBUG
 #define rbd_assert(expr)						\
 		if (unlikely(!(expr))) {				\
 			printk(KERN_ERR "\nAssertion failure in %s() "	\
@@ -453,9 +450,6 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
 					__func__, __LINE__, #expr);	\
 			BUG();						\
 		}
-#else /* !RBD_DEBUG */
-#  define rbd_assert(expr)	((void) 0)
-#endif /* !RBD_DEBUG */
 
 static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request);
 static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
-- 
1.8.1.4
