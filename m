Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE433FB7EE
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467150; cv=none; b=XoIOA8CAx7sQwXdzT2xXoxTRzspOa5/DfiiVRtcNNTzJYhr7l42ZGBBHfaB43J8StuN9eLuoos7Unsdp0uwAy03ruLSmAHsENK57C7byKFWX+M5Dv9f8Wq4lmQYYm8iXyfsDGwMqRqtTmuCTc1lUR5Il9MCGK3AfilYbVyuUdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467150; c=relaxed/simple;
	bh=XaOHlWWecmtb7BYdDb8myZ0lZCrnWCXCsZx1AwzhgEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjtIh4cKRGMd0K6+ld6lJ4RGnRCRSbvy8pQweYJbtYwnS13FuKb3PvbDRyQ9gczYfMj49cX1ddiVWBf8qZj3sKVH0HAmpOMvM14zxbTp7Ji8kHjhbK85+gAFHPffxSWmXvX1NAcz5QLgijGPbDR3p7wmS826LDNfvR8F+lR1gvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSUCk/s0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQZ29sps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSUCk/s0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQZ29sps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+WWAgsIXWVgVMWDVgyTjAWpE9gW2mZV06D7tfpFocs=;
	b=QSUCk/s0H9BLd+953iZ3QNJ/avF63kZhNVuhTxQqKUQkMs6VNOicmurO0Y1n4BLcqJX44x
	tO18bWtEb1jMdRxvFP9aUNqFWxJpI4oPenMoQokDfwsCSUVyuwP4WzID/bBtd+ViiS6RKe
	UL9xxO8W4/OUMgVpDOlGDh97S9tANho=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-4wXoNc4QMhWTbOQK1iOIKA-1; Wed, 29 Apr 2026 08:52:24 -0400
X-MC-Unique: 4wXoNc4QMhWTbOQK1iOIKA-1
X-Mimecast-MFC-AGG-ID: 4wXoNc4QMhWTbOQK1iOIKA_1777467142
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6771df2b5easo6293593a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467142; x=1778071942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+WWAgsIXWVgVMWDVgyTjAWpE9gW2mZV06D7tfpFocs=;
        b=CQZ29spsrJSpWHpUlgJxSR8DTk86YZcSihZ3qz5QnspoAudmeXAfON55FzyLJfmqqK
         n/pfeELfCpAyxDVoag7V3hWpFGPzQ8M5y/EqIqn2bmvAvgm+VN4CfGqM6RaSv1t6f5II
         PDiwE54GYjFCB9Xy3xiF7sW7fGQYL9hlB0vHq8saOtuZndRFrfKkO5Z3NKSREyYeLWQ6
         1fvmXh5L+a0Hg8KCYjPcSUP/fNC2Oe+nnSIUjODUAK8o/tvF0WsJ4mrOp28mF2CTlisU
         kt8ncMVgvgPZHIIqeXnEnS+xMkIVWnpguwVrr/xrC4PBaaWD6hLhLWiihJ5h5FN5uLRk
         EAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467142; x=1778071942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u+WWAgsIXWVgVMWDVgyTjAWpE9gW2mZV06D7tfpFocs=;
        b=OnN34jWOtyvmNNIXpK651AXOvAw/FUd+jfiLc0M9eI7/p279peZCMuqsTICnta5S+3
         KrLFR7ifvtFNMKxOm39jrYKZhIJONKktOB2MXMLZ2ThtAK01YzusjbCx/Csu+S3WEkGT
         wIYu85kML3Nzx7iOuazmIqXb6SszaG2tK37JyyEI7gn2NNv+tNEr16AGUt2d5cVpWyI4
         Gj9fdpKzjb6g9VmZexns1sxTYOUHUFyRz/eKK6gGL/GUaNfCtHRqF7+n7vgVVmp0bFqe
         zpYVvBeAkrX4RN+hBgUkDF4tYe98ffHs5YPcoBJA9EkRya0U1y2PB/Y9iNcJfQyx5iv3
         FF1Q==
X-Gm-Message-State: AOJu0YxhnfCbGvq3JwZ+U+tJXK8rSr5f2zO/dVsoRUQiPpIrAGoRANZH
	wBy/5CKSlDkzd+r5pNVFobi6ip2k7hh76yR3ke3AphNpICV4UJvIQS+xGZu6WzMoNcyU2pvZVcV
	pjIvxgfREc7/0VmF0Fjhsp+CFcBE4TQj7Rnv1LYyGcPuW4ejehyGZvMlUA6ngYJnJjZrM5WJKh7
	358ONMN+DwJLJrqgLyGVAUyMudM46mZe0sUnO514YhMztlXWccBQ==
