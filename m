Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510243B8BBA
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024359; cv=none; b=Ls0ehGP5mEuzKvv6ejI+NCNSCMsOzXBYZEu5j0R5NP1D8CyvN3PJVSucETxV9N/bYVllHxBYAYKgAAR7mQDeBQauSRtwYdika2QcPoU/3UHUeQqICJjuyOiMFuyIw3vnbhzaPuTjpFj96pXGKjdU7JTpji82sAM/RvdxtJie/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024359; c=relaxed/simple;
	bh=E2dzRWH62X5awZNR6gjvhwvrtvUsaWSNYShyIxzwdjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sI7t5E5zCnUp56ESyK1FtfJiTj7yDf0awOyqAFR9D0D47JA4x5Fh/+WAS2VAaF6uRn6h183DhZBSQ0/bJNoXA3yzd32ry3byErdc1VAhmrudml6i6yXZwOKx54Xb6nkS68pn0YR4DXQKgy0Z3Ln5uGfLixLhpElsDP4MOnG9Vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIqi5qHo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvQYLOma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIqi5qHo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvQYLOma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi/vZ/gQMDX5xe1jLKXYQEZ+7mw1O3edlueKkQ+5r4M=;
	b=SIqi5qHo0LksoQkwvOBXfMoX9cA0hWIYQFjg5Dbt/1iX/ep0LkJZ3L30qBz+gxK7nqH2v1
	7UsuIJQUvwBa0ft7JyhjGxNJb+O3AV6ZTznckrt/u0ydfqmQLf/pOK0U7RdBZCdQ6bisHw
	DZ2Lt0PslRZRd+Msfatpa9HJ2cJu0dY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-pVq1FAjAMaC9dfNUBWeieQ-1; Wed, 25 Feb 2026 07:59:16 -0500
X-MC-Unique: pVq1FAjAMaC9dfNUBWeieQ-1
X-Mimecast-MFC-AGG-ID: pVq1FAjAMaC9dfNUBWeieQ_1772024356
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb6291d95aso4498581785a.1
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024355; x=1772629155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi/vZ/gQMDX5xe1jLKXYQEZ+7mw1O3edlueKkQ+5r4M=;
        b=XvQYLOma9njiANK1yFBCHXI1mWI5vXTg7+ufFGYS+1noZ/WZ66mhE4xbD+Qo12vNCh
         YGY1RzxufUvZeKO0A78rAPsispGnRREbF3IFmPCTJmg4tLb/zoBNnZwcJqfeJXLWkRoY
         XQk4BC6TW7WC8sHQIyJLuXFt7SNQkM0XWTOl67S5jKCR3sx0lK0hJS5Cer/55fJYa1eI
         9uvkgo6Y+lMyYL2hlv36RB/InR9KV7J/Xc+tWTTdA3NzbDYDi5b+CTFmhz5d4Cs/dLbk
         xm7vsediI2193Qyt7Ndf6jbwlY2R39TXDjCg6r+pMRBkfM508WnRB87s1I3EM35vfUhU
         DkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024355; x=1772629155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oi/vZ/gQMDX5xe1jLKXYQEZ+7mw1O3edlueKkQ+5r4M=;
        b=klRSEdfyYFYjkI/x9Xj1cmwydgcF15DXesCCLcSlhRutDkEuv9iIuVdYviifdUV9AM
         EqWQz3LQpjkZghHQFgP2wFQbZSFw+rXwUe2vejGk/LGQjNyFZ+wkoaz9wwCc1L42UOrx
         pw1wRWVSlySftVJu+aSC0+914sxQXnOhKc3wLXMzfpzY1Wf7Qasws5jUGK4jrsoxYvoY
         nWBjyHHkQwMJ+f/65DUXWV2JdE+xBR7agaZZYfo68Aldestbic1wdoglIVPg6LvVbnYk
         vvFEIdEhBk05dVlG5UXl4r9ktZ0GpYt8E7HirVDTTWGqbjubIRBAjCaxCqCBWYyOVTM+
         9RnQ==
X-Gm-Message-State: AOJu0Yy8vwyjNwGkzSvc6MASiO5fWNZsMxqtIm840+k9tNr9/rt7EGJi
	Jy3BQMR3qc32yWwjZQ+uvtXFCGvy1f2IsM/yaDltKpll2vT4TR+lJaltf+HfWJxX1UnbLN/mgq5
	hMSezNApMsAhTyBOVgdQcg3Am7rEw3eS7jFXK48kCT3ufdHddB6Rymk2BAKk2Msdh7H5qww6ueU
	c+tyMi8aY0AWcwLGMiF7w0jLC2deSKx1Mlq2ipFvQwr/19MGCKdfQw
X-Gm-Gg: ATEYQzwrYZG89GaMvd6orqsBHDyTXaeyOSRR21kFFTLKnX7kg8B8R4PjcZ83Q5WTmJR
	4F/I99RhcBmwufBBrW+qDfL86T3+R6Sdyq1izVvDvl5f6YujrQcXBAh7ExHipa2SexoIUiDyZPU
	0jXduo3wIpYG4qr/5pmBzYAViW1a66XyQCrCYbw87dr5uw1Yd9jmZto4tiQUIKfpu9WDvIos0tI
	E9T4Mb+K97PFr3BzhUOqV/XG4FPlgrbFJPyzWYQN1PC6tdyVTuAVYJXHxC48OLROup2KoTkE3nP
	TqSUNOSC3hEk2GIz8NHVAiHRuRJvrCwosUz0kUeHA54R6Pn8SqwFPyv+Rjbi1d22+jl2qfRk/H4
	kUB3BQS81drfjmUKiW5tx8Ks80B1eyu8By1SwgvJcqILYQc+O3tb0xu0=
