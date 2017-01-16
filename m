From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ceph: use BUG() instead of BUG_ON(1)
Date: Mon, 16 Jan 2017 12:06:09 +0100
Message-ID: <20170116110622.3870494-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

I ran into this compile warning, which is the result of BUG_ON(1)
not always leading to the compiler treating the code path as
unreachable:

include/linux/ceph/osdmap.h: In function 'ceph_can_shift_osds':
include/linux/ceph/osdmap.h:62:1: error: control reaches end of non-void function [-Werror=return-type]

Using BUG() here avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/ceph/osdmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 9a9041784dcf..412906609954 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -57,7 +57,7 @@ static inline bool ceph_can_shift_osds(struct ceph_pg_pool_info *pool)
 	case CEPH_POOL_TYPE_EC:
 		return false;
 	default:
-		BUG_ON(1);
+		BUG();
 	}
 }
 
-- 
2.9.0
