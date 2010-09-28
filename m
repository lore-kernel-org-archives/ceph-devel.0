From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] ceph: fix debugfs warnings
Date: Tue, 28 Sep 2010 09:53:10 -0700
Message-ID: <20100928095310.2983a888.randy.dunlap@oracle.com>
References: <20100928141823.8c61000e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100928141823.8c61000e.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Sage Weil <sage@newdream.net>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Include "super.h" outside of CONFIG_DEBUG_FS to eliminate a compiler warning:

fs/ceph/debugfs.c:266: warning: 'struct ceph_fs_client' declared inside parameter list
fs/ceph/debugfs.c:266: warning: its scope is only this definition or declaration, which is probably not what you want
fs/ceph/debugfs.c:271: warning: 'struct ceph_fs_client' declared inside parameter list

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 fs/ceph/debugfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20100927.orig/fs/ceph/debugfs.c
+++ linux-next-20100927/fs/ceph/debugfs.c
@@ -12,9 +12,10 @@
 #include <linux/ceph/auth.h>
 #include <linux/ceph/debugfs.h>
 
+#include "super.h"
+
 #ifdef CONFIG_DEBUG_FS
 
-#include "super.h"
 #include "mds_client.h"
 
 static int mdsmap_show(struct seq_file *s, void *p)
