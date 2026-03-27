Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5DB3F6618
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621868; cv=none; b=ZnkjuJFUZ+9D4wbBtZPuqbA6rEIPp6pts9pRiJp/cH4sZeuBBbMbTp0bM3ql2yyw0smqL49lXtmFSnP/Kmq7jIqAzW/wXUQX9n6HNntX3xwPtrJDDXiUhgPq3stQ3+LDYbqonjlT6d0xYTTV7rEFti8FiFp4UC0rk9tJQzENyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621868; c=relaxed/simple;
	bh=kQdDaaF624VMz7Qt83+M009lfBoI+RoRJTPXziNcD0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t62h+A2jh2TnpnhEKc/i+03GZV8mkrjSGiFNTWgOy+3S6jnre7ddgp3H2Qn0yTfns3cMQr4KtQDsg7hwoZfv3rhmbQDeVw/yOcBfad+E8UIECgvXXU94h1gy4Xa5uduj75L6g7GFYAcugkKZwmczD7B+c9Jv5MRIQFov+xixQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDTK7uPn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gh2YIf/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDTK7uPn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh2YIf/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBzPfYw69G0uuTp5QhGkOpCUN/svlv7m7HKofsB+07E=;
	b=GDTK7uPnBPRsfNfNRvz9QlYve2jhTDsmoLiJryXO2RF2QIpG9hSzpi57Wo0hL6XBF1mLEd
	xfKa0ChSVXFZEk7n61K5UcLEzcpm9kfHNPsHuVhmCGS2TFz77y6fbBBG4sr26GJrNIi6BC
	uh+jgpT1p+WkgTdjmR3eGgSepPEA2Ek=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678--EgrCCbiNvuHe8ZO3cfPGA-1; Fri, 27 Mar 2026 10:31:04 -0400
X-MC-Unique: -EgrCCbiNvuHe8ZO3cfPGA-1
X-Mimecast-MFC-AGG-ID: -EgrCCbiNvuHe8ZO3cfPGA_1774621863
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67df391509fso7295195eaf.3
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621863; x=1775226663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBzPfYw69G0uuTp5QhGkOpCUN/svlv7m7HKofsB+07E=;
        b=gh2YIf/SIKawU0ufHFPHufMtH+PN54ibeIczX9xSu6cMQsROu1M37UPtLySgTPGgE7
         IAXpJLwOKBkwX3mz/xwXWN5WAoj9hUaOdcaYR5IlCvNfopQFBCzKs3P+cQ4B3jzLB0tQ
         hFAXg2EY8Dtiuywle6PHh9cgTfRnwggiamgowX2l2ldWB2hp6WpR+m0lAtfqX+Azch69
         1AOE+r5XHf968K0v2iow/LQtHGaL5R/d5rC+FnJjSKAIk0Za+CKDjKi2mbFneSY3ZFfu
         brC0On63mGVuyMbq8T2Ltmfg8H/fyQHwaKRM2oVeRE28VDMHuyJL9MYBuIUzvTRfq/Rn
         Lniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621863; x=1775226663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBzPfYw69G0uuTp5QhGkOpCUN/svlv7m7HKofsB+07E=;
        b=bPr/PXeHheV9jKpo8kNSd/OyZ+GUjASmpW63v9MOVuzPHcvW2xYcrI1pzXgUCQqFgJ
         rRNiYOaUH0+u1is4b2QhLSkBusx775LNNa5Ev5K/fv+e7kMRMsOkHtp8sJZ0el1SfQU/
         42PaPPlGSGHOW2ey6M28/vXcTpANd4l0HiRkJixNB69WouvN2YE+6q6C1ttjrhMamKNJ
         xzJuNDuHoqNA1AHdNsuHCX03vjZ7zIRCTB2/t2XiNDRRhHsTA9twiJKFAvtD35fVcjRk
         yglVgqm9pbCU0HDHjdChNaX007tsVtQUBY1Ae9Yj1vYedCUnzCesjgtkHUzFHGrP/eDs
         F6hw==