X-Received: by 2002:a05:620a:4494:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbbcfab258mr41042385a.35.1772024355629;
        Wed, 25 Feb 2026 04:59:15 -0800 (PST)
X-Received: by 2002:a05:620a:4494:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbbcfab258mr41038385a.35.1772024355040;
        Wed, 25 Feb 2026 04:59:15 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:14 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 2/4] ceph: add bounded timeout and diagnostics to wait_caps_flush()
Date: Wed, 25 Feb 2026 12:59:05 +0000
Message-Id: <20260225125907.53851-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225125907.53851-1-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert wait_caps_flush() from an unbounded wait_event() to a
bounded wait_event_timeout() with a 60-second period. If the
flush hasn't completed after each timeout, dump the pending
cap_flush list (up to 5 times) to aid debugging hung flush
scenarios.

Add a ci back-pointer to struct ceph_cap_flush so the diagnostic
dump can identify which inodes have outstanding flushes. Add
i_last_cap_flush_ack to ceph_inode_info for tracking the latest
acknowledged flush tid per inode.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c       |  7 +++++++
 fs/ceph/mds_client.c | 41 +++++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h      |  2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..be030fb8e864 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1648,6 +1648,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 		spin_lock(&mdsc->cap_dirty_lock);
 		capsnap->cap_flush.tid = ++mdsc->last_cap_flush_tid;
+		capsnap->cap_flush.ci = ci;
 		list_add_tail(&capsnap->cap_flush.g_list,
 			      &mdsc->cap_flush_list);
 		if (oldest_flush_tid == 0)
@@ -1846,6 +1847,9 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
 		return NULL;
 
 	cf->is_capsnap = false;
+	cf->ci = NULL;
+	cf->tid = 0;
+	cf->wake = false;
 	return cf;
 }
 
@@ -1931,6 +1935,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
 
 	swap(cf, ci->i_prealloc_cap_flush);
+	cf->ci = ci;
 	cf->caps = flushing;
 	cf->wake = wake;
 
@@ -3826,6 +3831,8 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
+	ci->i_last_cap_flush_ack = flush_tid;
+
 	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
 		/* Is this the one that was flushed? */
 		if (cf->tid == flush_tid)
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 28bb27b09b40..e27f2f148dea 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -27,6 +27,8 @@
 #include <trace/events/ceph.h>
 
 #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
+#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
+#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
 
 /*
  * A cluster of MDS (metadata server) daemons is responsible for
@@ -2285,6 +2287,34 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 	return ret;
 }
 
+static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
+{
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_cap_flush *cf;
+
+	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
+		       want_tid);
+	spin_lock(&mdsc->cap_dirty_lock);
+	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
+		if (cf->tid > want_tid)
+			break;
+		if (!cf->ci) {
+			pr_info_client(cl,
+				       "(null ci) %s tid=%llu wake=%d%s\n",
+				       ceph_cap_string(cf->caps), cf->tid,
+				       cf->wake,
+				       cf->is_capsnap ? " is_capsnap" : "");
+			continue;
+		}
+		pr_info_client(cl, "%llx:%llx %s %llu %llu %d%s\n",
+			       ceph_vinop(&cf->ci->netfs.inode),
+			       ceph_cap_string(cf->caps), cf->tid,
+			       cf->ci->i_last_cap_flush_ack, cf->wake,
+			       cf->is_capsnap ? " is_capsnap" : "");
+	}
+	spin_unlock(&mdsc->cap_dirty_lock);
+}
+
 /*
  * flush all dirty inode data to disk.
  *
@@ -2294,11 +2324,18 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 			    u64 want_flush_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	int i = 0;
+	long ret;
 
 	doutc(cl, "want %llu\n", want_flush_tid);
 
-	wait_event(mdsc->cap_flushing_wq,
-		   check_caps_flush(mdsc, want_flush_tid));
+	do {
+		ret = wait_event_timeout(mdsc->cap_flushing_wq,
+			   check_caps_flush(mdsc, want_flush_tid),
+			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
+		if (ret == 0 && i++ < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
+			dump_cap_flushes(mdsc, want_flush_tid);
+	} while (ret == 0);
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 69a71848240f..9e80c816aa7a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -238,6 +238,7 @@ struct ceph_cap_flush {
 	bool is_capsnap; /* true means capsnap */
 	struct list_head g_list; // global
 	struct list_head i_list; // per inode
+	struct ceph_inode_info *ci;
 };
 
 /*
@@ -443,6 +444,7 @@ struct ceph_inode_info {
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
 	unsigned i_snap_caps;           /* cap bits for snapped files */
+	u64 i_last_cap_flush_ack;		/* latest cap flush_ack tid for this inode */
 
 	unsigned long i_last_rd;
 	unsigned long i_last_wr;
-- 
2.34.1

