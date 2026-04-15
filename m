Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F783E7169
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272524; cv=none; b=e4s07A3aWUhRNFqy58Z2x+2rXrUvQzAopnpbRaALpTJL2CjDIj+L/2gBJKgeIZcQYqKTyMwbfkuJYLffD940WrLD5NWVvtcH/QtKdyiuDvwKtrit5nZ4eOeKL1TQ+5VXzK3bBlcJklOoakYTDSDvdu6tPIIWem6p+FzQvfah2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272524; c=relaxed/simple;
	bh=hF8GPPMCTtYMk3vi8Lxz1SJG7tR0daTJyKi+xKmaWuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rT7yROcyfqBx+V6zhRqCzk2XgayfazHQDX6ivvTaekeu7f/faBrpZdtYCl+M2zRXdKD077j/IFGWoWJebTuB/SW9Wye6Uo4juKM45Tfq7qO1CbZn4g3JiPpwYp+S39swoqifX5ZsGUDNnEduDMysCuCxSpofJeJdY6jJq4cdXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TetAIqfm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ime2V8gK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TetAIqfm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ime2V8gK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//5vy/hAvLLk2tz3ORfdr9CS0acwofxbtDJCElDQmN4=;
	b=TetAIqfmfoHxtm8TmBsHZpbjovZ0wjRvOLtbjDkM//efHWRtTgBaGkwF87ZQbuCZw6ybFQ
	Q+nYPq19N8faBuBJ/qwChiKSpyMJXC2EHCkMwpjAZNIf7CNCtPNW2REo+tVTT7d4DyLvpq
	6g7sS977WloND8O4wQ/ILbKICtBmd5M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-wNpd8xj6MtSKjXBxy4bwow-1; Wed, 15 Apr 2026 13:01:59 -0400
X-MC-Unique: wNpd8xj6MtSKjXBxy4bwow-1
X-Mimecast-MFC-AGG-ID: wNpd8xj6MtSKjXBxy4bwow_1776272518
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d8e4c29caso177097381cf.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272518; x=1776877318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//5vy/hAvLLk2tz3ORfdr9CS0acwofxbtDJCElDQmN4=;
        b=Ime2V8gK41n2xGYjzI8S+D+yKLBHbPvlmIso6HMlPBVU4aoWPMOkl4vd5NdgjGUvsN
         CweeBrbh0Y7yplsJG9pLbbZiZvePkc9eYrE8dIb8JwSqRYneCsFnEj84DV10dat7pYAL
         pijOgwdbf4P1xge3ObxwWiiOeiS5fwQt6UHF3cTNhBxvBXDkvzXMVr1juZttRSFfWzPu
         OcrUZip+tWQbNiPdnQqMtFG+bAhP15zeIVzLrTJczBVrNJqouiayPqbb7bY+8ZtVFVSK
         YGhzKdF/HucwCepFyrbkU8q9N1QsRDionnUSt6mY9WJkjwdskVE53r164QrARUcjxyFZ
         W0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272518; x=1776877318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=//5vy/hAvLLk2tz3ORfdr9CS0acwofxbtDJCElDQmN4=;
        b=Ev+h+XVVAPpjLrYwHHAarPnL4Yr0ld1e2U2Df/BdhC61mHQClNAx2HY83aHAa5mLZa
         aO3EDZlbDoHF3hNHlr4QyW9qqUdytpnDTa0LzKHVrN+vthXd2U7BxScI0n77K1xvw9Kx
         bYZRH7HViEi1eEvAdValrw0r7V3Rqw1p/I3BBds6SZ7h5h/2kwaUAsYvxJTpjYaoZb/+
         UDSMz4DpTRSBBmuJo/eikO68YUl0B4tx2EpWKvfN4KJU7PB/wW6/+MOZxb7zz+pd6b6x
         WXy4H+vUGiwkyOsFx938PM4zweodo7gsYCLgPup6iJJ2aECoD8CtZEikQYgra+aOsH/U
         su7g==
X-Gm-Message-State: AOJu0Yx80nIs19ujNAoyTo5i9baLJ9z9bqSXfohZCurcS+EA6TY9Gpdu
	jqEMAvbNYSJsOPzdxwaD0k+v6LpEYkKQYRJX5/NuN7VuAYk0aJ5xwLAD3c+B4E1m1pBv8OHxso7
	U/iEmUE/PfYVxVEZNHjdTA7BE1Go5ceDzirH8Bfr+5DdnK2mEbJk7DWWD1ZsuRSdJqX89yC12zy
	nCuSNkxVcQW6x6Wahnx+cOxvnG/gGumS46LNzy+pb4fnSNQDmAgg==
