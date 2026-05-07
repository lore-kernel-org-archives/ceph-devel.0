Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17053C3C1E
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156880; cv=none; b=oy3YOhp2EpJ6UdfeyZjoK2xdmZw3AjocypRT/ock4Lyam4B2ISGPQ+vK3w3Yyu2dkX+Qo4oqTKIa7pyZNSdSPfcY8vVdJTKG+Xc33bW0i7GarDDIeNbIAArY/paMdEliNfO23tw9LR7SNpHEqAwoDT3A5TV7c6UEqp+aHZY8uMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156880; c=relaxed/simple;
	bh=834wA956110D4wqm48qs+M4yAUcS2IG/A1O0L4YOJDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yjmm5gw/loc41syonvG3KN5pLDJe5fkeQYQq2IDfIHwFmYELQslJd8w+m9hShBBoZ4mGWjK+dGMiEKZUOwxSX43vu9lojukPPZlnv7fa/FnAa7e27OmuHcbDEVrucJab+cPJ2Ox9CBOBAEodEQ/7VKtVIq38SmXYSm46MKGA0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZCD6w0P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eONPNPrL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZCD6w0P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eONPNPrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zX3vYHYUteuuNITwnN2MGryb5ln7tP2ioM7ViT/pmII=;
	b=LZCD6w0Ps+xGExzClno/bXJY3715Z7YM/O4hj4NNQ1KWzqZ0JyYQpdwRDsgswDYfUnFyl+
	YMJ01hMeZPD/t+WXooP1/ew8kjOU+/4JAMi9/vksyDsOVhuEl2V5xyab4WTx0AZprujD1u
	7VUDwQq9sxKjXutApNA5hSTS3uGbQqE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-KOurd2ujOpeMQsqCK6K2OA-1; Thu, 07 May 2026 08:27:53 -0400
X-MC-Unique: KOurd2ujOpeMQsqCK6K2OA-1
X-Mimecast-MFC-AGG-ID: KOurd2ujOpeMQsqCK6K2OA_1778156872
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-672a501ba46so998274a12.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156872; x=1778761672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX3vYHYUteuuNITwnN2MGryb5ln7tP2ioM7ViT/pmII=;
        b=eONPNPrLyf4Ihu8+9+/f0CZ1o2WZBXTQubsQnhXLeF8qxn76AcSLccAVPOKu4ihYae
         rn8HuJCuRGMs2kzklv7CciUO+HgOjek3GPnGmKPF+5aatQ+lwmZb9V5dgQpoZnxLeGpM
         rAIX20Oe3gNxl5VAHBZ07yJAH9pc+lX4e8s74IPXT3Wbn4+cOkjubDGxm1ne0ryrtc/A
         1NK+Jueep/HgEbqwu7fk5yx6DZy4UmEsoJY7CgWmp3z4MG0l9FmSSy4N9DJwIOpP88dy
         Synl/hUbgEK9aj1TepiwmsA5hgteQhulYGVqwI2ij2aty4EWhKJYwnvg5bWiJk2a8x4x
         sP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156872; x=1778761672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zX3vYHYUteuuNITwnN2MGryb5ln7tP2ioM7ViT/pmII=;
        b=MyqyRS1KVHJaDci5dqVC4FuhLH/qArmZsAzjAZQ+rlhtjE0vtTyD56Y9/FkUdJ4r4y
         /vHr7596qDzE5yDa7G4TnUbKJVAwajzoJDVTIZHPWYj0Ho6YPgXP8NWQRJlbaES134ec
         NIR+WqCy+9I4jXFPpDDSJuZFktSFFykiscT8qNozODWt+sc6rU0qXwPlVvCQUU58U3bt
         n4RIBLGiJ9N6wsfzOWfFnGllGi8U9U065NjLT0dA3P+kKcM4rq6ka5wtvHoZfb1QhmMR
         W/lFC5NZjJYFO7tMq7qctj+PSzrfxhCopcG/YfLXz4c2tFzu+M+lB2c5qrVj7laHpnrY
         gqWA==
X-Gm-Message-State: AOJu0Yx2XKWawLRRoDPh4j+Ab9yWcfKG4WBRW93iGoYfzB7C5WBF42wE
	8o01e78Zoz6xTaJT0GgKepNgaWzMIYd8XH4wAxx902NnEPE9f5rlYOICJB+rzG5tjC1dFEgIGtz
	8BZ+BpHwpTfrWTrfvZRlykDNodsiOE5q6K2Z4/Nt7+Q+/nQ0wRGaZ7fle/vcqSTM6WM615ymzYx
	lxDyhFjoyqDi8rvNxbiqic+tZKwpQaSRwbEt52Xfxiy2esZG1v9A==
