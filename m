From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 38/47] block-rbd: Rename jump labels in rbd_client_create()
Date: Mon, 12 Sep 2016 21:27:29 +0200
Message-ID: <c5e4950a-2bb3-13c7-f744-eafe798682ca@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 19:57:19 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index abc2dcb..9902a7f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -718,19 +718,19 @@ static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts)
 	dout("%s:\n", __func__);
 	rbdc = kmalloc(sizeof(struct rbd_client), GFP_KERNEL);
 	if (!rbdc)
-		goto out_opt;
+		goto check_input;
 
 	kref_init(&rbdc->kref);
 	INIT_LIST_HEAD(&rbdc->node);
 
 	rbdc->client = ceph_create_client(ceph_opts, rbdc, 0, 0);
 	if (IS_ERR(rbdc->client))
-		goto out_rbdc;
+		goto free_rbdc;
 	ceph_opts = NULL; /* Now rbdc->client is responsible for ceph_opts */
 
 	ret = ceph_open_session(rbdc->client);
 	if (ret < 0)
-		goto out_client;
+		goto destroy_client;
 
 	spin_lock(&rbd_client_list_lock);
 	list_add_tail(&rbdc->node, &rbd_client_list);
@@ -739,11 +739,11 @@ static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts)
 	dout("%s: rbdc %p\n", __func__, rbdc);
 
 	return rbdc;
-out_client:
+ destroy_client:
 	ceph_destroy_client(rbdc->client);
-out_rbdc:
+ free_rbdc:
 	kfree(rbdc);
-out_opt:
+ check_input:
 	if (ceph_opts)
 		ceph_destroy_options(ceph_opts);
 	dout("%s: error %d\n", __func__, ret);
-- 
2.10.0