X-Gm-Message-State: AOJu0Ywq7YmRMtyoyEqH3hxB0JYGDi3VQUtwHVVKEJ2EJsI2AoDMhigR
	D8QISdtmpkvqyHnsoFabIkE+igz0l6aykdz1EogRqj1zCGBkiwbZbrNDeAN3U5D4rvwopOWTbGV
	GVgn4k5b71umwyNQMvVA8htSHGfGsDZ+DhXz3aeNqz96g+IXRSbsx2mILCRFtzxRpDFJwDf5Tt3
	9b0tauduSJPaI1sUkSn2QfMKY2W1NnPSxzzf3ZvzbMrgplN9YmvQ==
X-Gm-Gg: ATEYQzycFuX179PJXe//AuuwgfYYE8LoRZ/dgjrUlZVoLLJBRSU4cut8Dnr85pni/KB
	Zr2z0KeP/z4ZLIU+Qs6PaqW0uKUsEMITc0YY1LTMLSjobx9ri+WokcJDiZjTtTYt1n4FwaPVo+V
	Mg7957kgWWWC4t8QGhgUrPZEGCNMcQh25Z6mw+VO243Kn7hDWR6kw37vEPa+9gqffU2ImrsJr03
	wuADRR9cvtMMVhN56dZqPO3k+zT39Q7m1llGzAqwxDT0RwODbo6yf84eGcGULbSeNwoRJ4zvKSy
	uS7fn1lobMl8fxaI/Dj5PVNC7DWYvTck4hln1/c6JlLVErHIBLiTFtYL6mJab/stlkwHhqJ+8AP
	Aw4HfCk0xQ6QgMvJHqZmNWcyAvv2/ysZM4RlqU0L/ML+43dJhjqY3veA=
X-Received: by 2002:a05:6820:1b19:b0:67e:10a0:8267 with SMTP id 006d021491bc7-67e1863c3e4mr1449382eaf.22.1774621862452;
        Fri, 27 Mar 2026 07:31:02 -0700 (PDT)
X-Received: by 2002:a05:6820:1b19:b0:67e:10a0:8267 with SMTP id 006d021491bc7-67e1863c3e4mr1449331eaf.22.1774621861679;
        Fri, 27 Mar 2026 07:31:01 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:31:01 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 05/10] ceph: implement reconnect-based manual reset worker
Date: Fri, 27 Mar 2026 14:30:41 +0000
Message-Id: <20260327143045.1393612-6-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the reconnect-based reset worker that snapshots eligible sessions,
tracks reconnect completion, and wires reset-driven reconnect handling
through the session state machine. This keeps the initial manual reset
path functional before the later patches switch recovery over to direct
session teardown.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 534 +++++++++++++++++++++++++++++++------------
 1 file changed, 394 insertions(+), 140 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4b5adc38f7b7..5a2a9e473058 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
+#include <linux/workqueue.h>
 #include <linux/mnt_idmapping.h>
 
 #include "super.h"
@@ -61,6 +62,7 @@ struct ceph_reconnect_state {
 	struct ceph_pagelist *pagelist;
 	unsigned msg_version;
 	bool allow_multi;
+	bool from_reset;
 };
 
 static void __wake_requests(struct ceph_mds_client *mdsc,
@@ -68,6 +70,8 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 static void ceph_cap_release_work(struct work_struct *work);
 static void ceph_cap_reclaim_work(struct work_struct *work);
 static void ceph_mdsc_reset_workfn(struct work_struct *work);
+static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mdsc,
+					     struct ceph_mds_session *session);
 
 static const struct ceph_connection_operations mds_con_ops;
 
@@ -3743,133 +3747,6 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	}
 }
 
