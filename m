Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93877313543;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518988; cv=none; b=DaFA3e3/wGCdL85j/rp1/OmTyaB71FlMVoe70TDvz8nHhuPCnkqtZGdy8LycHwtgKVdn5XaJMBlS8iCLSSN3iib4z/o+ZPjJaX7pmVLL1IGlFGFw8iqszcTnEzvRHh5UnSy5jEKm6dQ4eOCm7eHlXWULwaBYfRXcMbMTlEK6ULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518988; c=relaxed/simple;
	bh=91+7/frEMLm5t4qfjeKHnincp9BQzBV2pqikrHqKSQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqijtoyP72HCRZk+gdAT+bn3k8xHEODiQrUHpAbds3C0DDc6AN9bhvUPFfsGxcGRahCgOUGY/vHEXLXnz9JuKDw8m5VKJVDUIg5sAb0juzg/gi/v/T1ZV7XZ24VC8w2RhMuNR/BOAFknQ107SYUkXn4cDsqGIXBGKidRtc/BsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozQ008ZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozQ008ZV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58399C2BCFA;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786518988;
	bh=91+7/frEMLm5t4qfjeKHnincp9BQzBV2pqikrHqKSQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ozQ008ZVpsc/6k/mFp+Yi32cLoiazZxUO8dx+ZNfcYZVMHridzvQleJ6Juli0VcZ1
	 wN1n5rjfsx+huPkVYd8WfeUTmeiNzf1K8StGyLUhnW5ugvtqZshTTeDa2MYkuW9wHl
	 KNW49dtK9wr3zJJ0dKwN50JxFlzUXEaB0WiXutlg9yoRdGLbu4C5GeagEDrQFo90Yi
	 pkGUhalyChQu8UszobsMSEEDvoZL/PZRDgp4DDr5I5ZSG42MCneWA+wpjUANWaA1dq
	 I1iHt8U8fEVuQ2b0Q7HT8ewEi1D+IWDGMulPqB/b5sGsJhVp158bGqznLilj/P1bdw
	 GF/ruFbc3YMpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3EAC5B56A;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 12 Aug 2026 00:16:18 -0700
Subject: [PATCH v4 2/5] ceph: replace the request_tree rbtree with an
 xarray keyed by r_tid
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-ceph-mdsc-mutex-optimization-v4-2-fca3b7462f94@clyso.com>
References: <20260812-ceph-mdsc-mutex-optimization-v4-0-fca3b7462f94@clyso.com>
In-Reply-To: <20260812-ceph-mdsc-mutex-optimization-v4-0-fca3b7462f94@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786518984; l=11800;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=ReChigIhMkeXtZj0pJ89gZHi/rbO4lqw10o8xu89Wsg=;
 b=sNZsomrN4SnZSUtr2X76KAIm1viN5J3io/3lt+C4r03U+yKkhWJCuG7MYk+ReaGBZt9foauOC
 0NWa8d6G+Z8Auy2PF4RfqMncrF0F0FIsDVcnJptBxVAVYV3j99oN1xy
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

Replace the red-black tree that indexes pending MDS requests by
transaction ID with an xarray.  The xarray provides O(1) keyed
lookups versus the rbtree's O(log N), and its internal RCU
locking eliminates the need for an external mutex during lookups.
Iteration is also simpler, with the xarray's native iterators
replacing open-coded rb_first() / rb_next() walks.

Because xarray indices are unsigned long, a u64 transaction ID
would be truncated on 32-bit platforms.  Restrict CEPH_FS to
64BIT since there are no 32-bit users.

Validate the xarray insertion and clean up the structure at
shutdown.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/Kconfig      |   1 +
 fs/ceph/debugfs.c    |   6 +--
 fs/ceph/mds_client.c | 113 +++++++++++++++++++++++----------------------------
 fs/ceph/mds_client.h |   3 +-
 4 files changed, 56 insertions(+), 67 deletions(-)

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 3d64a316ca31..1d95f9c7e271 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -2,6 +2,7 @@
 config CEPH_FS
 	tristate "Ceph distributed file system"
 	depends on INET
