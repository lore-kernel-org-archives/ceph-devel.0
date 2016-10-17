From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/28] block: rdb: false-postive gcc-4.9 -Wmaybe-uninitialized
Date: Tue, 18 Oct 2016 00:10:14 +0200
Message-ID: <20161017221037.1781185-2-arnd@arndb.de>
References: <20161017220342.1627073-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:55549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757746AbcJQWLT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2016 18:11:19 -0400
In-Reply-To: <20161017220342.1627073-1-arnd@arndb.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Alex Elder <elder@kernel.org>, Mike Christie <mchristi@redhat.com>, ceph-devel@vger.kernel.org

When building with gcc-4.9 -Wmaybe-uninitialized, we get a bogus
warning in rbd_watch_cb, as the variable is not used at all
in the one case in which it is not initialized first:

drivers/block/rbd.c: In function ‘rbd_watch_cb’:
drivers/block/rbd.c:3690:5: error: ‘struct_v’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/block/rbd.c:3759:5: note: ‘struct_v’ was declared here

Later compiler versions fix this, but adding another initialization
here is harmless and lets us build cleanly with 4.9 as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index abb7162..4ab990b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3776,6 +3776,7 @@ static void rbd_watch_cb(void *arg, u64 notify_id, u64 cookie,
 	} else {
 		/* legacy notification for header updates */
 		notify_op = RBD_NOTIFY_OP_HEADER_UPDATE;
+		struct_v = 0;
 		len = 0;
 	}
 
-- 
2.9.0