X-Gm-Gg: AeBDietGsY2lKE45cAXSqC6nU+jlsoeC4wBzLvfLeQUR+2f0tCk54lJxv7ft8AMyXa6
	el1naNDK7I2sbAen3w+1uaTdDi6Cz7TPopCxfyo2v+4BtkNpB9l49KD1sbEGXyjCsRQ1Fi3SjLg
	Gn+Nhaneffdj0RiPnyBizIAH8uSqdZG0q+ZjU5HrTm2CEliqd3VjwRPyr4oRspdkF8qKP3fwVZ/
	nqMbqL4BkA8HZ+6O+UkWWRHsh3EBmV53Qc5xCrCPfKZtzmtEPxsVIHhrMuqJR6pflxRUYSc9z+T
	Qv/Nf3Bey70NhH0ZXuhY6+UhyzJQlsmmYtJvKb1R3e9QRaApXX1WhJAAlOIhdgUb4JPa4JBCiwP
	7L+uDV0CJXCLwLF9qQ4Rru94SOaHIrJvG3INbKvZaz48acz/51PmKl2h4siyjIVSVJQ==
X-Received: by 2002:a05:6402:324b:b0:679:223c:d195 with SMTP id 4fb4d7f45d1cf-679bb087506mr3036751a12.14.1777467141775;
        Wed, 29 Apr 2026 05:52:21 -0700 (PDT)
X-Received: by 2002:a05:6402:324b:b0:679:223c:d195 with SMTP id 4fb4d7f45d1cf-679bb087506mr3036730a12.14.1777467141038;
        Wed, 29 Apr 2026 05:52:21 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:20 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 04/11] ceph: add diagnostic timeout loop to wait_caps_flush()
Date: Wed, 29 Apr 2026 12:51:59 +0000
Message-Id: <20260429125206.1512203-5-amarkuze@redhat.com>
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

Convert wait_caps_flush() from a silent indefinite wait into a diagnostic
wait loop that periodically dumps pending cap flush state.

The underlying wait semantics remain intact: callers still wait until the
requested cap flushes complete. The difference is that long stalls now
produce actionable diagnostics instead of looking like a silent hang.

CEPH_CAP_FLUSH_MAX_DUMP_COUNT bounds the diagnostics in two ways:
it limits the number of entries emitted per diagnostic dump, and it
limits the number of timed diagnostic dumps before the wait continues
silently. When more entries exist than the per-dump limit, a truncation
count is reported. When the dump iteration limit is reached, a final
suppression message is emitted so the transition to silence is explicit.

The diagnostic dump collects flush entry data under cap_dirty_lock into
a bounded on-stack array, then prints after releasing the lock.  This
avoids holding the spinlock across printk calls.

A null cf->ci on the global flush list indicates a bug since all
cap_flush entries are initialized with a valid ci before being added.
Signal this with WARN_ON_ONCE while still printing enough context for
debugging.

READ_ONCE is used for the i_last_cap_flush_ack field, which is read
outside the inode lock domain. Flush tids are monotonically increasing
and acks are processed in order under i_ceph_lock, so the latest ack
tid is always the most recently written value.

Add a ci pointer to struct ceph_cap_flush so that the diagnostic
dump can identify which inode each pending flush belongs to.  The
new i_last_cap_flush_ack field tracks the latest acknowledged flush
tid per inode for diagnostic correlation.

This improves reset-drain observability and is also useful for
existing sync and writeback troubleshooting paths.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c       | 10 +++++
 fs/ceph/inode.c      |  1 +
 fs/ceph/mds_client.c | 97 ++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h      |  6 +++
 4 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index cb9e78b713d9..4b37d9ffdf7f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1648,6 +1648,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 		spin_lock(&mdsc->cap_dirty_lock);
 		capsnap->cap_flush.tid = ++mdsc->last_cap_flush_tid;
+		capsnap->cap_flush.ci = ci;
 		list_add_tail(&capsnap->cap_flush.g_list,
 			      &mdsc->cap_flush_list);
 		if (oldest_flush_tid == 0)
@@ -1846,6 +1847,7 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
 		return NULL;
 
 	cf->is_capsnap = false;
+	cf->ci = NULL;
 	return cf;
 }
 
@@ -1931,6 +1933,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
 
 	swap(cf, ci->i_prealloc_cap_flush);
+	cf->ci = ci;
 	cf->caps = flushing;
 	cf->wake = wake;
 
@@ -3826,6 +3829,13 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
+	/*
+	 * Flush tids are monotonically increasing and acks arrive in
+	 * order under i_ceph_lock, so this is always the latest tid.
+	 * Diagnostic readers use READ_ONCE() without holding the lock.
+	 */
+	WRITE_ONCE(ci->i_last_cap_flush_ack, flush_tid);
+
 	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
 		/* Is this the one that was flushed? */
 		if (cf->tid == flush_tid)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f75d66760d54..de465c7e96e8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -670,6 +670,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ci->i_cap_snaps);
 	ci->i_head_snapc = NULL;
 	ci->i_snap_caps = 0;
