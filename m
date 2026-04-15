Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9B40DFD6
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272504; cv=none; b=j4JtSUQHBizWz9+LBnGqjVgL5L23eFNFJi3IWKExUK/wz7LuYi12MKjAnTlNXBKpMCAQxv0Cx/rnaX/nQkHwiU8gwisDX9Sr8lSfeDien2lM+wLWKwHwK4ugqxVXTlJp6g3QJoL2uOsScptu2hjNLHyJseLbGiA7wFEC8ZgT2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272504; c=relaxed/simple;
	bh=nC4dvPOz/UMoWDa230ND3c0qOR1XY9s4Iu3fbaIELHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfElqB0proxVeea/Sz5qs4Ii2cATaZtQNtLqVlbg+XX+2GHmFxvq+NLS/OY4vQyi0yU97OEsqWTitYFguqo/L7LjHcumE57Liii1hTCW6zgE9+hV2+BS08kuVZvsBHXoutceHDGZl335qlGNnij6RouPeuB60XsdUCRE7daJUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsnJbbqB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bM5eJI3X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsnJbbqB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bM5eJI3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKxGecMlOZMPAG4oj3+9ulNPv3v8gJrZqzCyY+cN5us=;
	b=BsnJbbqBVdTRd6NP2vhmmLwbHYpFlomAGjtoRUW6e03UFFN2qW4ZZhRnGAUuMkGfpaJUCW
	T0VRKdDNk5o1KP7TgWnPPTlsz/O1K5GkDep4k0xb9+fBalbsvuwULQADmik5D94QrKzbcu
	LCmWTpWH88WSsOfBpQaUhagL9aT+BTY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-EU3XQULvMSSzu3wMRYZPyA-1; Wed, 15 Apr 2026 13:01:40 -0400
X-MC-Unique: EU3XQULvMSSzu3wMRYZPyA-1
X-Mimecast-MFC-AGG-ID: EU3XQULvMSSzu3wMRYZPyA_1776272499
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d8e4c29caso177086471cf.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272499; x=1776877299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKxGecMlOZMPAG4oj3+9ulNPv3v8gJrZqzCyY+cN5us=;
        b=bM5eJI3X0jjHsDYR93XUwkOIF94fUtdpvpd4DAvoSHHyFO3cmY77BVws2V4kQZKbZ/
         k7sl9RHXFeIO+Rkm7KF6FNx/ROZf2L08LEY3IoO/vRhML1RWyd2kqOUn9r+bMssGQWK8
         nU3lml279iITHvqjGksNvYOYPWjZ9dZElZRg3u6zqchSrRM2w7NGRQLm3RL+vhs8u5pa
         4qKxo6GfcYo96FMss5ay6+haXiceqYimyz2fYvhxlUBaLRRKVSFa520y6F9uFUpWJuUL
         kHjCnVRrTLJnXjzrb30IUZ4SX4z9jaBRRvP/PTBMtk8VRw4Z5TlRNy2Uk35Sv96Ja8mf
         ibwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272499; x=1776877299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKxGecMlOZMPAG4oj3+9ulNPv3v8gJrZqzCyY+cN5us=;
        b=sgOtKIm3Gb6/rdhvbTHt6Up5Cx176f469eujyVFgEeV45YPM96SJvIJ8JLtyJoIDad
         8enJL8tO4ekJ3/PNIJsq/X4GdnpCK7WFoCkVXxz3BM7VueqVdL+awem3k0vXFFtar9Cc
         NHc8ABeNQuvu4Xmmwd4wFltRXNmUCo+uL2JNqgzLCPFFgrCMG9uWpnIzbWUwT9tKvp9B
         TEfOFRUtX3QFUgCyznp+RQhB50NusTS1H9VW3S2Nr6e4ETi5O8hl+SDhHGq9CwRothZ0
         JvdCLMuc5ZnKApahKVpJ9mOldcpOpmJ+BHiD089M5VkaAlkVSCdOKlc/ypfoNjzSXjac
         Bchg==
X-Gm-Message-State: AOJu0YwNM290UO2wkdxXMmBjz3OK+LR9ToUxXH0QBFF0rgXAGsHNeM1h
	P4X8Al62NhRNRfUaaT/SGGYm1kq3glLdhzZsW1kJLGzM2hU+GY5d57Ykhx9zZ77xoWSIqvFl5eW
	ONy4t7IvVRLrxH/IqO9OKzGw5EbNW9fSpcgKWJCj8rKgQDUhMYTMIsmxwyl/u519b0r3GW/si3U
	uRJy6eMr4czbhox0lJvcV+AVS1zdiyjgLIruuWxMA+H0jpE6bRSQ==