-/*
- * Wait for an active reset to complete.
- * Returns 0 if reset completed successfully or no reset was active.
- * Returns -ETIMEDOUT if we timed out waiting.
- * Returns -ERESTARTSYS if interrupted by signal.
- */
-int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
-{
-	struct ceph_client_reset_state *st = &mdsc->reset_state;
-	struct ceph_client *cl = mdsc->fsc->client;
-	long timeout = CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
-	int blocked_count;
-	int ret;
-
-	if (!READ_ONCE(st->in_progress))
-		return 0;
-
-	blocked_count = atomic_inc_return(&st->blocked_requests);
-	doutc(cl, "request blocked during reset, %d total blocked\n",
-	      blocked_count);
-	trace_ceph_client_reset_blocked(mdsc, blocked_count);
-
-	ret = wait_event_interruptible_timeout(st->blocked_wq,
-					       !READ_ONCE(st->in_progress),
-					       timeout);
-
-	atomic_dec(&st->blocked_requests);
-
-	if (ret == 0) {
-		pr_warn_client(cl, "timed out waiting for reset to complete\n");
-		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
-		return -ETIMEDOUT;
-	}
-	if (ret < 0) {
-		trace_ceph_client_reset_unblocked(mdsc, ret);
-		return ret;
-	}
-
-	spin_lock(&st->lock);
-	ret = st->last_errno;
-	spin_unlock(&st->lock);
-	trace_ceph_client_reset_unblocked(mdsc, ret);
-	return ret;
-}
-
-static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
-{
-	struct ceph_client_reset_state *st = &mdsc->reset_state;
-
-	spin_lock(&st->lock);
-	st->last_finish = jiffies;
-	st->last_errno = ret;
-	st->in_progress = false;
-	if (ret)
-		st->failure_count++;
-	else
-		st->success_count++;
-	spin_unlock(&st->lock);
-
-	wake_up_all(&st->blocked_wq);
-	trace_ceph_client_reset_complete(mdsc, ret);
-}
-
-static void ceph_mdsc_reset_workfn(struct work_struct *work)
-{
-	struct ceph_mds_client *mdsc =
-		container_of(work, struct ceph_mds_client, reset_work);
-	struct ceph_client_reset_state *st = &mdsc->reset_state;
-	bool inject_error;
-	int ret = 0;
-
-	spin_lock(&st->lock);
-	inject_error = st->inject_error;
-	if (inject_error)
-		st->inject_error = false;
-	spin_unlock(&st->lock);
-
-	if (inject_error)
-		ret = -EIO;
-
-	ceph_mdsc_reset_complete(mdsc, ret);
-}
-
-int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
-			     const char *reason)
-{
-	struct ceph_client_reset_state *st = &mdsc->reset_state;
-	struct ceph_fs_client *fsc = mdsc->fsc;
-	const char *msg = (reason && reason[0]) ? reason : "manual";
-	int mount_state;
-
-	mount_state = READ_ONCE(fsc->mount_state);
-	if (mount_state != CEPH_MOUNT_MOUNTED) {
-		pr_warn_client(fsc->client,
-			       "reset rejected: mount_state=%d (not mounted)\n",
-			       mount_state);
-		return -EINVAL;
-	}
-
-	spin_lock(&st->lock);
-	if (st->in_progress) {
-		spin_unlock(&st->lock);
-		return -EBUSY;
-	}
-
-	st->in_progress = true;
-	st->active_reset_gen++;
-	st->last_start = jiffies;
-	st->last_errno = 0;
-	st->trigger_count++;
-	strscpy(st->last_reason, msg, sizeof(st->last_reason));
-	spin_unlock(&st->lock);
-
-	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
-		spin_lock(&st->lock);
-		st->in_progress = false;
-		st->last_errno = -EALREADY;
-		st->failure_count++;
-		spin_unlock(&st->lock);
-		wake_up_all(&st->blocked_wq);
-		return -EALREADY;
-	}
-
-	trace_ceph_client_reset_schedule(mdsc, msg);
-	return 0;
-}
-
 int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 			      struct ceph_mds_request *req)
 {
@@ -4524,9 +4401,11 @@ static void handle_session(struct ceph_mds_session *session,
 
 	switch (op) {
 	case CEPH_SESSION_OPEN:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
 			pr_info_client(cl, "mds%d reconnect success\n",
 				       session->s_mds);
+			ceph_mdsc_reconnect_session_done(mdsc, session);
+		}
 
 		session->s_features = features;
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
@@ -4559,9 +4438,11 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_CLOSE:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
 			pr_info_client(cl, "mds%d reconnect denied\n",
 				       session->s_mds);
+			ceph_mdsc_reconnect_session_done(mdsc, session);
+		}
 		session->s_state = CEPH_MDS_SESSION_CLOSED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
@@ -4600,7 +4481,13 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_REJECT:
-		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING);
+		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING &&
+			session->s_state != CEPH_MDS_SESSION_RECONNECTING);
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
+			pr_info_client(cl, "mds%d reconnect rejected\n",
+				       session->s_mds);
+			ceph_mdsc_reconnect_session_done(mdsc, session);
+		}
 		pr_info_client(cl, "mds%d rejected session\n",
 			       session->s_mds);
 		session->s_state = CEPH_MDS_SESSION_REJECTED;
