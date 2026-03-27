Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74A3F54BF
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621867; cv=none; b=Q+uGRfTK2ZSm7W/DRO0PzB+C+cNPVK8l4PYIufMs48Lb9A6EbVL7ruWdgPEHxT18HuIhtGUrTGCHYrzcCK1xGv+XAWrjYX6KIcyiXGuhMrfObPBRXQjIe1XlO5j5Va1zY3UWx+0WTuMx81d5MKq/G60LPlqY0I1kg8y2UTUSZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621867; c=relaxed/simple;
	bh=MFCzNwhDj78xbJXogRUAEUUnFlHZv28nvJSF18dESEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9xjg5Ieo6lbXun31sivRDa8C52hxwVqZ/Pm/MumjbE8OZhIhEuBL/3MafAen7aCt4aaTgU+GtSvw3fgV4r1kOWDje6KZM6q5fat953dXXbKfyq6PLNs7mr7CY6JM56F70RqqEbpvxSxHtRBOKce7zjpgjfdmNJedRzh9c7n0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHp9RTF2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrGAqG2l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHp9RTF2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrGAqG2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPjHnkVvbuJY2fDIs5ySSS8/i9LFduWzJDQNxrHL79s=;
	b=AHp9RTF2vBbUhA8yma3IT/0RkfTuBb/pxDWkZf3REGigPkbIKu0PTbBc4lCldfGIN/qwSk
	UXrnlVbifaTdGmnL7+kVlX/o8rOvuthhdykDoYfxYOCiq4UUVRL3StIaf5kmOLLl9szg+S
	9jzJeD7L1z6m5v9YZmfWxZ8mNMjjT8o=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-fDl7Qo91MtCYxK8zo62vpg-1; Fri, 27 Mar 2026 10:31:02 -0400
X-MC-Unique: fDl7Qo91MtCYxK8zo62vpg-1
X-Mimecast-MFC-AGG-ID: fDl7Qo91MtCYxK8zo62vpg_1774621861
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-40efa542b8aso4379794fac.2
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621861; x=1775226661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPjHnkVvbuJY2fDIs5ySSS8/i9LFduWzJDQNxrHL79s=;
        b=UrGAqG2lMJ80/L306hhgZugTaG0bVpFEzBA81z82b0WqpQgXe5e2NXAXJ3TQG/PW3M
         Z8xavMjYgQ8QRvkHprkoJTFzWqS23iyd+pmygYNmtPa6xIkeOZZSlUbRonJDwMgdvQSn
         1ndSwhdObgRbqVeZT2A4pP4BW1Y2kYQDlabtkZ49IXkrh6lp+wjEwUZ89VBzXFx9tXWN
         cT8wNXho3QssYW2Dp3z8XiDA4M3bnvYc7OjEQMkEjQ4zvs8LqXdZ5p4wVqooH/U+4tw4
         YyLZGXXB5qUcxlw4MDtDKEKAIOrwTA7q4kYzMQwYa11MskNSlo3CgVp1kZGMTeFEUesR
         //LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621861; x=1775226661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPjHnkVvbuJY2fDIs5ySSS8/i9LFduWzJDQNxrHL79s=;
        b=bRimsvXEaUDtF1nvLiAFdz85MYxt9r/8PFmLHN5DQoYZYnBlht8uY+mrQA4GPDSKZf
         P9wRqnfTkaSNut83T0oTCCPKo5cBzQbaKwtVEObmuqUm6Nm/W2Q0DMMbkId15nFIKb1I
         lt3OV3+2lcVwZPDYIxPU0mg0NZi2658LMmKfE5ocokaNEJvjwOFIW78YLRSvPOwm6RGh
         V7aMT8aa4VbdeHCXlTjkJBEF9WJPwweyi/0LER0wv2X96uuG5ni6DotSDdLaSUfyhTiG
         mYbH1fCG6xFcBEI9R35NUlqRfP6RfxGPu+TIxx11FTYNIpcbVvVNzUmP37xFrw7FpT5w
         HZOg==
X-Gm-Message-State: AOJu0YzcvghnBDrgtXD65xIZnOzkm6YEXrGMnDNyKQB1yoeoeXs6DcBW
	KkOXfua0jR8zfEQ2M/G0qEktFl1wPT8jvk02cPQhvszIWgdxC7FRJzH6VHhUg/pGUaztHBhoe6s
	Ngy6YjgGhDgZBUGUVWjduNIH/lrxk4gB1DJJ/RoRaplmEwna1+gTIzwJnBj5sncTBwU0CpMLUcg
	VZ08alXpFmo1GERedQUD2skZlj5Mgg/lAEZ12VF5BLXOOZCh9CLA==
