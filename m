Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2333C65F2
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156879; cv=none; b=KzZf9zKaY2lufxcXH3l7WWGuVc0RJGrYhJbQr5woafSsjfeBp9bKPtKhXsjjsuz0ZnIa9nay0449zqfCnwjmfcR5hzzHWi91HVFAGwBsnCQC5riUXkJjmaRDZhQWbzHxx6EbLCUgZcTYgCbNCSQ4aZCnf1usdRXFOu6XR+9n5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156879; c=relaxed/simple;
	bh=mry7fPSwDpLlrYEx/LJ8bD4menn0NAgWZBGmTokNjUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJk1fMGquuxRMipiK9TNO2NLaBLERdvLk2WfQXKCAP3xpH93iXwNysJr47uvRh7qQhv2VLHvl8Wn/MQMm/MVunwb42bBprlBJfobP+Yv//1zwCleqx8eN0tak/7heoBcJQV8XYhBJEe5eCdkoaOL0tfrHjLMbLAEz0ShAQPNF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKZ1UOW/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KR8f4Wbk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKZ1UOW/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KR8f4Wbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdw4QjJQwh9CCkmForNjrUpru0aKscBcQPvRnVkBnYU=;
	b=EKZ1UOW/Vr0BjL4W+1QFIAY9LLfThCZ0sffKlJj9nM2YdwVcNbQfBb7dQhVVVGaj+GIph3
	ZPo5OcToofIBRwJGIv3paIMV53ITIbWaK+yqfeLDCBKtlZ6RMJ+bbZb6bi5H4MHmAEWqP4
	2+77Hhyeat47vjEt6zEDZz1rkuO/K5Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-VjbCYtifMJW6DtngHcZKaQ-1; Thu, 07 May 2026 08:27:55 -0400
X-MC-Unique: VjbCYtifMJW6DtngHcZKaQ-1
X-Mimecast-MFC-AGG-ID: VjbCYtifMJW6DtngHcZKaQ_1778156874
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b92323d85efso96372166b.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156874; x=1778761674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdw4QjJQwh9CCkmForNjrUpru0aKscBcQPvRnVkBnYU=;
        b=KR8f4WbkolA/9qs/iHwPwLbz6XOM2goOxxzriJTzJxdw84mFbkTLzej0xO55syNpAu
         ioK2bDR1Y306AWDlbfUy7k9IRoNrXo4DqF8+zg0FNBWxaYiUrPjsTcelDTKW4VrTg1P/
         j+uun6lLXqfmUvHvlzQ3pbhunZr4eBNMMDIsM8EMYakpsbYwcN/0GLI2zmQw6Xd5b3G0
         6FufYaqz5X22Y6YBfHRHogv/sY7SSmiK2rqsDbQQMPxG12Gz77ETnrS/dibaWqnbDPkl
         6ZRK6lTb19fEeGH2Z7LzbXP8IKw6lrGiEMgGkvZxeBUG6S1XiScShV72jwCvSEU3MPa1
         AQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156874; x=1778761674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdw4QjJQwh9CCkmForNjrUpru0aKscBcQPvRnVkBnYU=;
        b=DZ/Qf1IC6GG2Xde2EpYbpXWRcPYpu4ShHnuMojamDrwS5Gx9XEzUfdf3vhNeKruBHw
         fcWlXd7sfger7f3cW1eXIheXW2K9R7CofRSdT5wexmrduaKE2AwrnLJykrp67QM0N1Gq
         x1GvP58tz6FNUTULYzUUrS+Kzt0w8R5rYTQPEGz+Z1ms3SzCS9Bjtnyf9uFb7dugndvM
         hVrQxgTr8V4LaYBz+MCkt73Qlc+FMWaCfPAbdislnMIkH8NuL5DL5HKuovpnAPvuFzkv
         QPDS+P7UF3k7BeBXYH2M/1Bal9r8axfySQBqfPaMtw88pgC2B8KNi5Uz+j1HD/huozYA
         TBPA==
X-Gm-Message-State: AOJu0YxIQsC3lUIJAFB8E2NVR+ibMGLP9+yAtQednRD6IMDlptTfhtoC
	Wyiq/0Dqtgc7+GzlGyd7iw9NDMc6GzQxLqzJIuq60GcVZepLvRMSwuog+M/eOhvHdMMQmg4AN6S
	tuFCzLlqKS6+s5qI309CIlFGrsSuWG4lyM1a0cxS2rjX24tTfgZTmM7dh+ngT5UgfJ34zQdkJLD
	daaz+ykhQRbt5YjKar2hShvjFhBg5iuXWvO4n603rCpxZ/umC3Ug==