@@ -4862,6 +4749,17 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	cap->mseq = 0;       /* and migrate_seq */
 	cap->cap_gen = atomic_read(&cap->session->s_cap_gen);
 
+	/*
+	 * Don't set CEPH_I_ERROR_FILELOCK here - instead, we attempt to
+	 * reclaim locks by sending them in the reconnect message.
+	 * The MDS will do best-effort reclaim. If locks can't be reclaimed
+	 * (e.g., another client grabbed a conflicting lock), future lock
+	 * operations will fail and the error flag will be set then.
+	 *
+	 * Note: i_filelock_ref > 0 means we have locks to reclaim.
+	 * The lock info will be encoded below if flock_len is non-zero.
+	 */
+
 	/* These are lost when the session goes away */
 	if (S_ISDIR(inode->i_mode)) {
 		if (cap->issued & CEPH_CAP_DIR_CREATE) {
@@ -4877,8 +4775,22 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(path_info.vino.ino);
-		rec.v2.flock_len = (__force __le32)
-			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
+		if (recon_state->from_reset) {
+			/*
+			 * Reset-initiated reconnect: always try to reclaim
+			 * locks. The MDS does best-effort; failures are
+			 * handled on future lock operations.
+			 */
+			rec.v2.flock_len = cpu_to_le32(1);
+		} else {
+			/*
+			 * Normal reconnect: skip lock reclaim if locks
+			 * were already known to be in error state.
+			 */
+			rec.v2.flock_len = cpu_to_le32(
+				test_bit(CEPH_I_ERROR_FILELOCK_BIT,
+					 &ci->i_ceph_flags) ? 0 : 1);
+		}
 	} else {
 		struct timespec64 ts;
 
@@ -5075,8 +4987,9 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
  *
  * This is a relatively heavyweight operation, but it's rare.
  */
-static void send_mds_reconnect(struct ceph_mds_client *mdsc,
-			       struct ceph_mds_session *session)
+static int send_mds_reconnect(struct ceph_mds_client *mdsc,
+			      struct ceph_mds_session *session,
+			      bool from_reset)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
@@ -5084,6 +4997,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	int err = -ENOMEM;
 	struct ceph_reconnect_state recon_state = {
 		.session = session,
+		.from_reset = from_reset,
 	};
 	LIST_HEAD(dispose);
 
@@ -5100,6 +5014,30 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	xa_destroy(&session->s_delegated_inos);
 
 	mutex_lock(&session->s_mutex);
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
+	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
+		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
+			       mds,
+			       ceph_session_state_name(session->s_state));
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ESTALE;
+		goto fail_nomsg;
+	}
+
+	mutex_lock(&mdsc->mutex);
+	if (mds >= mdsc->max_sessions || mdsc->sessions[mds] != session) {
+		mutex_unlock(&mdsc->mutex);
+		pr_info_client(cl,
+			       "mds%d skipping reconnect, session unregistered\n",
+			       mds);
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ENOENT;
+		goto fail_nomsg;
+	}
+	mutex_unlock(&mdsc->mutex);
+
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
@@ -5229,7 +5167,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	up_read(&mdsc->snap_rwsem);
 	ceph_pagelist_release(recon_state.pagelist);
-	return;
+	return 0;
 
 fail:
 	ceph_msg_put(reply);
@@ -5240,7 +5178,301 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 fail_nopagelist:
 	pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
 		      err, mds);