X-Gm-Gg: AeBDieuI5s4UDABgGH/oCt4dTpb9t3OkLp8CzbtaqdthlGW6ZJlMiiQjP8+qorFMNkM
	qbt0Jr9Uo7ZT262ntcYTJiDQ34iZJAmaKlWFRqerKrnzUs6Wkr2n/JXw0HIzhP8JjqhLsaAP/xd
	FhIhqbG2oBI9vXEe71X/rpbZXLY+qqeDsnj8/vQ2ukL/SyhCMqbeuze5ESysogHYKhY4VUaKLMk
	70hgjTrvkT9DIE+CR0QoP3CuCKdy2cJsqV2K1HveDmz0QWuDsDWT8UJ9J/WElMPF//PNqEG29sI
	jMOVVYfYB28YEAFu3cef+QmxvQspZ0hLZcTjGLnZqyO5AW0Awtu/8N4HWYoM0A2RUFENakDi0px
	TVje+soOxu4xqTs2PYRdA/xLzrW1/LBm4Dc6YZKr8NUkk3SmfJnHoMgSFaJ+otY+CjQ==
X-Received: by 2002:a05:622a:1a8e:b0:50d:7b0c:35e7 with SMTP id d75a77b69052e-50dd5c6cd3amr330622161cf.43.1776272496650;
        Wed, 15 Apr 2026 10:01:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8e:b0:50d:7b0c:35e7 with SMTP id d75a77b69052e-50dd5c6cd3amr330599741cf.43.1776272472957;
        Wed, 15 Apr 2026 10:01:12 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:01:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 5/7] ceph: add client reset state machine and session teardown
Date: Wed, 15 Apr 2026 17:00:41 +0000
Message-Id: <20260415170043.3882912-6-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170043.3882912-1-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the client-side reset state machine, request gating, and manual
session teardown implementation.

Manual reset is an operator-triggered escape hatch for client/MDS
stalemates in which caps, locks, or unsafe metadata state stop making
forward progress.  The reset blocks new metadata work, attempts a
bounded best-effort drain of dirty client state while sessions are
still alive, and finally asks the MDS to close sessions before tearing
local session state down directly.

The reset state machine tracks four phases: IDLE -> QUIESCING ->
DRAINING -> TEARDOWN -> IDLE.  QUIESCING is set synchronously by
schedule_reset() before the workqueue item is dispatched, so that new
metadata requests and file-lock acquisitions are gated immediately --
even before the work function begins running.  All non-IDLE phases
block callers on blocked_wq, preventing races with session teardown.

The drain phase flushes mdlog state, dirty caps, and pending cap
releases for a bounded interval.  State that still cannot make progress
within that interval is discarded during teardown, which is the point
of the reset: break the stalemate and allow fresh sessions to rebuild
clean state.

The session teardown follows the established check_new_map()
forced-close pattern: unregister sessions under mdsc->mutex, then clean
up caps and requests under s->s_mutex.  Reconnect is not attempted
because the MDS only accepts reconnects during its own RECONNECT phase
after restart, not from an active client.

Blocked callers are released when reset completes and observe the final
result.  The destroy path marks reset as failed and wakes blocked
waiters before cancel_work_sync() so unmount does not stall.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/locks.c      |  16 ++
 fs/ceph/mds_client.c | 421 +++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  42 +++++
 3 files changed, 479 insertions(+)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index c4ff2266bb94..677221bd64e0 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -249,6 +249,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u16 op = CEPH_MDS_OP_SETFILELOCK;
@@ -275,6 +276,13 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		return -EIO;
 	}
 
+	/* Wait for reset to complete before acquiring new locks */
+	if (op == CEPH_MDS_OP_SETFILELOCK && !lock_is_unlock(fl)) {
+		err = ceph_mdsc_wait_for_reset(mdsc);
+		if (err)
+			return err;
+	}
+
 	if (lock_is_read(fl))
 		lock_cmd = CEPH_LOCK_SHARED;
 	else if (lock_is_write(fl))
@@ -311,6 +319,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u8 wait = 0;
@@ -330,6 +339,13 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 		return -EIO;
 	}
 
