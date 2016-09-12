From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 44/47] block-rbd: Delete an unnecessary initialisation in
 do_rbd_add()
Date: Mon, 12 Sep 2016 21:33:16 +0200
Message-ID: <0983c37a-20c2-09c3-36f8-dcabdc51a75d@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 20:04:31 +0200

The local variable "rbd_dev" will be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7df0b90..b106c68 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6181,7 +6181,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 			  const char *buf,
 			  size_t count)
 {
-	struct rbd_device *rbd_dev = NULL;
+	struct rbd_device *rbd_dev;
 	struct ceph_options *ceph_opts = NULL;
 	struct rbd_options *rbd_opts = NULL;
 	struct rbd_spec *spec = NULL;
-- 
2.10.0