X-Gm-Gg: AeBDies1oDrhFkXjPeW1tmSU3y8TeinLRg7gFbRfv4etQa+hQ83PQCnTAEiOP8efA07
	hwRIaVW6f7HfcAdW3eTB43u3Zsb4AD3sEeId1qpAt3X5xBmxsYrB51Oc8OUJesJaccIHZKrEEWQ
	4JE7LMbBl7ylMx9uH8ckT4qb/hEGUSbiHvTa+8K628el0+jJurUvZyItjeJA0mgtasD6/DpuwkH
	zFWNjRta5ZqLZpeQgussaxerl5AAArgtox9bacrdVDc9m3altsnTAzT5yVJ4rLNluV5kNSxTWMj
	9Yfg6/tbr6faZ+BIwJwG06NlJGPMlehzdTjhnvhcy1NFHiHTSP+shXH4rTBHAkWE64qWIqwd5DL
	wZ4jopioxlte38Txnq6cUtsfp+NHZ8t2lKB8OSlaWTtYvoXNQk/bNfJCfhBhMCgn3bA==
X-Received: by 2002:a05:622a:9:b0:50d:7b0c:35de with SMTP id d75a77b69052e-50dd5c74756mr343039461cf.44.1776272514515;
        Wed, 15 Apr 2026 10:01:54 -0700 (PDT)
X-Received: by 2002:a05:622a:9:b0:50d:7b0c:35de with SMTP id d75a77b69052e-50dd5c74756mr343006191cf.44.1776272475636;
        Wed, 15 Apr 2026 10:01:15 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:01:15 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 6/7] ceph: add manual reset debugfs control and tracepoints
Date: Wed, 15 Apr 2026 17:00:42 +0000
Message-Id: <20260415170043.3882912-7-amarkuze@redhat.com>
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

Add the debugfs and trace plumbing used to trigger and observe
manual client reset.

The reset interface exposes a trigger file for operator-initiated
reset and a status file for tracking the most recent run.  The
tracepoints record scheduling, completion, and blocked caller
behavior so reset progress can be diagnosed from the client side.

debugfs layout under /sys/kernel/debug/ceph/<client>/reset/:
  trigger - write to initiate a manual reset
  status  - read to see the most recent reset result

Tracepoints:
  ceph_client_reset_schedule  - reset queued
  ceph_client_reset_complete  - reset finished (success or failure)
  ceph_client_reset_blocked   - caller blocked waiting for reset
  ceph_client_reset_unblocked - caller unblocked after reset

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/debugfs.c           | 104 ++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.c        |   8 +++
 fs/ceph/super.h             |   3 ++
 include/trace/events/ceph.h |  63 ++++++++++++++++++++++
 4 files changed, 178 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 7dc307790240..d46d41ec7a86 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -9,6 +9,7 @@
 #include <linux/seq_file.h>
 #include <linux/math64.h>
 #include <linux/ktime.h>
+#include <linux/uaccess.h>
 
 #include <linux/ceph/libceph.h>
 #include <linux/ceph/mon_client.h>
@@ -360,16 +361,107 @@ static int status_show(struct seq_file *s, void *p)
 	return 0;
 }
 