X-Gm-Gg: AeBDietlQc0MKahJyF4m/3kTQRiy73MtS3XFW/0zB94OncAzrD1uhilaXJwtbLnBEp1
	UjfG0NKNl0S3BwHydvwOyHD+vzj9Sun94H7t6jnR07ynAxK5nFLzxuslzuGTEICc3rQ2+hHmDRF
	+w66SlXmgg9n9Hq7vcyys6keA/nRVUc2wqG/k/Rrr9UlGxV/9jNsMday+DtXVuNk4gtHBsgdkRn
	1OmCztcNtI31OiO9d7u+tLYM9+EWsyrZbWx1wWNDsYgQcWbz1+rSyA6mBod2DFz2v+ZtgcskjCF
	ld+j8221Zh77r7CWX0Fm/ymdEJrKGof2zJUAdi9sRTqru4hf4X8BvnwMKnmw3EYeqrMFEGpnguy
	MQRAeo5isc5qJn13KUqA+JqDk2tg4C6LcGuHwcQxkmdu47Zs7i3QN6RqGTlom1TDSrw==
X-Received: by 2002:a17:907:2685:b0:b9c:b682:83bd with SMTP id a640c23a62f3a-bc56b93ffa6mr463718466b.4.1778156871926;
        Thu, 07 May 2026 05:27:51 -0700 (PDT)
X-Received: by 2002:a17:907:2685:b0:b9c:b682:83bd with SMTP id a640c23a62f3a-bc56b93ffa6mr463714566b.4.1778156871084;
        Thu, 07 May 2026 05:27:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:50 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 04/11] ceph: add diagnostic timeout loop to wait_caps_flush()
Date: Thu,  7 May 2026 12:27:30 +0000
Message-Id: <20260507122737.2804094-5-amarkuze@redhat.com>
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

Convert wait_caps_flush() from a silent indefinite wait into a diagnostic
wait loop that periodically dumps pending cap flush state.

The underlying wait semantics remain intact: callers still wait until the
requested cap flushes complete. The difference is that long stalls now
produce actionable diagnostics instead of looking like a silent hang.

CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES limits the number of entries
emitted per diagnostic dump, and CEPH_CAP_FLUSH_MAX_DUMP_ITERS
limits the number of timed diagnostic dumps before the wait
continues silently.  When more entries exist than the per-dump
limit, a truncation count is reported.  When the dump iteration
limit is reached, a final suppression message is emitted so the
transition to silence is explicit.

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
 fs/ceph/caps.c       |  10 +++++
 fs/ceph/inode.c      |   1 +
 fs/ceph/mds_client.c | 100 +++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/mds_client.h |   3 ++
 fs/ceph/super.h      |   6 +++
 5 files changed, 116 insertions(+), 4 deletions(-)

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
index 4871d7ab2730..61d7c0b8161f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -671,6 +671,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ci->i_cap_snaps);
 	ci->i_head_snapc = NULL;
 	ci->i_snap_caps = 0;
+	ci->i_last_cap_flush_ack = 0;
 
 	ci->i_last_rd = ci->i_last_wr = jiffies - 3600 * HZ;
 	for (i = 0; i < CEPH_FILE_MODE_BITS; i++)
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 249419c17d3c..6ab5031e697a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2330,19 +2330,111 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 }
 
 /*
- * flush all dirty inode data to disk.
+ * Snapshot of a single cap_flush entry for diagnostic dump.
+ * Collected under cap_dirty_lock, printed after releasing it.
+ */
+struct flush_dump_entry {
+	u64 ino;		/* inode number */
+	u64 snap;		/* snap id */
+	int caps;		/* dirty cap bits */
+	u64 tid;		/* flush transaction id */
+	u64 last_ack;		/* most recent ack tid for this inode */
+	bool wake;		/* whether completion was requested */
+	bool is_capsnap;	/* true if this is a cap snap flush */
+	bool ci_null;		/* true if cf->ci was unexpectedly NULL */
+};
+
+/*
+ * Dump pending cap flushes for diagnostic purposes.
  *
- * returns true if we've flushed through want_flush_tid
+ * cf->ci is safe to dereference here: cap_flush entries hold a
+ * reference on the inode (via the cap), and entries are removed from
+ * cap_flush_list under cap_dirty_lock before the cap (and thus the
+ * inode reference) is released.  Holding cap_dirty_lock therefore
+ * guarantees the inode remains valid for the lifetime of the scan.
+ */
+
+static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
+{
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct flush_dump_entry entries[CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES];
+	struct ceph_cap_flush *cf;
+	int n = 0, remaining = 0;
+
+	spin_lock(&mdsc->cap_dirty_lock);
+	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
+		if (cf->tid > want_tid)
+			break;
+		if (n < CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES) {
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
+			if (i < CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
+				dump_cap_flushes(mdsc, want_flush_tid);
+			else if (i == CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
+				pr_info_client(cl,
+					       "still waiting for cap flushes; suppressing further dumps\n");
+			i++;
+		}
+	} while (ret == 0);
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index d873e784b025..8208fdf02efe 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -77,6 +77,9 @@ struct ceph_fs_client;
 struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
+#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
+#define CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES 5
+#define CEPH_CAP_FLUSH_MAX_DUMP_ITERS 5
 
 struct ceph_mds_cap_match {
 	s64 uid;  /* default to MDS_AUTH_UID_ANY */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 8afc6f3a10da..a4993644d543 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -239,6 +239,7 @@ struct ceph_cap_flush {
 	bool is_capsnap; /* true means capsnap */
 	struct list_head g_list; // global
 	struct list_head i_list; // per inode
+	struct ceph_inode_info *ci;
 };
 
 /*
@@ -453,6 +454,11 @@ struct ceph_inode_info {
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

