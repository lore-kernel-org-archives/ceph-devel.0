From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v8 2/7] libceph: allow requests to return immediately on full conditions if caller wishes
Date: Mon, 17 Apr 2017 12:42:53 -0400
Message-ID: <20170417164258.31527-3-jlayton@redhat.com>
References: <20170417164258.31527-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754639AbdDQQnF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Apr 2017 12:43:05 -0400
In-Reply-To: <20170417164258.31527-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
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

Reviewed-by: "Yan, Zheng” <zyan@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/addr.c                  | 1 +
 fs/ceph/file.c                  | 1 +
 include/linux/ceph/osd_client.h | 1 +
 net/ceph/osd_client.c           | 7 +++++++
 4 files changed, 10 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1a3e1b40799a..7e3fae334620 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1892,6 +1892,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
 
 	wr_req->r_mtime = ci->vfs_inode.i_mtime;
+	wr_req->r_abort_on_full = true;
 	err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
 
 	if (!err)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 356b7c76a2f1..cff35a1ff53c 100644
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
index 3fc9e7754a9b..8cf644197b1a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -187,6 +187,7 @@ struct ceph_osd_request {
 	struct timespec r_mtime;              /* ditto */
 	u64 r_data_offset;                    /* ditto */
 	bool r_linger;                        /* don't resend on failure */
+	bool r_abort_on_full;		      /* return ENOSPC when full */
 
 	/* internal */
 	unsigned long r_stamp;                /* jiffies, send or check time */
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index feb666c22381..52a2019a2b64 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -961,6 +961,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 				       truncate_size, truncate_seq);
 	}
 
+	req->r_abort_on_full = true;
 	req->r_flags = flags;
 	req->r_base_oloc.pool = layout->pool_id;
 	req->r_base_oloc.pool_ns = ceph_try_get_string(layout->pool_ns);
@@ -1627,6 +1628,7 @@ static void maybe_request_map(struct ceph_osd_client *osdc)
 		ceph_monc_renew_subs(&osdc->client->monc);
 }
 
+static void complete_request(struct ceph_osd_request *req, int err);
 static void send_map_check(struct ceph_osd_request *req);
 
 static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
@@ -1636,6 +1638,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	enum calc_target_result ct_res;
 	bool need_send = false;
 	bool promoted = false;
+	bool need_abort = false;
 
 	WARN_ON(req->r_tid);
 	dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
@@ -1670,6 +1673,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 		pr_warn_ratelimited("FULL or reached pool quota\n");
 		req->r_t.paused = true;
 		maybe_request_map(osdc);
+		if (req->r_abort_on_full)
+			need_abort = true;
 	} else if (!osd_homeless(osd)) {
 		need_send = true;
 	} else {
@@ -1686,6 +1691,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	link_request(osd, req);
 	if (need_send)
 		send_request(req);
+	else if (need_abort)
+		complete_request(req, -ENOSPC);
 	mutex_unlock(&osd->lock);
 
 	if (ct_res == CALC_TARGET_POOL_DNE)
-- 
2.9.3