+	/* Wait for reset to complete before acquiring new locks */
+	if (!lock_is_unlock(fl)) {
+		err = ceph_mdsc_wait_for_reset(mdsc);
+		if (err)
+			return err;
+	}
+
 	if (IS_SETLKW(cmd))
 		wait = 1;
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7d17332d72d7..7e399b0dcc55 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/delay.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
@@ -67,6 +68,7 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 			    struct list_head *head);
 static void ceph_cap_release_work(struct work_struct *work);
 static void ceph_cap_reclaim_work(struct work_struct *work);
+static void ceph_mdsc_reset_workfn(struct work_struct *work);
 
 static const struct ceph_connection_operations mds_con_ops;
 
@@ -3756,6 +3758,22 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	struct ceph_client *cl = mdsc->fsc->client;
 	int err = 0;
 
+	/*
+	 * If a reset is in progress, wait for it to complete.
+	 *
+	 * This is best-effort: a request can pass this check just
+	 * before the phase leaves IDLE and proceed concurrently with
+	 * reset.  That is acceptable because (a) such requests will
+	 * either complete normally or fail and be retried by the
+	 * caller, and (b) adding lock serialization here would
+	 * penalize every request for a rare manual operation.
+	 */
+	err = ceph_mdsc_wait_for_reset(mdsc);
+	if (err) {
+		doutc(cl, "wait_for_reset failed: %d\n", err);
+		return err;
+	}
+
 	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
 	if (req->r_inode)
 		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
@@ -5163,6 +5181,387 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 	return err;
 }
 