+	ci->i_last_cap_flush_ack = 0;
 
 	ci->i_last_rd = ci->i_last_wr = jiffies - 3600 * HZ;
 	for (i = 0; i < CEPH_FILE_MODE_BITS; i++)
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b62abae72c4c..d83003acfb06 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -27,6 +27,8 @@
 #include <trace/events/ceph.h>
 
 #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
+#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
+#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
 
 /*
  * A cluster of MDS (metadata server) daemons is responsible for
@@ -2286,19 +2288,106 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 }
 
 /*
- * flush all dirty inode data to disk.
+ * Dump pending cap flushes for diagnostic purposes.
  *
- * returns true if we've flushed through want_flush_tid
+ * cf->ci is safe to dereference here: cap_flush entries hold a
+ * reference on the inode (via the cap), and entries are removed from
+ * cap_flush_list under cap_dirty_lock before the cap (and thus the
+ * inode reference) is released.  Holding cap_dirty_lock therefore
+ * guarantees the inode remains valid for the lifetime of the scan.
+ */
+struct flush_dump_entry {
+	u64 ino;
+	u64 snap;
+	int caps;
+	u64 tid;
+	u64 last_ack;
+	bool wake;
+	bool is_capsnap;
+	bool ci_null;
+};
+
+static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
+{
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct flush_dump_entry entries[CEPH_CAP_FLUSH_MAX_DUMP_COUNT];
+	struct ceph_cap_flush *cf;
+	int n = 0, remaining = 0;
+
+	spin_lock(&mdsc->cap_dirty_lock);
+	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
+		if (cf->tid > want_tid)
+			break;
+		if (n < CEPH_CAP_FLUSH_MAX_DUMP_COUNT) {
+			struct flush_dump_entry *e = &entries[n++];
+
+			e->ci_null = WARN_ON_ONCE(!cf->ci);
+			if (!e->ci_null) {
+				e->ino = ceph_ino(&cf->ci->netfs.inode);
+				e->snap = ceph_snap(&cf->ci->netfs.inode);
+				e->last_ack = READ_ONCE(cf->ci->i_last_cap_flush_ack);
+			}
+			e->caps = cf->caps;
+			e->tid = cf->tid;
+			e->wake = cf->wake;
+			e->is_capsnap = cf->is_capsnap;
+		} else {
+			remaining++;
+		}
+	}
+	spin_unlock(&mdsc->cap_dirty_lock);
+
+	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
+		       want_tid);
+	for (int i = 0; i < n; i++) {
+		struct flush_dump_entry *e = &entries[i];
+
+		if (e->ci_null)
+			pr_info_client(cl,
+				       "  (null ci) %s tid=%llu wake=%d%s\n",
+				       ceph_cap_string(e->caps), e->tid,
+				       e->wake,
+				       e->is_capsnap ? " is_capsnap" : "");
+		else
+			pr_info_client(cl,
+				       "  %llx.%llx %s tid=%llu last_ack=%llu wake=%d%s\n",
+				       e->ino, e->snap,
+				       ceph_cap_string(e->caps), e->tid,
+				       e->last_ack, e->wake,
+				       e->is_capsnap ? " is_capsnap" : "");
+	}
+	if (remaining)
+		pr_info_client(cl, "  ... and %d more pending flushes\n",
+			       remaining);
+}
+
+/*
+ * Wait for all cap flushes through @want_flush_tid to complete.
+ * Periodically dumps pending cap flush state for diagnostics.
  */
 static void wait_caps_flush(struct ceph_mds_client *mdsc,
 			    u64 want_flush_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	int i = 0;
+	long ret;
 
 	doutc(cl, "want %llu\n", want_flush_tid);
 
-	wait_event(mdsc->cap_flushing_wq,
-		   check_caps_flush(mdsc, want_flush_tid));
+	do {
+		/* 60 * HZ fits in a long on all supported architectures. */
+		ret = wait_event_timeout(mdsc->cap_flushing_wq,
+			   check_caps_flush(mdsc, want_flush_tid),
+			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
+		if (ret == 0) {
+			if (i < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
+				dump_cap_flushes(mdsc, want_flush_tid);
+			else if (i == CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
+				pr_info_client(cl,
+					       "still waiting for cap flushes; suppressing further dumps\n");
+			i++;
+		}
+	} while (ret == 0);
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 30911ccf961e..9aca42c89ea0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -238,6 +238,7 @@ struct ceph_cap_flush {
 	bool is_capsnap; /* true means capsnap */
 	struct list_head g_list; // global
 	struct list_head i_list; // per inode
+	struct ceph_inode_info *ci;
 };
 
 /*
@@ -443,6 +444,11 @@ struct ceph_inode_info {
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
 	unsigned i_snap_caps;           /* cap bits for snapped files */
+	/*
+	 * Written under i_ceph_lock, read via READ_ONCE()
+	 * from diagnostic paths.
+	 */
+	u64 i_last_cap_flush_ack;
 
 	unsigned long i_last_rd;
 	unsigned long i_last_wr;
-- 
2.34.1