+static int reset_status_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_client_reset_state *st;
+	u64 trigger = 0, success = 0, failure = 0;
+	unsigned long last_start = 0, last_finish = 0;
+	int last_errno = 0;
+	enum ceph_client_reset_phase phase = CEPH_CLIENT_RESET_IDLE;
+	bool drain_timed_out = false;
+	int sessions_reset = 0;
+	int blocked_requests = 0;
+	char reason[CEPH_CLIENT_RESET_REASON_LEN];
+
+	if (!mdsc)
+		return 0;
+
+	st = &mdsc->reset_state;
+
+	spin_lock(&st->lock);
+	trigger = st->trigger_count;
+	success = st->success_count;
+	failure = st->failure_count;
+	last_start = st->last_start;
+	last_finish = st->last_finish;
+	last_errno = st->last_errno;
+	phase = st->phase;
+	drain_timed_out = st->drain_timed_out;
+	sessions_reset = st->sessions_reset;
+	strscpy(reason, st->last_reason, sizeof(reason));
+	spin_unlock(&st->lock);
+
+	blocked_requests = atomic_read(&st->blocked_requests);
+
+	seq_printf(s, "phase: %s\n", ceph_reset_phase_name(phase));
+	seq_printf(s, "trigger_count: %llu\n", trigger);
+	seq_printf(s, "success_count: %llu\n", success);
+	seq_printf(s, "failure_count: %llu\n", failure);
+	if (last_start)
+		seq_printf(s, "last_start_ms_ago: %u\n",
+			   jiffies_to_msecs(jiffies - last_start));
+	else
+		seq_puts(s, "last_start_ms_ago: (never)\n");
+	if (last_finish)
+		seq_printf(s, "last_finish_ms_ago: %u\n",
+			   jiffies_to_msecs(jiffies - last_finish));
+	else
+		seq_puts(s, "last_finish_ms_ago: (never)\n");
+	seq_printf(s, "last_errno: %d\n", last_errno);
+	seq_printf(s, "last_reason: %s\n",
+		   reason[0] ? reason : "(none)");
+	seq_printf(s, "drain_timed_out: %s\n",
+		   drain_timed_out ? "yes" : "no");
+	seq_printf(s, "sessions_reset: %d\n", sessions_reset);
+	seq_printf(s, "blocked_requests: %d\n", blocked_requests);
+
+	return 0;
+}
+
+static ssize_t reset_trigger_write(struct file *file, const char __user *buf,
+				   size_t len, loff_t *ppos)
+{
+	struct ceph_fs_client *fsc = file->private_data;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	char reason[CEPH_CLIENT_RESET_REASON_LEN];
+	size_t copy;
+	int ret;
+
+	if (!mdsc)
+		return -ENODEV;
+
+	copy = min_t(size_t, len, sizeof(reason) - 1);
+	if (copy && copy_from_user(reason, buf, copy))
+		return -EFAULT;
+	reason[copy] = '\0';
+	strim(reason);
+
+	ret = ceph_mdsc_schedule_reset(mdsc, reason);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
 DEFINE_SHOW_ATTRIBUTE(mdsmap);
 DEFINE_SHOW_ATTRIBUTE(mdsc);
 DEFINE_SHOW_ATTRIBUTE(caps);
 DEFINE_SHOW_ATTRIBUTE(mds_sessions);
 DEFINE_SHOW_ATTRIBUTE(status);
+DEFINE_SHOW_ATTRIBUTE(reset_status);
 DEFINE_SHOW_ATTRIBUTE(metrics_file);
 DEFINE_SHOW_ATTRIBUTE(metrics_latency);
 DEFINE_SHOW_ATTRIBUTE(metrics_size);
 DEFINE_SHOW_ATTRIBUTE(metrics_caps);
 
+static const struct file_operations ceph_reset_trigger_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = reset_trigger_write,
+	.llseek = noop_llseek,
+};
 
 /*
  * debugfs
@@ -404,6 +496,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove(fsc->debugfs_caps);
 	debugfs_remove(fsc->debugfs_status);
 	debugfs_remove(fsc->debugfs_mdsc);
+	debugfs_remove_recursive(fsc->debugfs_reset_dir);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
 	doutc(fsc->client, "done\n");
 }
@@ -451,6 +544,17 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 						fsc,
 						&caps_fops);
 
+	fsc->debugfs_reset_dir = debugfs_create_dir("reset",
+						    fsc->client->debugfs_dir);
+	fsc->debugfs_reset_trigger =
+		debugfs_create_file("trigger", 0200,
+				    fsc->debugfs_reset_dir, fsc,
+				    &ceph_reset_trigger_fops);
+	fsc->debugfs_reset_status =
+		debugfs_create_file("status", 0400,
+				    fsc->debugfs_reset_dir, fsc,
+				    &reset_status_fops);
+
 	fsc->debugfs_status = debugfs_create_file("status",
 						  0400,
 						  fsc->client->debugfs_dir,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7e399b0dcc55..98a882cf8b65 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5213,6 +5213,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 	blocked_count = atomic_inc_return(&st->blocked_requests);
 	doutc(cl, "request blocked during reset, %d total blocked\n",
 	      blocked_count);
+	trace_ceph_client_reset_blocked(mdsc, blocked_count);
 
 retry:
 	wait_ret = wait_event_interruptible_timeout(st->blocked_wq,
@@ -5223,10 +5224,12 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 	if (wait_ret == 0) {
 		atomic_dec(&st->blocked_requests);
 		pr_warn_client(cl, "timed out waiting for reset to complete\n");
+		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
 		return -ETIMEDOUT;
 	}
 	if (wait_ret < 0) {
 		atomic_dec(&st->blocked_requests);
+		trace_ceph_client_reset_unblocked(mdsc, (int)wait_ret);
 		return (int)wait_ret;  /* -ERESTARTSYS */
 	}
 