+const char *ceph_reset_phase_name(enum ceph_client_reset_phase phase)
+{
+	switch (phase) {
+	case CEPH_CLIENT_RESET_IDLE:	  return "idle";
+	case CEPH_CLIENT_RESET_QUIESCING: return "quiescing";
+	case CEPH_CLIENT_RESET_DRAINING:  return "draining";
+	case CEPH_CLIENT_RESET_TEARDOWN:  return "teardown";
+	default:			  return "unknown";
+	}
+}
+
+/*
+ * Wait for an active reset to complete.
+ * Returns 0 if reset completed successfully or no reset was active.
+ * Returns -ETIMEDOUT if we timed out waiting.
+ * Returns -ERESTARTSYS if interrupted by signal.
+ */
+int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_client *cl = mdsc->fsc->client;
+	unsigned long deadline = jiffies + CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
+	int blocked_count;
+	long wait_ret;
+	int ret;
+
+	if (READ_ONCE(st->phase) == CEPH_CLIENT_RESET_IDLE)
+		return 0;
+
+	blocked_count = atomic_inc_return(&st->blocked_requests);
+	doutc(cl, "request blocked during reset, %d total blocked\n",
+	      blocked_count);
+
+retry:
+	wait_ret = wait_event_interruptible_timeout(st->blocked_wq,
+						    READ_ONCE(st->phase) ==
+						     CEPH_CLIENT_RESET_IDLE,
+						    deadline - jiffies);
+
+	if (wait_ret == 0) {
+		atomic_dec(&st->blocked_requests);
+		pr_warn_client(cl, "timed out waiting for reset to complete\n");
+		return -ETIMEDOUT;
+	}
+	if (wait_ret < 0) {
+		atomic_dec(&st->blocked_requests);
+		return (int)wait_ret;  /* -ERESTARTSYS */
+	}
+
+	/*
+	 * Verify phase is still IDLE under the lock.  If another reset
+	 * was scheduled between the wake-up and this check, loop back
+	 * and wait for it to finish rather than returning a stale result.
+	 */
+	spin_lock(&st->lock);
+	if (st->phase != CEPH_CLIENT_RESET_IDLE) {
+		spin_unlock(&st->lock);
+		if (time_before(jiffies, deadline))
+			goto retry;
+		atomic_dec(&st->blocked_requests);
+		return -ETIMEDOUT;
+	}
+	ret = st->last_errno;
+	spin_unlock(&st->lock);
+
+	atomic_dec(&st->blocked_requests);
+	return ret;
+}
+
+static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+
+	spin_lock(&st->lock);
+	/*
+	 * If destroy already marked us as shut down, it owns the
+	 * final bookkeeping.  Just bail so we don't overwrite the
+	 * -ESHUTDOWN result that waiters already observed.
+	 */
+	if (st->shutdown) {
+		spin_unlock(&st->lock);
+		return;
+	}
+	st->last_finish = jiffies;
+	st->last_errno = ret;
+	st->phase = CEPH_CLIENT_RESET_IDLE;
+	if (ret)
+		st->failure_count++;
+	else
+		st->success_count++;
+	spin_unlock(&st->lock);
+
+	/* Wake up all requests that were blocked waiting for reset */
+	wake_up_all(&st->blocked_wq);
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
+	int max_sessions, i, n = 0, torn_down = 0;
+	int ret = 0;
+
+	spin_lock(&st->lock);
+	strscpy(reason, st->last_reason, sizeof(reason));
+	spin_unlock(&st->lock);
+
+	mutex_lock(&mdsc->mutex);
+	max_sessions = mdsc->max_sessions;
+	if (max_sessions <= 0) {
+		mutex_unlock(&mdsc->mutex);
+		goto out_complete;
+	}
+
+	sessions = kcalloc(max_sessions, sizeof(*sessions), GFP_KERNEL);
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
+		 * so loads are atomic; the teardown loop below
+		 * handles races with concurrent state transitions.
+		 */
+		switch (READ_ONCE(session->s_state)) {
+		case CEPH_MDS_SESSION_OPEN:
+		case CEPH_MDS_SESSION_HUNG:
+		case CEPH_MDS_SESSION_OPENING:
+		case CEPH_MDS_SESSION_RESTARTING:
+		case CEPH_MDS_SESSION_RECONNECTING:
+		case CEPH_MDS_SESSION_CLOSING:
+			sessions[n++] = ceph_get_mds_session(session);
+			break;
+		default:
+			pr_info_client(cl,
+				       "mds%d in state %s, skipping reset\n",
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
+	spin_lock(&st->lock);
+	st->phase = CEPH_CLIENT_RESET_DRAINING;
+	spin_unlock(&st->lock);
+
+	/*
+	 * Best-effort drain: flush dirty state while sessions are still
+	 * alive.  New requests are blocked while phase != IDLE.
+	 * The sessions are functional, so non-stuck state drains normally.
+	 * Stuck state (the cause of the stalemate the operator is trying
+	 * to break) will not drain - that is expected, and we proceed to
+	 * forced teardown after the timeout.
+	 *
+	 * Three things are drained:
+	 *  1. MDS journal - send_flush_mdlog asks each MDS to journal
+	 *     pending unsafe operations (creates, renames, setattrs).
+	 *     Once journaled, they survive the session teardown.
+	 *  2. Dirty caps - ceph_flush_dirty_caps triggers cap flush on
+	 *     all sessions.  Non-stuck caps flush in milliseconds.
+	 *  3. Cap releases - push pending cap release messages.
+	 *
+	 * All three happen concurrently during the bounded wait window.
+	 */
+	for (i = 0; i < n; i++)
+		send_flush_mdlog(sessions[i]);
+
+	ceph_flush_dirty_caps(mdsc);
+	ceph_flush_cap_releases(mdsc);
+
+	spin_lock(&mdsc->cap_dirty_lock);
+	if (!list_empty(&mdsc->cap_flush_list)) {
+		struct ceph_cap_flush *cf =
+			list_last_entry(&mdsc->cap_flush_list,
+					struct ceph_cap_flush, g_list);
+		u64 want_flush = mdsc->last_cap_flush_tid;
+		long drain_ret;
+
+		/*
+		 * Setting wake on the last entry is sufficient: flush
+		 * entries complete in order, so when this entry finishes
+		 * all earlier ones are already done.
+		 */
+		cf->wake = true;
+		spin_unlock(&mdsc->cap_dirty_lock);
+		pr_info_client(cl,
+			       "draining (want_flush=%llu, %d sessions)\n",
+			       want_flush, n);
+		drain_ret = wait_event_timeout(mdsc->cap_flushing_wq,
+					       check_caps_flush(mdsc,
+								want_flush),
+					       CEPH_CLIENT_RESET_DRAIN_SEC * HZ);
+		if (drain_ret == 0) {
+			pr_info_client(cl,
+				       "drain timed out, proceeding with forced teardown\n");
+			spin_lock(&st->lock);
+			st->drain_timed_out = true;
+			spin_unlock(&st->lock);
+		} else {
+			pr_info_client(cl, "drain completed successfully\n");
+			spin_lock(&st->lock);
+			st->drain_timed_out = false;
+			spin_unlock(&st->lock);
+		}
+	} else {
+		spin_unlock(&mdsc->cap_dirty_lock);
+		spin_lock(&st->lock);
+		st->drain_timed_out = false;
+		spin_unlock(&st->lock);
+	}
+
+	spin_lock(&st->lock);
+	st->phase = CEPH_CLIENT_RESET_TEARDOWN;
+	spin_unlock(&st->lock);
+
+	/*
+	 * Ask each MDS to close the session before we tear it down
+	 * locally.  Without this the MDS sees only a connection drop and
+	 * waits for the client to reconnect (up to session_autoclose
+	 * seconds) before evicting the session and releasing locks.
+	 *
+	 * Reuse the normal close machinery so the session state/sequence
+	 * snapshot is serialized under s_mutex and a racing s_seq bump
+	 * retransmits REQUEST_CLOSE while the session remains CLOSING.
+	 * We send all close requests first, then yield briefly to let the
+	 * network stack transmit them before __unregister_session()
+	 * closes the connections.
+	 */
+	for (i = 0; i < n; i++) {
+		int err;
+
+		mutex_lock(&sessions[i]->s_mutex);
+		err = __close_session(mdsc, sessions[i]);
+		mutex_unlock(&sessions[i]->s_mutex);
+		if (err < 0)
+			pr_warn_client(cl,
+				       "mds%d failed to queue close request before reset: %d\n",
+				       sessions[i]->s_mds, err);
+	}
+	if (n > 0)
+		msleep(CEPH_CLIENT_RESET_CLOSE_GRACE_MS);
+
+	/*
+	 * Tear down each session: close the connection, remove all
+	 * caps, clean up requests, then kick pending requests so they
+	 * re-open a fresh session on the next attempt.
+	 *
+	 * This is modeled on the check_new_map() forced-close path
+	 * for stopped MDS ranks - a proven pattern for hard session
+	 * teardown.  We do NOT attempt send_mds_reconnect() because
+	 * the MDS only accepts reconnects during its own RECONNECT
+	 * phase (after MDS restart), not from an active client.
+	 *
+	 * Any state that did not drain (caps that didn't flush, unsafe
+	 * requests that the MDS didn't journal) is force-dropped here.
+	 * This is intentional: that state is stuck and is the reason
+	 * the operator triggered the reset.
+	 */
+	for (i = 0; i < n; i++) {
+		int mds = sessions[i]->s_mds;
+
+		pr_info_client(cl, "mds%d resetting session\n", mds);
+
+		mutex_lock(&mdsc->mutex);
+		if (mds >= mdsc->max_sessions ||
+		    mdsc->sessions[mds] != sessions[i]) {
+			pr_info_client(cl,
+				       "mds%d session already torn down, skipping\n",
+				       mds);
+			mutex_unlock(&mdsc->mutex);
+			ceph_put_mds_session(sessions[i]);
+			continue;
+		}
+		sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
+		__unregister_session(mdsc, sessions[i]);
+		__wake_requests(mdsc, &sessions[i]->s_waiting);
+		mutex_unlock(&mdsc->mutex);
+
+		mutex_lock(&sessions[i]->s_mutex);
+		cleanup_session_requests(mdsc, sessions[i]);
+		remove_session_caps(sessions[i]);
+		mutex_unlock(&sessions[i]->s_mutex);
+
+		wake_up_all(&mdsc->session_close_wq);
+
+		ceph_put_mds_session(sessions[i]);
+
+		mutex_lock(&mdsc->mutex);
+		kick_requests(mdsc, mds);
+		mutex_unlock(&mdsc->mutex);
+
+		torn_down++;
+		pr_info_client(cl, "mds%d session reset complete\n", mds);
+	}
+
+	kfree(sessions);
+
+	spin_lock(&st->lock);
+	st->sessions_reset = torn_down;
+	spin_unlock(&st->lock);
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
+	if (st->phase != CEPH_CLIENT_RESET_IDLE) {
+		spin_unlock(&st->lock);
+		return -EBUSY;
+	}
+
+	st->phase = CEPH_CLIENT_RESET_QUIESCING;
+	st->last_start = jiffies;
+	st->last_errno = 0;
+	st->drain_timed_out = false;
+	st->sessions_reset = 0;
+	st->trigger_count++;
+	strscpy(st->last_reason, msg, sizeof(st->last_reason));
+	spin_unlock(&st->lock);
+
+	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
+		spin_lock(&st->lock);
+		st->phase = CEPH_CLIENT_RESET_IDLE;
+		st->last_errno = -EALREADY;
+		st->last_finish = jiffies;
+		st->failure_count++;
+		spin_unlock(&st->lock);
+		wake_up_all(&st->blocked_wq);
+		return -EALREADY;
+	}
+
+	pr_info_client(mdsc->fsc->client,
+		       "manual session reset scheduled (reason=\"%s\")\n",
+		       msg);
+	return 0;
+}
+
 
 /*
  * compare old and new mdsmaps, kicking requests
@@ -5702,6 +6101,11 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	INIT_LIST_HEAD(&mdsc->dentry_leases);
 	INIT_LIST_HEAD(&mdsc->dentry_dir_leases);
 
+	spin_lock_init(&mdsc->reset_state.lock);
+	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
+	atomic_set(&mdsc->reset_state.blocked_requests, 0);
+	INIT_WORK(&mdsc->reset_work, ceph_mdsc_reset_workfn);
+
 	ceph_caps_init(mdsc);
 	ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
 
@@ -6227,6 +6631,23 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	/* flush out any connection work with references to us */
 	ceph_msgr_flush();
 
