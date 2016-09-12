From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 22/47] block-rbd: Rename a jump label in find_watcher()
Date: Mon, 12 Sep 2016 21:08:08 +0200
Message-ID: <905ccde3-b4cd-3cf6-adcf-a1820d1203fa@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:36:23 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7802351..ba8fb74 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3440,13 +3440,13 @@ static int find_watcher(struct rbd_device *rbd_dev,
 			     rbd_dev, cid.gid, cid.handle);
 			rbd_set_owner_cid(rbd_dev, &cid);
 			ret = 1;
-			goto out;
+			goto free_watchers;
 		}
 	}
 
 	dout("%s rbd_dev %p no watchers\n", __func__, rbd_dev);
 	ret = 0;
-out:
+free_watchers:
 	kfree(watchers);
 	return ret;
 }
-- 
2.10.0