+	depends on 64BIT
 	select CEPH_LIB
 	select NETFS_SUPPORT
 	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 18eb5da03411..491ead3fe1c6 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -87,12 +87,12 @@ static int mdsc_show(struct seq_file *s, void *p)
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
-	struct rb_node *rp;
+	unsigned long idx;
 	char *path;
 
 	mutex_lock(&mdsc->mutex);
-	for (rp = rb_first(&mdsc->request_tree); rp; rp = rb_next(rp)) {
-		req = rb_entry(rp, struct ceph_mds_request, r_node);
+	idx = 0;
+	xa_for_each(&mdsc->request_tree, idx, req) {
 
 		if (req->r_request && req->r_session)
 			seq_printf(s, "%lld\tmds%d\t", req->r_tid,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2c51edd0e9cd..c1df7e0ac051 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1188,7 +1188,6 @@ void ceph_mdsc_release_request(struct kref *kref)
 	kmem_cache_free(ceph_mds_request_cachep, req);
 }
 
-DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
 
 /*
  * lookup session, bump ref if found.
@@ -1200,7 +1199,7 @@ lookup_get_request(struct ceph_mds_client *mdsc, u64 tid)
 {
 	struct ceph_mds_request *req;
 
-	req = lookup_request(&mdsc->request_tree, tid);
+	req = xa_load(&mdsc->request_tree, tid);
 	if (req)
 		ceph_mdsc_get_request(req);
 
@@ -1234,7 +1233,14 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	}
 	doutc(cl, "%p tid %lld\n", req, req->r_tid);
 	ceph_mdsc_get_request(req);
-	insert_request(&mdsc->request_tree, req);
+	if (xa_is_err(xa_store(&mdsc->request_tree, req->r_tid, req,
+			       GFP_NOFS))) {
+		pr_err_client(cl, "%p tid %lld: xa_store failed\n",
+			      req, req->r_tid);
+		ceph_mdsc_put_request(req);
+		req->r_err = -ENOMEM;
+		return;
+	}
 
 	req->r_cred = get_current_cred();
 	if (!req->r_mnt_idmap)
@@ -1263,20 +1269,19 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 	list_del_init(&req->r_unsafe_item);
 
 	if (req->r_tid == READ_ONCE(mdsc->oldest_tid)) {
-		struct rb_node *p = rb_next(&req->r_node);
+		unsigned long tidx = req->r_tid + 1;
+		struct ceph_mds_request *next_req;
+
 		WRITE_ONCE(mdsc->oldest_tid, 0);
-		while (p) {
-			struct ceph_mds_request *next_req =
-				rb_entry(p, struct ceph_mds_request, r_node);
+		xa_for_each_start(&mdsc->request_tree, tidx, next_req, tidx) {
 			if (next_req->r_op != CEPH_MDS_OP_SETFILELOCK) {
 				WRITE_ONCE(mdsc->oldest_tid, next_req->r_tid);
 				break;
 			}
-			p = rb_next(p);
 		}
 	}
 
-	erase_request(&mdsc->request_tree, req);
+	xa_erase(&mdsc->request_tree, req->r_tid);
 
 	if (req->r_unsafe_dir) {
 		struct ceph_inode_info *ci = ceph_inode(req->r_unsafe_dir);
@@ -1833,7 +1838,7 @@ static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
-	struct rb_node *p;
+	unsigned long idx;
 
 	doutc(cl, "mds%d\n", session->s_mds);
 	mutex_lock(&mdsc->mutex);
@@ -1849,10 +1854,8 @@ static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 		__unregister_request(mdsc, req);
 	}
 	/* zero r_attempts, so kick_requests() will re-send requests */
-	p = rb_first(&mdsc->request_tree);
-	while (p) {
-		req = rb_entry(p, struct ceph_mds_request, r_node);
-		p = rb_next(p);
+	idx = 0;
+	xa_for_each(&mdsc->request_tree, idx, req) {
 		if (req->r_session &&
 		    req->r_session->s_mds == session->s_mds)
 			req->r_attempts = 0;
@@ -2736,7 +2739,6 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	req->r_fmode = -1;
 	req->r_feature_needed = -1;
 	kref_init(&req->r_kref);
-	RB_CLEAR_NODE(&req->r_node);
 	INIT_LIST_HEAD(&req->r_wait);
 	init_completion(&req->r_completion);
 	init_completion(&req->r_safe_completion);
@@ -2756,10 +2758,9 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
  */
 static struct ceph_mds_request *__get_oldest_req(struct ceph_mds_client *mdsc)
 {
-	if (RB_EMPTY_ROOT(&mdsc->request_tree))
-		return NULL;
-	return rb_entry(rb_first(&mdsc->request_tree),
-			struct ceph_mds_request, r_node);
+	unsigned long idx = 0;
+
+	return xa_find(&mdsc->request_tree, &idx, ULONG_MAX, XA_PRESENT);
 }
 
 static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
@@ -3820,12 +3821,11 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
-	struct rb_node *p = rb_first(&mdsc->request_tree);
+	unsigned long idx;
 
 	doutc(cl, "kick_requests mds%d\n", mds);
-	while (p) {
-		req = rb_entry(p, struct ceph_mds_request, r_node);
-		p = rb_next(p);
+	idx = 0;
+	xa_for_each(&mdsc->request_tree, idx, req) {
 		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 			continue;
 		if (req->r_attempts > 0)
@@ -4668,7 +4668,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 				   struct ceph_mds_session *session)
 {
 	struct ceph_mds_request *req, *nreq;
-	struct rb_node *p;
+	unsigned long idx;
 
 	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
@@ -4680,10 +4680,8 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 	 * also re-send old requests when MDS enters reconnect stage. So that MDS
 	 * can process completed request in clientreplay stage.
 	 */
-	p = rb_first(&mdsc->request_tree);
-	while (p) {
-		req = rb_entry(p, struct ceph_mds_request, r_node);
-		p = rb_next(p);
+	idx = 0;
+	xa_for_each(&mdsc->request_tree, idx, req) {
 		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 			continue;
 		if (req->r_attempts == 0)
@@ -5528,7 +5526,7 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	 */
 	{
 		struct ceph_mds_request *req;
-		struct rb_node *rn;
+		unsigned long idx;
 		u64 last_tid;
 
 		mutex_lock(&mdsc->mutex);
@@ -5536,14 +5534,12 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		mutex_unlock(&mdsc->mutex);
 
 		mutex_lock(&mdsc->mutex);
-		rn = rb_first(&mdsc->request_tree);
-		while (rn) {
-			req = rb_entry(rn, struct ceph_mds_request, r_node);
-			if (req->r_tid > last_tid)
-				break;
+		idx = 0;
+		while ((req = xa_find(&mdsc->request_tree, &idx, last_tid,
+				      XA_PRESENT))) {
 			if (req->r_op == CEPH_MDS_OP_SETFILELOCK ||
 			    !(req->r_op & CEPH_MDS_OP_WRITE)) {
-				rn = rb_next(rn);
+				idx++;
 				continue;
 			}
 			ceph_mdsc_get_request(req);
@@ -5556,7 +5552,7 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 			ceph_mdsc_put_request(req);
 			if (time_after(jiffies, drain_deadline))
 				break;
-			rn = rb_first(&mdsc->request_tree);
+			idx = 0;  /* restart: tree may have changed */
 		}
 		mutex_unlock(&mdsc->mutex);
 
@@ -6282,7 +6278,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->snap_realms = RB_ROOT;
 	INIT_LIST_HEAD(&mdsc->snap_empty);
 	spin_lock_init(&mdsc->snap_empty_lock);
-	mdsc->request_tree = RB_ROOT;
+	xa_init(&mdsc->request_tree);
 	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
 	mdsc->last_renew_caps = jiffies;
 	INIT_LIST_HEAD(&mdsc->cap_delay_list);
@@ -6604,34 +6600,33 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 						 u64 want_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
-	struct ceph_mds_request *req = NULL, *nextreq;
+	struct ceph_mds_request *req;
 	struct ceph_mds_session *last_session = NULL;
-	struct rb_node *n;
+	unsigned long idx;
 
 	mutex_lock(&mdsc->mutex);
 	doutc(cl, "want %lld\n", want_tid);
-restart:
-	req = __get_oldest_req(mdsc);
-	while (req && req->r_tid <= want_tid) {
-		/* find next request */
-		n = rb_next(&req->r_node);
-		if (n)
-			nextreq = rb_entry(n, struct ceph_mds_request, r_node);
-		else
-			nextreq = NULL;
-		if (req->r_op != CEPH_MDS_OP_SETFILELOCK &&
-		    (req->r_op & CEPH_MDS_OP_WRITE)) {
+	idx = 0;
+	while ((req = xa_find(&mdsc->request_tree, &idx, want_tid,
+			      XA_PRESENT))) {
+		u64 next_tid = req->r_tid + 1;
+
+		if (req->r_op == CEPH_MDS_OP_SETFILELOCK ||
+		    !(req->r_op & CEPH_MDS_OP_WRITE)) {
+			idx = next_tid;
+			continue;
+		}
+
+		{
 			struct ceph_mds_session *s = req->r_session;
 
 			if (!s) {
-				req = nextreq;
+				idx = next_tid;
 				continue;
 			}
 
 			/* write op */
 			ceph_mdsc_get_request(req);
-			if (nextreq)
-				ceph_mdsc_get_request(nextreq);
 			s = ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
 
@@ -6649,16 +6644,9 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 
 			mutex_lock(&mdsc->mutex);
 			ceph_mdsc_put_request(req);
-			if (!nextreq)
-				break;  /* next dne before, so we're done! */
-			if (RB_EMPTY_NODE(&nextreq->r_node)) {
-				/* next request was removed from tree */
-				ceph_mdsc_put_request(nextreq);
-				goto restart;
-			}
-			ceph_mdsc_put_request(nextreq);  /* won't go away */
+			/* restart from the next tid; tree may have changed */
+			idx = next_tid;
 		}
-		req = nextreq;
 	}
 	mutex_unlock(&mdsc->mutex);
 	ceph_put_mds_session(last_session);
@@ -6817,6 +6805,7 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 	if (mdsc->mdsmap)
 		ceph_mdsmap_destroy(mdsc->mdsmap);
 	kfree(mdsc->sessions);
+	xa_destroy(&mdsc->request_tree);
 	ceph_caps_finalize(mdsc);
 
 	if (mdsc->s_cap_auths) {
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0ece4c9e3529..976dc9ffac17 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -330,7 +330,6 @@ typedef int (*ceph_mds_request_wait_callback_t) (struct ceph_mds_client *mdsc,
  */
 struct ceph_mds_request {
 	u64 r_tid;                   /* transaction id */
-	struct rb_node r_node;
 	struct ceph_mds_client *r_mdsc;
 
 	struct kref       r_kref;
@@ -535,7 +534,7 @@ struct ceph_mds_client {
 	u64                    last_tid;      /* most recent mds request */
 	u64                    oldest_tid;    /* oldest incomplete mds request,
 						 excluding setfilelock requests */
-	struct rb_root         request_tree;  /* pending mds requests */
+	struct xarray           request_tree;  /* pending mds requests */
 	struct delayed_work    delayed_work;  /* delayed work */
 	unsigned long    last_renew_caps;  /* last time we renewed our caps */
 	struct list_head cap_delay_list;   /* caps with delayed release */

-- 
2.53.0