X-Gm-Gg: AeBDieuUiv61DAeLVkZlIDZtIu1OY/0hfx0/43newSAq8ifec2xfL95t5ELCjmJiX2L
	51kI6/UVrnIsj+RMjba+5dFV65n017mTBB8EPExiNd62KBE68gEzAbU6iQLrfP+sRG/tsk/+iyH
	TXUliFBEpMMt0XTAE4ByS9iP8JR77YxTfl19Y3MsarjyhrneTgxSWcnbzswbqVlFX349zp65cIz
	xVAakbxbDgoN7noDeQFAJEiMOIGa+gEapj485uAhzaNsuiQAa269bNoWVXKn6ExgHfUWpHJegiZ
	+6JFmj8ebkL6tFC55NYFqTVMZM2dDBKZrk2kf5KcuKCLfhZl1nJu8JAmAipUZ4wSMY4ujMxN7Tm
	RaOxlH9iSLe6oSTZpUAp5sxThESgU2XOf8kLMlf8JRepWdqk6p6WPFFxq20+1exMWRA==
X-Received: by 2002:a17:907:d114:b0:bc6:3181:7711 with SMTP id a640c23a62f3a-bc6318178ddmr382207566b.35.1778156873541;
        Thu, 07 May 2026 05:27:53 -0700 (PDT)
X-Received: by 2002:a17:907:d114:b0:bc6:3181:7711 with SMTP id a640c23a62f3a-bc6318178ddmr382202966b.35.1778156872910;
        Thu, 07 May 2026 05:27:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:52 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 06/11] ceph: add manual reset debugfs control and tracepoints
Date: Thu,  7 May 2026 12:27:32 +0000
Message-Id: <20260507122737.2804094-7-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507122737.2804094-1-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
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
 fs/ceph/debugfs.c           | 103 ++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.c        |   7 +++
 fs/ceph/super.h             |   1 +
 include/trace/events/ceph.h |  67 +++++++++++++++++++++++
 4 files changed, 178 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index e2463f93cf6b..18eb5da03411 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -9,6 +9,7 @@
 #include <linux/seq_file.h>
 #include <linux/math64.h>
 #include <linux/ktime.h>
+#include <linux/uaccess.h>
 #include <linux/atomic.h>
 
 #include <linux/ceph/libceph.h>
@@ -392,6 +393,90 @@ static int status_show(struct seq_file *s, void *p)
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
 static int subvolume_metrics_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
@@ -450,6 +535,7 @@ DEFINE_SHOW_ATTRIBUTE(mdsc);
 DEFINE_SHOW_ATTRIBUTE(caps);
 DEFINE_SHOW_ATTRIBUTE(mds_sessions);
 DEFINE_SHOW_ATTRIBUTE(status);
+DEFINE_SHOW_ATTRIBUTE(reset_status);
 DEFINE_SHOW_ATTRIBUTE(metrics_file);
 DEFINE_SHOW_ATTRIBUTE(metrics_latency);
 DEFINE_SHOW_ATTRIBUTE(metrics_size);
@@ -521,6 +607,13 @@ static int metric_features_show(struct seq_file *s, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(metric_features);
 
+static const struct file_operations ceph_reset_trigger_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = reset_trigger_write,
+	.llseek = noop_llseek,
+};
+
 /*
  * debugfs
  */
@@ -554,6 +647,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove(fsc->debugfs_caps);
 	debugfs_remove(fsc->debugfs_status);
 	debugfs_remove(fsc->debugfs_mdsc);
+	debugfs_remove_recursive(fsc->debugfs_reset_dir);
 	debugfs_remove(fsc->debugfs_subvolume_metrics);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
 	doutc(fsc->client, "done\n");
@@ -602,6 +696,15 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
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
index ce773b1095da..b16638ebff7f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5324,6 +5324,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 	blocked_count = atomic_inc_return(&st->blocked_requests);
 	doutc(cl, "request blocked during reset, %d total blocked\n",
 	      blocked_count);
+	trace_ceph_client_reset_blocked(mdsc, blocked_count);
 
 retry:
 	remaining = max_t(long, deadline - jiffies, 1);
@@ -5334,10 +5335,12 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
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
 
@@ -5352,12 +5355,14 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
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
 	return ret ? -EAGAIN : 0;
 }
 
@@ -5387,6 +5392,7 @@ static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
 	/* Wake up all requests that were blocked waiting for reset */
 	wake_up_all(&st->blocked_wq);
 
+	trace_ceph_client_reset_complete(mdsc, ret);
 }
 
 static void ceph_mdsc_reset_workfn(struct work_struct *work)
@@ -5749,6 +5755,7 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
 	pr_info_client(mdsc->fsc->client,
 		       "manual session reset scheduled (reason=\"%s\")\n",
 		       msg);
+	trace_ceph_client_reset_schedule(mdsc, msg);
 	return 0;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a4993644d543..1d6aab060780 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -179,6 +179,7 @@ struct ceph_fs_client {
 	struct dentry *debugfs_status;
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
+	struct dentry *debugfs_reset_dir;
 	struct dentry *debugfs_subvolume_metrics;
 #endif
 
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

