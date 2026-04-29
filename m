Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAE3FE657
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467154; cv=none; b=ZBz9SxX22RwAniu4S2PG2m8/gXCawb/+AbY9Nf4aaRZntS5s038xQ1TCYCjzJ3AMSB/ZJ551fhBrATfJVB1TFsxFESaDi1FqLb+xmQpYZozYQKNgEOF2oFu1zjAah5XbAWe9V+nW/XSD+dgYX17iplISsQ9GdzsHhD4I3qzmcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467154; c=relaxed/simple;
	bh=+BN8CG8/6Huyk/ldf4iRS8CZs2L9Jd4Vqs8JTyQYUc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgViA3aYu4BiWrFA8v/6gymH9jip+KVeJiJrLKZ5FdaDc+8OAxx9/6Myp1mWV9uqTCI1rjoEmzn9xyBuCzhkxTsO8/z7MiISWLjZMfEqBoH2WitTFabVaazgQYRPQ+zb5kGlUMaeBz1kpB6rNchduq4TCjcfM9qrcwzLuYheLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE+EXqgb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pRCxMVEl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE+EXqgb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pRCxMVEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGujJ4ac8Vzv3QrLWGifn3d8agUct8OsMz9/77yTtWw=;
	b=FE+EXqgbTH2/TjUg8WKQo+xPyvxPfg3606kl2/n8AR/Gxx6LpRs1U92PXU1I9kiLljTUyq
	WDZHPJF+Q+jrGJxPjtNwkud8aMI3wO4PvCZ2GV2fWemcxX08lffXOUmjsAE0gv8wb2N273
	Ys44Rdg8QPo/hHtdSTIcL8X47ZQXsxM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-GUqOwTrXPne9CQEc9jOo1g-1; Wed, 29 Apr 2026 08:52:28 -0400
X-MC-Unique: GUqOwTrXPne9CQEc9jOo1g-1
X-Mimecast-MFC-AGG-ID: GUqOwTrXPne9CQEc9jOo1g_1777467147
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-66c1806dd5fso11200766a12.3
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467147; x=1778071947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGujJ4ac8Vzv3QrLWGifn3d8agUct8OsMz9/77yTtWw=;
        b=pRCxMVElkt1D2HjWD+tMCWsSp7gVa6h+FI8xgHAB9zcHiw86uSG7TG//SeKYV1QPd5
         ezwqz8qTkJPPGN4XBYV2qC67ZlsqesE1gjeNMcBdatJUJbP/uGzJnc3RrxLat32gnqmt
         0uFHzYLSv8fuEDhIGHkJkstAR3HSIMAjKcdJR3negS8gKkvlHBRjNJchU7qGAhKAnRc6
         6Ncfmr2jGZClGLHOgfhIm1zs4x6tnUPNdoxNUAdLmE4RcyLt0Kv9coStVZwPr2Xt96xK
         OXY88bqceKfG68sv3dy8dS9SJeeAXPFjHFncqP8QH4v48wi3XRnJuqIgX4pPPdEg4JPU
         qOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467147; x=1778071947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGujJ4ac8Vzv3QrLWGifn3d8agUct8OsMz9/77yTtWw=;
        b=eevX65PptNsIAeHoSX99PDucilWfNxwFNyagb4I6Ocsrkzo5qcqgM1wyck9U4D2a0P
         VYifjNPiqH2GLqv/aD/62fk7g7X4giLn0f0dCNKq9/AxABp0oooDoq09eufdhULOqPfZ
         RCRWWrNdS3sxKlrcT3doK1XiCc5d55EHS3foWmfxE1dDc3M0A2M9wsUk7cJVgokuB3Vv
         dMkkJiKqJk7CZV6bqBXE8AjQHNe3ZTrVZO1FUE9kVLYreZOKUOVus3st1uCZKloM6DyN
         N65xPMN1NKhNOAtdBib4Ef5120g9j22uhRZLZHhyV1xQyqtaWfkROG5pc3zLbeFE8ZI4
         JAzQ==
X-Gm-Message-State: AOJu0YyjBXQ4hw1FYy5YedJYvP+mDc5mT5+A0xR1gpImPDU/UUkbXxPR
	JQFgnNHk1p7YshmwzWEMuz0DEt5GLSQRRKq8ae/Gw/6LSYvWijmq+EMQEwGq2ufNX0GIAsLw2cK
	rshQob8GE8K+CuP/+QkmvAi5dcmmC26TmsM4OdwvlD4AxhTRkuHg9L+MkqdzhP24LOJHWx8zDcJ
	aTIzNch12TrjzhhqFp7VLj9ywfT88UxPZARZtBUSyLGq7GITzfyQ==