+	/*
+	 * Mark reset as failed and wake any blocked waiters before
+	 * cancelling, so unmount doesn't stall on blocked_wq timeout
+	 * if cancel_work_sync() prevents the work from running.
+	 */
+	spin_lock(&mdsc->reset_state.lock);
+	mdsc->reset_state.shutdown = true;
+	if (mdsc->reset_state.phase != CEPH_CLIENT_RESET_IDLE) {
+		mdsc->reset_state.phase = CEPH_CLIENT_RESET_IDLE;
+		mdsc->reset_state.last_errno = -ESHUTDOWN;
+		mdsc->reset_state.last_finish = jiffies;
+		mdsc->reset_state.failure_count++;
+	}
+	spin_unlock(&mdsc->reset_state.lock);
+	wake_up_all(&mdsc->reset_state.blocked_wq);
+
+	cancel_work_sync(&mdsc->reset_work);
 	ceph_mdsc_stop(mdsc);
 
 	ceph_metric_destroy(&mdsc->metric);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index e91a199d56fd..afc08b0abbd5 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -74,6 +74,42 @@ struct ceph_fs_client;
 struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
+#define CEPH_CLIENT_RESET_REASON_LEN	64
+#define CEPH_CLIENT_RESET_DRAIN_SEC	5
+#define CEPH_CLIENT_RESET_CLOSE_GRACE_MS 100
+#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
+
+enum ceph_client_reset_phase {
+	CEPH_CLIENT_RESET_IDLE = 0,
+	/*
+	 * QUIESCING is set synchronously by schedule_reset() before the
+	 * workqueue item is dispatched.  It gates new requests (any
+	 * phase != IDLE blocks callers) during the window between
+	 * scheduling and the work function's transition to DRAINING.
+	 */
+	CEPH_CLIENT_RESET_QUIESCING,
+	CEPH_CLIENT_RESET_DRAINING,
+	CEPH_CLIENT_RESET_TEARDOWN,
+};
+
+struct ceph_client_reset_state {
+	spinlock_t lock;
+	u64 trigger_count;
+	u64 success_count;
+	u64 failure_count;
+	unsigned long last_start;
+	unsigned long last_finish;
+	int last_errno;
+	enum ceph_client_reset_phase phase;
+	bool drain_timed_out;
+	bool shutdown;
+	int sessions_reset;
+	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
+
+	/* Request blocking during reset */
+	wait_queue_head_t blocked_wq;
+	atomic_t blocked_requests;
+};
 
 struct ceph_mds_cap_match {
 	s64 uid;  /* default to MDS_AUTH_UID_ANY */
@@ -536,6 +572,8 @@ struct ceph_mds_client {
 	struct list_head  dentry_dir_leases; /* lru list */
 
 	struct ceph_client_metric metric;
+	struct work_struct	reset_work;
+	struct ceph_client_reset_state reset_state;
 
 	spinlock_t		snapid_map_lock;
 	struct rb_root		snapid_map_tree;
@@ -559,10 +597,14 @@ extern struct ceph_mds_session *
 __ceph_lookup_mds_session(struct ceph_mds_client *, int mds);
 
 extern const char *ceph_session_state_name(int s);
+extern const char *ceph_reset_phase_name(enum ceph_client_reset_phase phase);
 
 extern struct ceph_mds_session *
 ceph_get_mds_session(struct ceph_mds_session *s);
 extern void ceph_put_mds_session(struct ceph_mds_session *s);
+int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
+			     const char *reason);
+int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
 
 extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
 extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
-- 
2.34.1

