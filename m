From: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: [PATCH] use int64_t for return values from rbd instead
	of int
Date: Tue, 20 Nov 2012 13:44:55 +0100
Message-ID: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
List-Unsubscribe: <http://pve.proxmox.com/cgi-bin/mailman/options/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://pve.proxmox.com/pipermail/pve-devel>
List-Post: <mailto:pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
List-Help: <mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=help>
List-Subscribe: <http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=subscribe>
Sender: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
Errors-To: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
To: qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
Cc: pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org, josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

rbd / rados tends to return pretty often length of writes
or discarded blocks. These values might be bigger than int.

Signed-off-by: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
---
 block/rbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index f57d0c6..6bf9c2e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -69,7 +69,7 @@ typedef enum {
 typedef struct RBDAIOCB {
     BlockDriverAIOCB common;
     QEMUBH *bh;
-    int ret;
+    int64_t ret;
     QEMUIOVector *qiov;
     char *bounce;
     RBDAIOCmd cmd;
@@ -87,7 +87,7 @@ typedef struct RADOSCB {
     int done;
     int64_t size;
     char *buf;
-    int ret;
+    int64_t ret;
 } RADOSCB;
 
 #define RBD_FD_READ 0
-- 
1.7.10.4
