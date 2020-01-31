From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/15] rbd: kill 'work_result'
Date: Fri, 31 Jan 2020 11:37:34 +0100
Message-ID: <20200131103739.136098-11-hare@suse.de>
References: <20200131103739.136098-1-hare@suse.de>
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200131103739.136098-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: ceph-devel.vger.kernel.org

Use 'pending_result' instead of 'work_result' and kill the latter.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/rbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a6c95b6e9c0c..671e941d6edf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -352,7 +352,6 @@ struct rbd_img_request {
 	struct mutex		state_mutex;
 	int			pending_result;
 	struct work_struct	work;
-	int			work_result;
 	struct kref		kref;
 };
 
@@ -2834,13 +2833,13 @@ static void rbd_img_handle_request_work(struct work_struct *work)
 	struct rbd_img_request *img_req =
 	    container_of(work, struct rbd_img_request, work);
 
-	rbd_img_handle_request(img_req, img_req->work_result);
+	rbd_img_handle_request(img_req, img_req->pending_result);
 }
 
 static void rbd_img_schedule(struct rbd_img_request *img_req, int result)
 {
 	INIT_WORK(&img_req->work, rbd_img_handle_request_work);
-	img_req->work_result = result;
+	img_req->pending_result = result;
 	queue_work(rbd_wq, &img_req->work);
 }
 
-- 
2.16.4
