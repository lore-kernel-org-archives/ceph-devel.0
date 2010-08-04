From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] ceph: rbd depends on BLOCK
Date: Wed, 4 Aug 2010 10:16:24 -0700
Message-ID: <20100804101624.5189893c.randy.dunlap@oracle.com>
References: <20100804151035.14678528.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100804151035.14678528.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Sage Weil <sage@newdream.net>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

When CONFIG_BLOCK is not enabled, fs/ceph/rbd has:
file: fs/ceph/rbd.c: errors: 71, warnings: 18

This is due to BLOCK being spelled as CONFIG_BLOCK
(and depends on being spelled as select).

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 fs/ceph/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20100804.orig/fs/ceph/Kconfig
+++ linux-next-20100804/fs/ceph/Kconfig
@@ -28,7 +28,7 @@ config CEPH_FS_PRETTYDEBUG
 config CEPH_RBD
 	bool "Rados block device (RBD)"
 	depends on CEPH_FS
-	select  CONFIG_BLOCK
+	depends on BLOCK
 	default y
 	help
 	  If you say Y here, ceph will include rbd, the RADOS block
