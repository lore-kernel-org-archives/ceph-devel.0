Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0393A1D2
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621861; cv=none; b=TFEj/l4muUw29VFijzb3PrfyZXQHOqZHNTwTfGqbJJcy99gwQ4upNMZDFI44RxodxvPUxWySEGz8d0Q62xxJad0UmpQ0svQKwYMzHrsstcT8h3QmIek5mGuV3p7EF3xMNxNQKEf/1t9Zd5zcAyziYOhzxF+u62P5+8N4WlZpyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621861; c=relaxed/simple;
	bh=n45hgdB8CqdKmnYdm+iwyTJ/r2fUlC6vGqp7yvvQUBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSedXgZUMCw60/xjvAuCfo8+RSZahI2USMdz3YAvgv/aSHFBV9ANafpVNQc0XKQDAFEcorrzG6jQ9mKZqvDTvXGkBnKB0d74U1prPN9iXSHB0aNJKBdxwBct2uHiXFFr8qNaWa/zBnYQKTIjVOuNOy+XD48KtVdRq24g02L4N6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSts018y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0ybK8Qw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSts018y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0ybK8Qw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9Adk/HGopUKSJ//UGnbPYWUGWGysROKyN1KbHlsHEo=;
	b=GSts018y+XwUW8bWGFqIutuVz2xao5sA4ub7DzH7Mjxq8cZRAZz4jCv+g72/+NGVlYAXrm
	I51/mgyDoVqwkijUIF5Bpq2J9fo5jrB7PCVKlcf2iRL9gbmPitdCraHYdvgmLzzETtvXqg
	VcViQC0VNSnuwJkXJMGkKdbHYFO+ICw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-azgaAGc6OOOrfAbYY7x7Sg-1; Fri, 27 Mar 2026 10:30:57 -0400
X-MC-Unique: azgaAGc6OOOrfAbYY7x7Sg-1
X-Mimecast-MFC-AGG-ID: azgaAGc6OOOrfAbYY7x7Sg_1774621857
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67e0f16976fso3323090eaf.3
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621856; x=1775226656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9Adk/HGopUKSJ//UGnbPYWUGWGysROKyN1KbHlsHEo=;
        b=K0ybK8QwjVw2WnPdcA+tDxgevUaPgw+yQeh80zx0qeONupmz8Ra/njV6ZjXbIzn3TH
         mqMlbNJJRc56AJbwDgU6NgkApX2Fliws4cD25hyQkCz9VSlL5vlJtCHXUdELMVT+wIdv
         lyGWCdnqfgbl8nWjQyZWC0AfLpO6UDKznM7k2ITnYRI4Xf3fHdqdHuJRVtWhFv/1A3oL
         +LdmGPglCI97L/0JvLylutgfELva/2GCGZbSSyttn3JchEA2I0XAGk7sFqj5TkWVysmg
         fS3L8ZH2SGxL0LCCOLxH9gUHePLYmwTrkMfLBOJTRJR1yRY81/IuCPPz0QEzfqwEDy+m
         o55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621856; x=1775226656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9Adk/HGopUKSJ//UGnbPYWUGWGysROKyN1KbHlsHEo=;
        b=eLxsbj08kXaA8/bKBbM9XNU39xF82zxGsXcVk+7XNdaTUQmF+r3XyORNlTzpxHqaty
         Zdlq2c+8SHOt7r8XbM9GyXvW7w0h2MVouEyi2yHI2gLmMbQfxDLQ9dPu/K3Ygc8Ftm5z
         N8bPhTQM71BkeLfERiHawvpebp9qAwe+3Fv3AV1QDP7Uznt9NIOOCnewxAyu0gNBrSDD
         o+CyXUFK4pbP3zMWghXGPp+B/XA7i4EOG5Qn0vLME0bmqjj9gSevBDF2/jZnJLkNqN4h
         8nXF2qEHxPUa+e+NcPMXgDVvfuYhxJ3vJGivPB439SPUYtTqFn+Z0FH0FPBsSThuQrcG
         mfgw==
X-Gm-Message-State: AOJu0YyFm35fVK6XE50unMcf1dUcqEV3d8Z17mDf2Yn6feaoXq/N/pg4
	vG3phpCj8HSqXUpGyzSXhIGCQM0GpIStflJuvLhrF6qTKr3C8CKwhjHIrfo9etEAt1Lo7gNgJyc
	5p5XDacnXZ4XwCE0jwwNOzuD3ISmjIM8pL1LLLEQ4KUQZyqJNoIZkVWT44PULo4j4BRlOWAAUXe
	4EpK9AtNEcUv68/MHH+/xW0kMF6FrXJ7q32UuQKYG2jZspCbrgwg==
X-Gm-Gg: ATEYQzxUe/ObiGo3rHwIi40Kwdb/Yowehup/X4xplWYZuaXb0tKy6M7b7yOUIsNMXp2
	g/TjlDv3H94wVOMzx28Rdd8N3uqlt4Dn9JzAtHIhAqzGRKt6yMjDmqw/Xuz5VwPHplUpZ+rHvso
	XypZsT+yhGpwMzsv3Q+4jadqap+5a8NcoclarszTqXRWOzmlZlQYJoLC4N9lkL/JAAIi603X8w6
	2APcVh91KoLx6AZb6NSUIq4aMcqpVcauUgFly7RZOaen3Z+uYGojbDkg3T3KBDqK7FPOhf7qQsR
	WsKVKfaL5XoN79FiV/j8u626JUg9KdrCnwXrqQQ/18xPTCrZzb1fmSyQhkf7WHsmg53QLb+bMGK
	6C87hDidNeIse6XEB1ys/w68kVxJS0Vrg6pDYRZcVgS6+G/4Eudc4NMo=
X-Received: by 2002:a05:6820:1623:b0:67d:e3f0:6c8 with SMTP id 006d021491bc7-67e1863fb61mr1236762eaf.22.1774621856400;
        Fri, 27 Mar 2026 07:30:56 -0700 (PDT)
X-Received: by 2002:a05:6820:1623:b0:67d:e3f0:6c8 with SMTP id 006d021491bc7-67e1863fb61mr1236729eaf.22.1774621855799;
        Fri, 27 Mar 2026 07:30:55 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:30:55 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 02/10] ceph: add bounded timeout and diagnostics to wait_caps_flush()
Date: Fri, 27 Mar 2026 14:30:38 +0000
Message-Id: <20260327143045.1393612-3-amarkuze@redhat.com>
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

Convert wait_caps_flush() from an unbounded wait into a bounded loop that
periodically dumps outstanding flush state when progress stalls. This
preserves the original data-integrity semantics while making hung cap
flushes diagnosable during reset development and validation.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c       |  7 +++++++
 fs/ceph/mds_client.c | 47 ++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h      |  2 ++
 3 files changed, 54 insertions(+), 2 deletions(-)

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
index 12f1b57d4b1c..d70c0b669b75 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -27,6 +27,8 @@
 #include <trace/events/ceph.h>
 
 #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
+#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
+#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
 
 /*
  * A cluster of MDS (metadata server) daemons is responsible for
@@ -2285,6 +2287,40 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 	return ret;
 }
 
+/*
+ * Dump pending cap flushes for diagnostic purposes.
+ *
+ * cf->ci is safe to dereference here: the inode remains alive while its
+ * ceph_cap_flush is on i_cap_flush_list, which holds a reference.
+ */
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
@@ -2294,11 +2330,18 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
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
index 272c287836c1..5de1e5923b63 100644
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