X-Gm-Gg: ATEYQzyO0deoTYdUOOPSkw+67LkmbZAYkJ3CPje0FM17P2CizXoGVCy3MtN2BYRLCmH
	mZ2htHGTiNPjg9Dxk/Ef0PvuHb+9SKl60rgPD51N0Xgp2cxuj+6o3R1B5Zjo+jV/Sj2tEsbMgbC
	1GuJPMntWI1qmrcj/VdWbrkG2Q+kNEmRNaVA5xR3fwTzxXtG6+5+73/j8qt/ymG88aUGd2ehno9
	BpQLHQMQW2JRgKd1Bu9LAPqYtTQQG0ESlDyKhAeP79LCgciPTZ4CKxh60O5HiWGII1q/nNERygx
	Zf6PO4EYkFTRTqMm5Vrs31n8FI6eXVCF3UCnbZBi+4I6WSb+3QyrlCDzdwRuIFuCA8M0Q7aknEL
	EQmlFX2opOBNwmJmUD/aCTjbA3HZFFABseslfulKNFUKIzQeuz9ia5BM=
X-Received: by 2002:a05:6870:f151:b0:409:62c9:5cc7 with SMTP id 586e51a60fabf-41cec1640edmr1319761fac.15.1774621860531;
        Fri, 27 Mar 2026 07:31:00 -0700 (PDT)
X-Received: by 2002:a05:6870:f151:b0:409:62c9:5cc7 with SMTP id 586e51a60fabf-41cec1640edmr1319711fac.15.1774621859884;
        Fri, 27 Mar 2026 07:30:59 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:30:59 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 04/10] ceph: add manual reset debugfs control and trace plumbing
Date: Fri, 27 Mar 2026 14:30:40 +0000
Message-Id: <20260327143045.1393612-5-amarkuze@redhat.com>
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

Add the debugfs trigger, status, and fault-injection files together with
the tracepoints and reset scheduling hooks used to observe and drive the
manual reset flow. This wires the reset bookkeeping into client init and
shutdown while keeping the actual reconnect-based worker logic in a
follow-up patch.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/debugfs.c           | 168 +++++++++++++++++++++++++++++++++---
 fs/ceph/locks.c             |   2 +
 fs/ceph/mds_client.c        | 116 ++++++++++++++++++++++---
 fs/ceph/mds_client.h        |  20 +++--
 fs/ceph/super.h             |   4 +
 include/trace/events/ceph.h |  60 +++++++++++++
 6 files changed, 340 insertions(+), 30 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index f3fe786b4143..9e2c32fb1f38 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -9,6 +9,8 @@
 #include <linux/seq_file.h>
 #include <linux/math64.h>
 #include <linux/ktime.h>
+#include <linux/uaccess.h>
+#include <linux/kstrtox.h>
 
 #include <linux/ceph/libceph.h>
 #include <linux/ceph/mon_client.h>
@@ -22,6 +24,10 @@
 #include "mds_client.h"
 #include "metric.h"
 
