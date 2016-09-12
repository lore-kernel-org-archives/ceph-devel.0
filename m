From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 13/47] block-rbd: Delete an unnecessary initialisation in
 rbd_dev_v2_parent_info()
Date: Mon, 12 Sep 2016 20:58:40 +0200
Message-ID: <23eb73a3-ef48-4098-a2da-99e72350a22a@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 18:08:14 +0200

The local variable "reply_buf" will be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 946e3ca..aff8c4e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5084,7 +5084,7 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 {
 	struct rbd_spec *parent_spec;
 	size_t size;
-	void *reply_buf = NULL;
+	void *reply_buf;
 	__le64 snapid;
 	void *p;
 	void *end;
-- 
2.10.0
