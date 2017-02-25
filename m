From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v5 1/6] libceph: allow requests to return immediately on full conditions if caller wishes
Date: Sat, 25 Feb 2017 12:43:18 -0500
Message-ID: <20170225174323.20289-2-jlayton@redhat.com>
References: <20170225174323.20289-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbdBYRn0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 25 Feb 2017 12:43:26 -0500
In-Reply-To: <20170225174323.20289-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

Usually, when the osd map is flagged as full or the pool is at quota,
write requests just hang. This is not what we want for cephfs, where
it would be better to simply report -ENOSPC back to userland instead
of stalling.

If the caller knows that it will want an immediate error return instead
of blocking on a full or at-quota error condition then allow it to set a
flag to request that behavior.

Set that flag in ceph_osdc_new_request (since ceph.ko is the only caller),
and on any other write request from ceph.ko.

A later patch will deal with requests that were submitted before the new
map showing the full condition came in.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/addr.c                  | 1 +
 fs/ceph/file.c                  | 1 +
 include/linux/ceph/osd_client.h | 1 +
 net/ceph/osd_client.c           | 7 +++++++
 4 files changed, 10 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6ecb920602ed..4b9da6ee5c7f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1889,6 +1889,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
 
 	wr_req->r_mtime = ci->vfs_inode.i_mtime;
+	wr_req->r_abort_on_full = true;
 	err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
 
 	if (!err)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5a7134ef13d3..9dad32d0ed0b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -712,6 +712,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
 	req->r_callback = ceph_aio_complete_req;
 	req->r_inode = inode;
 	req->r_priv = aio_req;
+	req->r_abort_on_full = true;
 
 	ret = ceph_osdc_start_request(req->r_osdc, req, false);
 out:
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index f2ce9cd5ede6..55dcff2455e0 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -169,6 +169,7 @@ struct ceph_osd_request {
 	unsigned int		r_num_ops;
 
 	int               r_result;
+	bool		  r_abort_on_full; /* return ENOSPC when full */
 
 	struct ceph_osd_client *r_osdc;
 	struct kref       r_kref;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5c0938ddddf6..8fc0ccc7126f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -49,6 +49,7 @@ static void link_linger(struct ceph_osd *osd,
 			struct ceph_osd_linger_request *lreq);
 static void unlink_linger(struct ceph_osd *osd,
 			  struct ceph_osd_linger_request *lreq);
+static void complete_request(struct ceph_osd_request *req, int err);
 
 #if 1
 static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
@@ -961,6 +962,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 				       truncate_size, truncate_seq);
 	}
 
+	req->r_abort_on_full = true;
 	req->r_flags = flags;
 	req->r_base_oloc.pool = layout->pool_id;
 	req->r_base_oloc.pool_ns = ceph_try_get_string(layout->pool_ns);
@@ -1635,6 +1637,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	enum calc_target_result ct_res;
 	bool need_send = false;
 	bool promoted = false;
+	int ret = 0;
 
 	WARN_ON(req->r_tid);
 	dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
@@ -1669,6 +1672,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 		pr_warn_ratelimited("FULL or reached pool quota\n");
 		req->r_t.paused = true;
 		maybe_request_map(osdc);
+		if (req->r_abort_on_full)
+			ret = -ENOSPC;
 	} else if (!osd_homeless(osd)) {
 		need_send = true;
 	} else {
@@ -1685,6 +1690,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	link_request(osd, req);
 	if (need_send)
 		send_request(req);
+	else if (ret)
+		complete_request(req, ret);
 	mutex_unlock(&osd->lock);
 
 	if (ct_res == CALC_TARGET_POOL_DNE)
-- 
2.9.3