X-Gm-Gg: AeBDiev6jyVaRN/zc+a5LrGpeO3yE77ULPP2LPKV+cIDKB2uwtLgbu5eD79BsY/FllG
	ryXcmSrPBqhAAJVwbhdIeiJRQ1aBVuJfHUfvFKoAassarc8zHUW5BDCxAQzAe/LX27y41+fIxse
	Obb2SF8jsOLeDTAo1EAdaTXC2RPEx6eNmCDPKfYBGVT3hNftqmcAyPxQ8nTHbBziOdUzKrttI8x
	7Fowi8VvV3vHHTgMuuGxrVp66+4TRb2z6i/9+cZazrQr5g8u3G5UducLY6UDcIE2JyZidGRIxDT
	whZlsPxXoYrwg6qY6Y+MrWtBVYxmcUfWHCwLJ2bglFxvmYs5u/FhexeyGFvWPPp5ZFIHOClFrI9
	mLQoz6uBkeRMkIZfCmMZM2yWu0iZhdVAM2B61ACDGUzf7dPN287ZpZ+/M/0vB+sbWIA==
X-Received: by 2002:a05:6402:2b98:b0:66e:4372:7518 with SMTP id 4fb4d7f45d1cf-679bb04e627mr4030796a12.2.1777467146835;
        Wed, 29 Apr 2026 05:52:26 -0700 (PDT)
X-Received: by 2002:a05:6402:2b98:b0:66e:4372:7518 with SMTP id 4fb4d7f45d1cf-679bb04e627mr4030752a12.2.1777467146035;
        Wed, 29 Apr 2026 05:52:26 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:25 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 06/11] ceph: add manual reset debugfs control and tracepoints
Date: Wed, 29 Apr 2026 12:52:01 +0000
Message-Id: <20260429125206.1512203-7-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429125206.1512203-1-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
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

The reset directory is cleaned up via debugfs_remove_recursive()
on the parent, so individual file dentries are not stored.

Tracepoints:
  ceph_client_reset_schedule  - reset queued
  ceph_client_reset_complete  - reset finished (success or failure)
  ceph_client_reset_blocked   - caller blocked waiting for reset
  ceph_client_reset_unblocked - caller unblocked after reset

All tracepoints use a null-safe access for monc.auth->global_id
to guard against early-init or late-teardown edge cases.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/debugfs.c           | 102 ++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.c        |   8 +++
 fs/ceph/super.h             |   1 +
 include/trace/events/ceph.h |  67 +++++++++++++++++++++++
 4 files changed, 178 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 7dc307790240..beee4cfe8b18 100644
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
@@ -451,6 +544,15 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 						fsc,
 						&caps_fops);
 
+	fsc->debugfs_reset_dir = debugfs_create_dir("reset",
+						    fsc->client->debugfs_dir);
+	debugfs_create_file("trigger", 0200,
+			    fsc->debugfs_reset_dir, fsc,
+			    &ceph_reset_trigger_fops);
+	debugfs_create_file("status", 0400,
+			    fsc->debugfs_reset_dir, fsc,
+			    &reset_status_fops);
+
 	fsc->debugfs_status = debugfs_create_file("status",
 						  0400,
 						  fsc->client->debugfs_dir,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 777af51ec8d8..8339c2c72f9a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5261,6 +5261,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 	blocked_count = atomic_inc_return(&st->blocked_requests);
 	doutc(cl, "request blocked during reset, %d total blocked\n",
 	      blocked_count);
+	trace_ceph_client_reset_blocked(mdsc, blocked_count);
 
 retry:
 	remaining = max_t(long, deadline - jiffies, 1);
@@ -5272,10 +5273,12 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
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
 
@@ -5290,12 +5293,14 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
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
 	return ret ? -EIO : 0;
 }
 
@@ -5324,6 +5329,8 @@ static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
 
 	/* Wake up all requests that were blocked waiting for reset */
 	wake_up_all(&st->blocked_wq);
+
+	trace_ceph_client_reset_complete(mdsc, ret);
 }
 
 static void ceph_mdsc_reset_workfn(struct work_struct *work)
@@ -5633,6 +5640,7 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
 	pr_info_client(mdsc->fsc->client,
 		       "manual session reset scheduled (reason=\"%s\")\n",
 		       msg);
+	trace_ceph_client_reset_schedule(mdsc, msg);
 	return 0;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9aca42c89ea0..5bf976b6c4fe 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -179,6 +179,7 @@ struct ceph_fs_client {
 	struct dentry *debugfs_status;
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
+	struct dentry *debugfs_reset_dir;
 #endif
 
 #ifdef CONFIG_CEPH_FSCACHE
diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
index 08cb0659fbfc..1b990632f62b 100644
--- a/include/trace/events/ceph.h
+++ b/include/trace/events/ceph.h
@@ -226,6 +226,73 @@ TRACE_EVENT(ceph_handle_caps,
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
+		__entry->client_id = mdsc->fsc->client->monc.auth ?
+			mdsc->fsc->client->monc.auth->global_id : 0;
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
+		__entry->client_id = mdsc->fsc->client->monc.auth ?
+			mdsc->fsc->client->monc.auth->global_id : 0;
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
+		__entry->client_id = mdsc->fsc->client->monc.auth ?
+			mdsc->fsc->client->monc.auth->global_id : 0;
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
+		__entry->client_id = mdsc->fsc->client->monc.auth ?
+			mdsc->fsc->client->monc.auth->global_id : 0;
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