-	return;
+	return err;
+}
+
+/*
+ * Called when a session completes reconnection (success or failure).
+ * Only counts toward reset completion if this session's reconnect was
+ * initiated by the currently active reset generation.  Late completions
+ * from a prior (timed-out) reset are silently ignored.
+ *
+ * Caller must hold session->s_mutex to serialize s_reset_gen updates.
+ */
+static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mdsc,
+					     struct ceph_mds_session *session)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	u64 active_gen;
+
+	lockdep_assert_held(&session->s_mutex);
+
+	if (!session->s_reset_gen)
+		return;
+
+	spin_lock(&st->lock);
+	active_gen = st->active_reset_gen;
+	spin_unlock(&st->lock);
+
+	if (session->s_reset_gen != active_gen) {
+		session->s_reset_gen = 0;
+		return;
+	}
+
+	session->s_reset_gen = 0;
+
+	if (atomic_dec_and_test(&st->pending_reconnects))
+		complete(&st->reconnect_done);
+}
+
+/*
+ * Wait for a reset to complete if one is in progress.
+ * Returns 0 if reset completed successfully or wasn't in progress.
+ * Returns -ETIMEDOUT if we timed out waiting.
+ * Returns -ERESTARTSYS if interrupted by signal.
+ */
+int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_client *cl = mdsc->fsc->client;
+	long timeout = CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
+	int blocked_count;
+	int ret;
+
+	if (!READ_ONCE(st->in_progress))
+		return 0;
+
+	blocked_count = atomic_inc_return(&st->blocked_requests);
+	doutc(cl, "request blocked during reset, %d total blocked\n",
+	      blocked_count);
+	trace_ceph_client_reset_blocked(mdsc, blocked_count);
+
+	ret = wait_event_interruptible_timeout(st->blocked_wq,
+					       !READ_ONCE(st->in_progress),
+					       timeout);
+
+	atomic_dec(&st->blocked_requests);
+
+	if (ret == 0) {
+		pr_warn_client(cl, "timed out waiting for reset to complete\n");
+		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
+		return -ETIMEDOUT;
+	}
+	if (ret < 0) {
+		trace_ceph_client_reset_unblocked(mdsc, ret);
+		return ret;  /* -ERESTARTSYS */
+	}
+
+	/*
+	 * Propagate the reset result to all blocked callers.  If the
+	 * reset failed, sessions may be in an inconsistent state, so
+	 * failing requests forces the operator to investigate rather
+	 * than silently proceeding with potentially stale state.
+	 */
+	spin_lock(&st->lock);
+	ret = st->last_errno;
+	spin_unlock(&st->lock);
+
+	trace_ceph_client_reset_unblocked(mdsc, ret);
+	return ret;
+}
+
+static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+
+	spin_lock(&st->lock);
+	st->last_finish = jiffies;
+	st->last_errno = ret;
+	st->in_progress = false;
+	if (ret)
+		st->failure_count++;
+	else
+		st->success_count++;
+	spin_unlock(&st->lock);
+
+	/* Wake up all requests that were blocked waiting for reset */
+	wake_up_all(&st->blocked_wq);
+
+	trace_ceph_client_reset_complete(mdsc, ret);
+}
+
+static void ceph_mdsc_reset_workfn(struct work_struct *work)
+{
+	struct ceph_mds_client *mdsc =
+		container_of(work, struct ceph_mds_client, reset_work);
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_mds_session **sessions = NULL;
+	char reason[CEPH_CLIENT_RESET_REASON_LEN];
+	int max_sessions, i, n = 0;
+	bool inject_error;
+	u64 reset_gen;
+	int ret = 0;
+
+	spin_lock(&st->lock);
+	strscpy(reason, st->last_reason, sizeof(reason));
+	inject_error = st->inject_error;
+	if (inject_error)
+		st->inject_error = false;
+	reset_gen = st->active_reset_gen;
+	spin_unlock(&st->lock);
+
+	if (inject_error) {
+		ret = -EIO;
+		goto out_complete;
+	}
+
+	mutex_lock(&mdsc->mutex);
+	max_sessions = mdsc->max_sessions;
+	if (max_sessions <= 0) {
+		mutex_unlock(&mdsc->mutex);
+		goto out_complete;
+	}
+
+	sessions = kcalloc(max_sessions, sizeof(*sessions), GFP_NOFS);
+	if (!sessions) {
+		mutex_unlock(&mdsc->mutex);
+		ret = -ENOMEM;
+		pr_err_client(cl,
+			      "manual session reset failed to allocate session array\n");
+		ceph_mdsc_reset_complete(mdsc, ret);
+		return;
+	}
+
+	for (i = 0; i < max_sessions; i++) {
+		struct ceph_mds_session *session = mdsc->sessions[i];
+
+		if (!session)
+			continue;
+
+		/*
+		 * Read session state without s_mutex to avoid nesting
+		 * mdsc->mutex -> s_mutex, which would invert the
+		 * s_mutex -> mdsc->mutex order used by
+		 * cleanup_session_requests().  s_state is an int
+		 * so loads are atomic; send_mds_reconnect() will
+		 * reject sessions that transitioned to CLOSED or
+		 * REJECTED under s_mutex before proceeding.
+		 */
+		switch (READ_ONCE(session->s_state)) {
+		case CEPH_MDS_SESSION_OPEN:
+		case CEPH_MDS_SESSION_HUNG:
+		case CEPH_MDS_SESSION_OPENING:
+		case CEPH_MDS_SESSION_CLOSING:
+			sessions[n++] = ceph_get_mds_session(session);
+			break;
+		case CEPH_MDS_SESSION_RECONNECTING:
+			pr_info_client(cl,
+				       "mds%d already reconnecting, skipping\n",
+				       session->s_mds);
+			break;
+		default:
+			pr_info_client(cl,
+				       "mds%d in state %s, skipping reconnect\n",
+				       session->s_mds,
+				       ceph_session_state_name(session->s_state));
+			break;
+		}
+	}
+	mutex_unlock(&mdsc->mutex);
+
+	pr_info_client(cl,
+		       "manual session reset executing (sessions=%d, reason=\"%s\")\n",
+		       n, reason);
+
+	if (n == 0) {
+		kfree(sessions);
+		goto out_complete;
+	}
+
+	/* Initialize completion tracking */
+	reinit_completion(&st->reconnect_done);
+	atomic_set(&st->pending_reconnects, n);
+
+	for (i = 0; i < n; i++) {
+		int err;
+
+		mutex_lock(&sessions[i]->s_mutex);
+		sessions[i]->s_reset_gen = reset_gen;
+		mutex_unlock(&sessions[i]->s_mutex);
+
+		err = send_mds_reconnect(mdsc, sessions[i], true);
+		if (err) {
+			bool skipped = (err == -ESTALE || err == -ENOENT);
+
+			mutex_lock(&sessions[i]->s_mutex);
+			sessions[i]->s_reset_gen = 0;
+			mutex_unlock(&sessions[i]->s_mutex);
+
+			if (skipped) {
+				pr_info_client(cl,
+					       "mds%d reconnect skipped during reset: %d\n",
+					       sessions[i]->s_mds, err);
+			} else {
+				pr_err_client(cl,
+					      "mds%d reconnect failed: %d\n",
+					      sessions[i]->s_mds, err);
+				if (!ret)
+					ret = err;
+			}
+			if (atomic_dec_and_test(&st->pending_reconnects))
+				complete(&st->reconnect_done);
+		}
+		ceph_put_mds_session(sessions[i]);
+	}
+
+	kfree(sessions);
+
+	/* Wait for all sessions to complete reconnection */
+	if (!wait_for_completion_timeout(&st->reconnect_done,
+					 CEPH_CLIENT_RESET_TIMEOUT_SEC * HZ)) {
+		pr_warn_client(cl,
+			       "reset timed out waiting for %d sessions\n",
+			       atomic_read(&st->pending_reconnects));
+		if (!ret)
+			ret = -ETIMEDOUT;
+	}
+
+out_complete:
+	ceph_mdsc_reset_complete(mdsc, ret);
+}
+
+int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
+			     const char *reason)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_fs_client *fsc = mdsc->fsc;
+	const char *msg = (reason && reason[0]) ? reason : "manual";
+	int mount_state;
+
+	mount_state = READ_ONCE(fsc->mount_state);
+	if (mount_state != CEPH_MOUNT_MOUNTED) {
+		pr_warn_client(fsc->client,
+			       "reset rejected: mount_state=%d (not mounted)\n",
+			       mount_state);
+		return -EINVAL;
+	}
+
+	spin_lock(&st->lock);
+	if (st->in_progress) {
+		spin_unlock(&st->lock);
+		return -EBUSY;
+	}
+
+	st->in_progress = true;
+	st->active_reset_gen++;
+	st->last_start = jiffies;
+	st->last_errno = 0;
+	st->trigger_count++;
+	strscpy(st->last_reason, msg, sizeof(st->last_reason));
+	spin_unlock(&st->lock);
+
+	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
+		spin_lock(&st->lock);
+		st->in_progress = false;
+		st->last_errno = -EALREADY;
+		st->failure_count++;
+		spin_unlock(&st->lock);
+		wake_up_all(&st->blocked_wq);
+		return -EALREADY;
+	}
+
+	pr_info_client(mdsc->fsc->client,
+		       "manual session reset scheduled (reason=\"%s\")\n",
+		       msg);
+	trace_ceph_client_reset_schedule(mdsc, msg);
+	return 0;
 }
 
 