@@ -5241,12 +5244,14 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 		if (time_before(jiffies, deadline))
 			goto retry;
 		atomic_dec(&st->blocked_requests);
+		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
 		return -ETIMEDOUT;
 	}
 	ret = st->last_errno;
 	spin_unlock(&st->lock);
 
 	atomic_dec(&st->blocked_requests);
+	trace_ceph_client_reset_unblocked(mdsc, ret);
 	return ret;
 }
 
@@ -5275,6 +5280,8 @@ static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
 
 	/* Wake up all requests that were blocked waiting for reset */
 	wake_up_all(&st->blocked_wq);
+
+	trace_ceph_client_reset_complete(mdsc, ret);
 }
 
 static void ceph_mdsc_reset_workfn(struct work_struct *work)
@@ -5559,6 +5566,7 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
 	pr_info_client(mdsc->fsc->client,
 		       "manual session reset scheduled (reason=\"%s\")\n",
 		       msg);
+	trace_ceph_client_reset_schedule(mdsc, msg);
 	return 0;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1f901b1647e6..98af0a823c81 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -179,6 +179,9 @@ struct ceph_fs_client {
 	struct dentry *debugfs_status;
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
+	struct dentry *debugfs_reset_dir;
+	struct dentry *debugfs_reset_trigger;
+	struct dentry *debugfs_reset_status;
 #endif
 
 #ifdef CONFIG_CEPH_FSCACHE
diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
index 08cb0659fbfc..e853c891ef71 100644
--- a/include/trace/events/ceph.h
+++ b/include/trace/events/ceph.h
@@ -226,6 +226,69 @@ TRACE_EVENT(ceph_handle_caps,
 		  __entry->mseq)
 );
 
+/*
+ * Client reset tracepoints - identify the client by its monitor-
+ * assigned global_id so traces remain meaningful when kernel pointer
+ * hashing is enabled.
+ */
+TRACE_EVENT(ceph_client_reset_schedule,
+	TP_PROTO(const struct ceph_mds_client *mdsc, const char *reason),
+	TP_ARGS(mdsc, reason),
+	TP_STRUCT__entry(
+		__field(u64, client_id)
+		__string(reason, reason ? reason : "")
+	),
+	TP_fast_assign(
+		__entry->client_id = mdsc->fsc->client->monc.auth->global_id;
+		__assign_str(reason);
+	),
+	TP_printk("client_id=%llu reason=%s",
+		  __entry->client_id, __get_str(reason))
+);
+
+TRACE_EVENT(ceph_client_reset_complete,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
+	TP_ARGS(mdsc, ret),
+	TP_STRUCT__entry(
+		__field(u64, client_id)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__entry->client_id = mdsc->fsc->client->monc.auth->global_id;
+		__entry->ret = ret;
+	),
+	TP_printk("client_id=%llu ret=%d", __entry->client_id, __entry->ret)
+);
+
+TRACE_EVENT(ceph_client_reset_blocked,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int blocked_count),
+	TP_ARGS(mdsc, blocked_count),
+	TP_STRUCT__entry(
+		__field(u64, client_id)
+		__field(int, blocked_count)
+	),
+	TP_fast_assign(
+		__entry->client_id = mdsc->fsc->client->monc.auth->global_id;
+		__entry->blocked_count = blocked_count;
+	),
+	TP_printk("client_id=%llu blocked_count=%d", __entry->client_id,
+		  __entry->blocked_count)
+);
+
+TRACE_EVENT(ceph_client_reset_unblocked,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
+	TP_ARGS(mdsc, ret),
+	TP_STRUCT__entry(
+		__field(u64, client_id)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__entry->client_id = mdsc->fsc->client->monc.auth->global_id;
+		__entry->ret = ret;
+	),
+	TP_printk("client_id=%llu ret=%d", __entry->client_id, __entry->ret)
+);
+
 #undef EM
 #undef E_
 #endif /* _TRACE_CEPH_H */
-- 
2.34.1