+#define CEPH_DEBUGFS_MODE_READONLY 0400
+#define CEPH_DEBUGFS_MODE_WRITEONLY 0200
+#define CEPH_DEBUGFS_MODE_READWRITE 0600
+
 static int mdsmap_show(struct seq_file *s, void *p)
 {
 	int i;
@@ -360,16 +366,140 @@ static int status_show(struct seq_file *s, void *p)
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
+	bool in_progress = false;
+	bool inject_error = false;
+	int pending_reconnects = 0;
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
+	in_progress = st->in_progress;
+	inject_error = st->inject_error;
+	strscpy(reason, st->last_reason, sizeof(reason));
+	spin_unlock(&st->lock);
+
+	pending_reconnects = atomic_read(&st->pending_reconnects);
+	blocked_requests = atomic_read(&st->blocked_requests);
+
+	seq_printf(s, "in_progress: %s\n", in_progress ? "yes" : "no");
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
+	seq_printf(s, "inject_error_pending: %s\n",
+		   inject_error ? "yes" : "no");
+	seq_printf(s, "pending_reconnects: %d\n", pending_reconnects);
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
+static ssize_t reset_inject_error_write(struct file *file,
+					const char __user *buf,
+					size_t len, loff_t *ppos)
+{
+	struct ceph_fs_client *fsc = file->private_data;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_client_reset_state *st;
+	bool enable;
+	int ret;
+
+	if (!mdsc)
+		return -ENODEV;
+
+	ret = kstrtobool_from_user(buf, len, &enable);
+	if (ret)
+		return ret;
+
+	st = &mdsc->reset_state;
+	spin_lock(&st->lock);
+	st->inject_error = enable;
+	spin_unlock(&st->lock);
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
+
+static const struct file_operations ceph_reset_inject_error_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = reset_inject_error_write,
+	.llseek = noop_llseek,
+};
+
 
 /*
  * debugfs
@@ -404,6 +534,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove(fsc->debugfs_caps);
 	debugfs_remove(fsc->debugfs_status);
 	debugfs_remove(fsc->debugfs_mdsc);
+	debugfs_remove_recursive(fsc->debugfs_reset_dir);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
 	doutc(fsc->client, "done\n");
 }
@@ -415,7 +546,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 	doutc(fsc->client, "begin\n");
 	fsc->debugfs_congestion_kb =
 		debugfs_create_file("writeback_congestion_kb",
-				    0600,
+				    CEPH_DEBUGFS_MODE_READWRITE,
 				    fsc->client->debugfs_dir,
 				    fsc,
 				    &congestion_kb_fops);
@@ -428,31 +559,48 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 				       name);
 
 	fsc->debugfs_mdsmap = debugfs_create_file("mdsmap",
-					0400,
+					CEPH_DEBUGFS_MODE_READONLY,
 					fsc->client->debugfs_dir,
 					fsc,
 					&mdsmap_fops);
 
 	fsc->debugfs_mds_sessions = debugfs_create_file("mds_sessions",
-					0400,
+					CEPH_DEBUGFS_MODE_READONLY,
 					fsc->client->debugfs_dir,
 					fsc,
 					&mds_sessions_fops);
 
 	fsc->debugfs_mdsc = debugfs_create_file("mdsc",
-						0400,
+						CEPH_DEBUGFS_MODE_READONLY,
 						fsc->client->debugfs_dir,
 						fsc,
 						&mdsc_fops);
 
 	fsc->debugfs_caps = debugfs_create_file("caps",
-						0400,
+						CEPH_DEBUGFS_MODE_READONLY,
 						fsc->client->debugfs_dir,
 						fsc,
 						&caps_fops);
 
+	fsc->debugfs_reset_dir = debugfs_create_dir("reset",
+						    fsc->client->debugfs_dir);
+	if (fsc->debugfs_reset_dir) {
+		fsc->debugfs_reset_trigger =
+			debugfs_create_file("trigger", CEPH_DEBUGFS_MODE_WRITEONLY,
+					    fsc->debugfs_reset_dir, fsc,
+					    &ceph_reset_trigger_fops);
+		fsc->debugfs_reset_status =
+			debugfs_create_file("status", CEPH_DEBUGFS_MODE_READONLY,
+					    fsc->debugfs_reset_dir, fsc,
+					    &reset_status_fops);
+		fsc->debugfs_reset_inject =
+			debugfs_create_file("inject_error", CEPH_DEBUGFS_MODE_WRITEONLY,
+					    fsc->debugfs_reset_dir, fsc,
+					    &ceph_reset_inject_error_fops);
+	}
+
 	fsc->debugfs_status = debugfs_create_file("status",
-						  0400,
+						  CEPH_DEBUGFS_MODE_READONLY,
 						  fsc->client->debugfs_dir,
 						  fsc,
 						  &status_fops);
@@ -460,13 +608,13 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 	fsc->debugfs_metrics_dir = debugfs_create_dir("metrics",
 						      fsc->client->debugfs_dir);
 
-	debugfs_create_file("file", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("file", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_file_fops);
-	debugfs_create_file("latency", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("latency", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_latency_fops);
-	debugfs_create_file("size", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("size", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_size_fops);
-	debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("caps", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_caps_fops);
 	doutc(fsc->client, "done\n");
 }
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index e6f0c565e9d6..079947a5e42a 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -251,6 +251,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u16 op = CEPH_MDS_OP_SETFILELOCK;
@@ -324,6 +325,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u8 wait = 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0dd9a529850a..4b5adc38f7b7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -67,6 +67,7 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 			    struct list_head *head);
 static void ceph_cap_release_work(struct work_struct *work);
 static void ceph_cap_reclaim_work(struct work_struct *work);
+static void ceph_mdsc_reset_workfn(struct work_struct *work);
 
 static const struct ceph_connection_operations mds_con_ops;
 
@@ -3756,33 +3757,119 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 	int blocked_count;
 	int ret;
 
-	if (READ_ONCE(st->phase) == CEPH_CLIENT_RESET_IDLE)
+	if (!READ_ONCE(st->in_progress))
 		return 0;
 
 	blocked_count = atomic_inc_return(&st->blocked_requests);
 	doutc(cl, "request blocked during reset, %d total blocked\n",
 	      blocked_count);
+	trace_ceph_client_reset_blocked(mdsc, blocked_count);
 
 	ret = wait_event_interruptible_timeout(st->blocked_wq,
-					       READ_ONCE(st->phase) ==
-					       CEPH_CLIENT_RESET_IDLE,
+					       !READ_ONCE(st->in_progress),
 					       timeout);
 
 	atomic_dec(&st->blocked_requests);
 
 	if (ret == 0) {
 		pr_warn_client(cl, "timed out waiting for reset to complete\n");
+		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
 		return -ETIMEDOUT;
 	}
-	if (ret < 0)
+	if (ret < 0) {
+		trace_ceph_client_reset_unblocked(mdsc, ret);
 		return ret;
+	}
 
 	spin_lock(&st->lock);
 	ret = st->last_errno;
 	spin_unlock(&st->lock);
+	trace_ceph_client_reset_unblocked(mdsc, ret);
 	return ret;
 }
 
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
+	wake_up_all(&st->blocked_wq);
+	trace_ceph_client_reset_complete(mdsc, ret);
+}
+
+static void ceph_mdsc_reset_workfn(struct work_struct *work)
+{
+	struct ceph_mds_client *mdsc =
+		container_of(work, struct ceph_mds_client, reset_work);
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	bool inject_error;
+	int ret = 0;
+
+	spin_lock(&st->lock);
+	inject_error = st->inject_error;
+	if (inject_error)
+		st->inject_error = false;
+	spin_unlock(&st->lock);
+
+	if (inject_error)
+		ret = -EIO;
+
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
+	trace_ceph_client_reset_schedule(mdsc, msg);
+	return 0;
+}
+
 int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 			      struct ceph_mds_request *req)
 {
@@ -3793,11 +3880,11 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	 * If a reset is in progress, wait for it to complete.
 	 *
 	 * This is best-effort: a request can pass this check just
-	 * before the phase leaves IDLE and proceed concurrently with
-	 * reset. That is acceptable because such requests will either
-	 * complete normally or fail and be retried by the caller, and
-	 * adding lock serialization here would penalize every request
-	 * for a rare manual operation.
+	 * before in_progress is set and proceed concurrently with
+	 * reset.  That is acceptable because (a) such requests will
+	 * either complete normally or fail and be retried by the
+	 * caller, and (b) adding lock serialization here would
+	 * penalize every request for a rare manual operation.
 	 */
 	err = ceph_mdsc_wait_for_reset(mdsc);
 	if (err) {
@@ -5692,11 +5779,15 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->reset_state.last_start = 0;
 	mdsc->reset_state.last_finish = 0;
 	mdsc->reset_state.last_errno = 0;
-	mdsc->reset_state.phase = CEPH_CLIENT_RESET_IDLE;
+	mdsc->reset_state.in_progress = false;
 	mdsc->reset_state.inject_error = false;
+	mdsc->reset_state.active_reset_gen = 0;
 	mdsc->reset_state.last_reason[0] = '\0';
+	atomic_set(&mdsc->reset_state.pending_reconnects, 0);
+	init_completion(&mdsc->reset_state.reconnect_done);
 	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
 	atomic_set(&mdsc->reset_state.blocked_requests, 0);
+	INIT_WORK(&mdsc->reset_work, ceph_mdsc_reset_workfn);
 
 	ceph_caps_init(mdsc);
 	ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
@@ -6224,14 +6315,15 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	ceph_msgr_flush();
 
 	spin_lock(&mdsc->reset_state.lock);
-	if (mdsc->reset_state.phase != CEPH_CLIENT_RESET_IDLE) {
-		mdsc->reset_state.phase = CEPH_CLIENT_RESET_IDLE;
+	if (mdsc->reset_state.in_progress) {
+		mdsc->reset_state.in_progress = false;
 		mdsc->reset_state.last_errno = -ESHUTDOWN;
 		mdsc->reset_state.failure_count++;
 	}
 	spin_unlock(&mdsc->reset_state.lock);
 	wake_up_all(&mdsc->reset_state.blocked_wq);
 
+	cancel_work_sync(&mdsc->reset_work);
 	ceph_mdsc_stop(mdsc);
 
 	ceph_metric_destroy(&mdsc->metric);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 5cc22c109cfe..c8269df1a9e5 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -75,15 +75,9 @@ struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
 #define CEPH_CLIENT_RESET_REASON_LEN	64
+#define CEPH_CLIENT_RESET_TIMEOUT_SEC	60
 #define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
 
-enum ceph_client_reset_phase {
-	CEPH_CLIENT_RESET_IDLE = 0,
-	CEPH_CLIENT_RESET_QUIESCING,
-	CEPH_CLIENT_RESET_DRAINING,
-	CEPH_CLIENT_RESET_TEARDOWN,
-};
-
 struct ceph_client_reset_state {
 	spinlock_t lock;
 	u64 trigger_count;
@@ -92,10 +86,15 @@ struct ceph_client_reset_state {
 	unsigned long last_start;
 	unsigned long last_finish;
 	int last_errno;
-	enum ceph_client_reset_phase phase;
+	bool in_progress;
 	bool inject_error;
 	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
 
+	/* Completion tracking for session reconnects */
+	u64 active_reset_gen;
+	atomic_t pending_reconnects;
+	struct completion reconnect_done;
+
 	/* Request blocking during reset */
 	wait_queue_head_t blocked_wq;
 	atomic_t blocked_requests;
@@ -277,6 +276,8 @@ struct ceph_mds_session {
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
+
+	u64		  s_reset_gen; /* generation of reset that initiated reconnect */
 };
 
 /*
@@ -562,6 +563,7 @@ struct ceph_mds_client {
 	struct list_head  dentry_dir_leases; /* lru list */
 
 	struct ceph_client_metric metric;
+	struct work_struct	reset_work;
 	struct ceph_client_reset_state reset_state;
 
 	spinlock_t		snapid_map_lock;
@@ -590,6 +592,8 @@ extern const char *ceph_session_state_name(int s);
 extern struct ceph_mds_session *
 ceph_get_mds_session(struct ceph_mds_session *s);
 extern void ceph_put_mds_session(struct ceph_mds_session *s);
+int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
+			     const char *reason);
 int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
 
 extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5de1e5923b63..6c403eef6492 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -179,6 +179,10 @@ struct ceph_fs_client {
 	struct dentry *debugfs_status;
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
+	struct dentry *debugfs_reset_dir;
+	struct dentry *debugfs_reset_trigger;
+	struct dentry *debugfs_reset_status;
+	struct dentry *debugfs_reset_inject;
 #endif
 
 #ifdef CONFIG_CEPH_FSCACHE
diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
index 08cb0659fbfc..22b755f4c7c7 100644
--- a/include/trace/events/ceph.h
+++ b/include/trace/events/ceph.h
@@ -226,6 +226,66 @@ TRACE_EVENT(ceph_handle_caps,
 		  __entry->mseq)
 );
 
+/*
+ * Client reset tracepoints
+ */
+TRACE_EVENT(ceph_client_reset_schedule,
+	TP_PROTO(const struct ceph_mds_client *mdsc, const char *reason),
+	TP_ARGS(mdsc, reason),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__string(reason, reason ? reason : "")
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__assign_str(reason);
+	),
+	TP_printk("mdsc=%p reason=%s", __entry->mdsc, __get_str(reason))
+);
+
+TRACE_EVENT(ceph_client_reset_complete,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
+	TP_ARGS(mdsc, ret),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__entry->ret = ret;
+	),
+	TP_printk("mdsc=%p ret=%d", __entry->mdsc, __entry->ret)
+);
+
+TRACE_EVENT(ceph_client_reset_blocked,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int blocked_count),
+	TP_ARGS(mdsc, blocked_count),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__field(int, blocked_count)
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__entry->blocked_count = blocked_count;
+	),
+	TP_printk("mdsc=%p blocked_count=%d", __entry->mdsc,
+		  __entry->blocked_count)
+);
+
+TRACE_EVENT(ceph_client_reset_unblocked,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
+	TP_ARGS(mdsc, ret),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__entry->ret = ret;
+	),
+	TP_printk("mdsc=%p ret=%d", __entry->mdsc, __entry->ret)
+);
+
 #undef EM
 #undef E_
 #endif /* _TRACE_CEPH_H */
-- 
2.34.1