@@ -5321,9 +5553,15 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		 */
 		if (s->s_state == CEPH_MDS_SESSION_RESTARTING &&
 		    newstate >= CEPH_MDS_STATE_RECONNECT) {
+			int rc;
+
 			mutex_unlock(&mdsc->mutex);
 			clear_bit(i, targets);
-			send_mds_reconnect(mdsc, s);
+			rc = send_mds_reconnect(mdsc, s, false);
+			if (rc)
+				pr_err_client(cl,
+					      "mds%d reconnect failed: %d\n",
+					      i, rc);
 			mutex_lock(&mdsc->mutex);
 		}
 
@@ -5387,7 +5625,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		}
 		doutc(cl, "send reconnect to export target mds.%d\n", i);
 		mutex_unlock(&mdsc->mutex);
-		send_mds_reconnect(mdsc, s);
+		err = send_mds_reconnect(mdsc, s, false);
+		if (err)
+			pr_err_client(cl,
+				      "mds%d export target reconnect failed: %d\n",
+				      i, err);
 		ceph_put_mds_session(s);
 		mutex_lock(&mdsc->mutex);
 	}
@@ -6314,6 +6556,11 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	/* flush out any connection work with references to us */
 	ceph_msgr_flush();
 
+	/*
+	 * Mark reset as failed and wake any blocked waiters before
+	 * cancelling, so unmount doesn't stall on blocked_wq timeout
+	 * if cancel_work_sync() prevents the work from running.
+	 */
 	spin_lock(&mdsc->reset_state.lock);
 	if (mdsc->reset_state.in_progress) {
 		mdsc->reset_state.in_progress = false;
@@ -6498,8 +6745,13 @@ static void mds_peer_reset(struct ceph_connection *con)
 	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
 		       s->s_mds);
 	if (READ_ONCE(mdsc->fsc->mount_state) != CEPH_MOUNT_FENCE_IO &&
-	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >= CEPH_MDS_STATE_RECONNECT)
-		send_mds_reconnect(mdsc, s);
+	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >= CEPH_MDS_STATE_RECONNECT) {
+		int rc = send_mds_reconnect(mdsc, s, false);
+		if (rc)
+			pr_err_client(mdsc->fsc->client,
+				      "mds%d reconnect failed: %d\n",
+				      s->s_mds, rc);
+	}
 }
 
 static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
@@ -6511,6 +6763,8 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 
 	mutex_lock(&mdsc->mutex);
 	if (__verify_registered_session(mdsc, s) < 0) {
+		pr_info_client(cl, "dropping tid %llu from unregistered session %d\n",
+			       msg->hdr.tid, s->s_mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
-- 
2.34.1

