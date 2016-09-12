From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 07/47] block-rbd: Rename a jump label in
 rbd_dev_v2_snap_name()
Date: Mon, 12 Sep 2016 20:48:43 +0200
Message-ID: <5017b292-584f-ecd1-ed76-9b89155f9acc@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 17:53:19 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index dd4da1f..4164551 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5532,18 +5532,18 @@ static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0) {
 		snap_name = ERR_PTR(ret);
-		goto out;
+		goto free_buffer;
 	}
 
 	p = reply_buf;
 	end = reply_buf + ret;
 	snap_name = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(snap_name))
-		goto out;
+		goto free_buffer;
 
 	dout("  snap_id 0x%016llx snap_name = %s\n",
 		(unsigned long long)snap_id, snap_name);
-out:
+ free_buffer:
 	kfree(reply_buf);
 
 	return snap_name;
-- 
2.10.0
