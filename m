From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] block-rbd: One function call less in
 rbd_dev_probe_parent() after error detection
Date: Mon, 23 Nov 2015 20:46:26 +0100
Message-ID: <56536D12.4000308@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <56536BAD.4000309@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56536BAD.4000309@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Nov 2015 20:22:41 +0100

The rbd_dev_destroy() function was called in two cases by the
rbd_dev_probe_parent() function during error handling even if
the passed variable contained a null pointer.

* This implementation detail could be improved by adjustments
  for jump targets according to the Linux coding style convention.

* Drop an unnecessary initialisation for the variable "parent" then.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 24a757e..2ad9092 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5148,7 +5148,7 @@ out_err:
  */
 static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 {
-	struct rbd_device *parent = NULL;
+	struct rbd_device *parent;
 	int ret;
 
 	if (!rbd_dev->parent_spec)
@@ -5157,14 +5157,14 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 	if (++depth > RBD_MAX_PARENT_CHAIN_LEN) {
 		pr_info("parent chain is too long (%d)\n", depth);
 		ret = -EINVAL;
-		goto out_err;
+		goto unparent_device;
 	}
 
 	parent = rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec,
 				NULL);
 	if (!parent) {
 		ret = -ENOMEM;
-		goto out_err;
+		goto unparent_device;
 	}
 
 	/*
@@ -5176,15 +5176,15 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 
 	ret = rbd_dev_image_probe(parent, depth);
 	if (ret < 0)
-		goto out_err;
+		goto destroy_device;
 
 	rbd_dev->parent = parent;
 	atomic_set(&rbd_dev->parent_ref, 1);
 	return 0;
-
-out_err:
-	rbd_dev_unparent(rbd_dev);
+destroy_device:
 	rbd_dev_destroy(parent);
+unparent_device:
+	rbd_dev_unparent(rbd_dev);
 	return ret;
 }
 
-- 
2.6.3
