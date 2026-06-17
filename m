Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936EA477E38
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708438; cv=none; b=OvFLXYC+y8nH9cH0yTyUdYtqQWhGAmlhnWfyaSQli04huDu/S0xdbQrRu43ZEe8ZyZJYTPaCGjkha0qE4ID3udSdBfOW0oshNLiNPx0R8VkEcIHvu7LMEd4cQpYHzz0PjZ2pqvvtPDFtaF/rcBRZz8Y9y997bhX9/2yyAIpWapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708438; c=relaxed/simple;
	bh=V8a2kowkKIJ7i/7V1Bop7FahJS6nZ7k6xxo52Iiu0fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e44izF9kqT4rBCtokRz4kFzGCbFNMcS4mJ0E5JZcIfHNT047QBqh+JpkgKeSfrRbnGGoCBrhUd9i5u2S1HWiWvUOjkEq31K4uDTC/QkoFqxZiYUB2KymOwzLYiNScmiOSaX/MOFv2vtKZebS6GmSN6OzaO8o3aX3AZYWKIgTWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bgf3YQ3C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IH9YqsXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bgf3YQ3C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH9YqsXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkH1WEbdFhNc0rvUZFncNxCcS8wHyjsbeTXh8mKGvKo=;
	b=Bgf3YQ3CHHY71/cHN5HUtpvwlBra4CVTZz5ttHAHZiAx46Joq9JmSRkRixyRLOUo/NQDK4
	TdJcHwXT4XbSqiKi8q5JAPfM3D76W9CXseWdn1hfa8YRQBsJmXcGYZdzRc1CkSTw3P8Puw
	WaroHoXSGSmOhHGU5KGNzGdJ128TRQU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-vwvr1InUNlOVHv4Yt9PLzg-1; Wed, 17 Jun 2026 11:00:23 -0400
X-MC-Unique: vwvr1InUNlOVHv4Yt9PLzg-1
X-Mimecast-MFC-AGG-ID: vwvr1InUNlOVHv4Yt9PLzg_1781708422
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6caac6486so7109454a34.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708422; x=1782313222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkH1WEbdFhNc0rvUZFncNxCcS8wHyjsbeTXh8mKGvKo=;
        b=IH9YqsXDhtyaiZycjfyCAtFO+nHpL7i255w7VfsdZCCLNXZOkcf2E2V8nPkAWQgy9F
         PtBtP+KZDwPveWBOrE2molnXnC+U5J0VfiIXc7e+b914hOpJuPJXP4hJhO5pnjQeGOmk
         zkAi1U/oY9aYKIlOuDW2573jS6s/z2yqSR/nwdtnWGjD6svttG4rxPybsaB8cpjTjBbE
         BS3Fjg/1zbTYjgzPXhZ1lJizXQQ9t7UNVlLn89LI/KzXq76R0fKv5szNy/5sHuN9ND4e
         yjYDVJoxnHcMKouflnYXGPI7xHskcJX2St52pikVNySdHWNz7lg0O0qbckA1JRvSdHBe
         gQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708422; x=1782313222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IkH1WEbdFhNc0rvUZFncNxCcS8wHyjsbeTXh8mKGvKo=;
        b=LOuqWsRimsT0jcylrhxNDd+jGZJAXyNdJLKvM+aUgBFlDQiLBmSDM77Ft7AuU0o4xS
         qqNF6bWUfpxSJ8tFRe1qEnbevyxU/9Ukv4LGpniUZf+V6kv0pkPftDPt9N/V15K2CKOe
         kpU9+GtbP/7BTguYVBsupp03dnQ8d13vtt2YBvafCaYSWMaLPfTsqV1Xk5A+hgzh7Gzv
         1S2MdHalRD6JHio79WchgJl2TrBR8tc0hPWIU1nTRoCifeU6rM4gaARxCD8SpzK6DEgh
         +piKDzCLgOKiMd7d3Lldc7YfjeaHmrIIzydqUHm98R9NiMcm7/cRWLOAZssb2WH9IPyP
         3u1w==
X-Gm-Message-State: AOJu0YxIYFNw1j2o/ITW2j56w2gpjv/FpmD53AKL7fIiNvbH+OK6xPG8
	v8IPPs+xvh65PBvoOiV0Kz3J2xRfIHcMqpjWGQ2f37MmuTkYqikavNtmF6Yk+szXPY/5q4G9fJd
	JwfTtCIa/gjtG5RFSAZPftPkQj2hMLiAdCq9lvwhq9kCDcbfXwcZeiH447nOBwI8YtYrVEJfSbG
	tVUUEu/CDHoRwGNuSVA2JbriItWdWJi5invBVAOsNj1qwEkhxrWg==
X-Gm-Gg: Acq92OFcWWaS/A4yttdFp9HGKdf6OMh9Y4WcM/HEaK01poUtqRR2kGo1l4ngdDFsw+m
	RfMwWcOoXagKWzqbjqe8htQqjND9yh/VBozbvZvQ6W+8mM9wJ/LRjFlXn1aV+njhAA5Ttmad2MN
	jgrSm+QkfT1o99DoPAW7AF0qr/wy1oJJ9tNEL+rpn2Q3HOWfPbawpGILCG3LRRfASYkAWx7dHoZ
	xqg2RtviAGArFuXROAFY+zEo6wR+yMED9Xn8Zylb9bgygWOW3qeHyrVopWnkekUH/kuyv9rDRkf
	GFe17QxROoUxIsMjPqXp6tzHyAAY+Q42VTNbtwhPA2AX+g+/rNZXq1IxopS8gr8CPugnddeNdP/
	LkumHesMmwmL/d42I83q0SmvzPLcW/BDzmfdmVqOGA/B6
X-Received: by 2002:a05:6830:2a10:b0:7e7:a74:6968 with SMTP id 46e09a7af769-7e90c6a2ed6mr3091638a34.19.1781708421205;
        Wed, 17 Jun 2026 08:00:21 -0700 (PDT)
X-Received: by 2002:a05:6830:2a10:b0:7e7:a74:6968 with SMTP id 46e09a7af769-7e90c6a2ed6mr3091574a34.19.1781708419983;
        Wed, 17 Jun 2026 08:00:19 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 13/15] ceph: convert capability and snapshot paths to bout
Date: Wed, 17 Jun 2026 14:59:43 +0000
Message-Id: <20260617145945.1912736-14-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617145945.1912736-1-amarkuze@redhat.com>
References: <20260617145945.1912736-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dout()/doutc() with bout()/boutc() in caps.c (cap grant,
release, flush, revoke) and snap.c (snap handling, cap snap queue).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c | 252 ++++++++++++++++++++++++++-----------------------
 fs/ceph/snap.c |  66 ++++++-------
 2 files changed, 165 insertions(+), 153 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..a10a9d1ec76e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -188,7 +188,7 @@ static void __ceph_unreserve_caps(struct ceph_mds_client *mdsc, int nr_caps)
 			mdsc->caps_avail_count += nr_caps;
 		}
 
-		doutc(mdsc->fsc->client,
+		boutc(mdsc->fsc->client,
 		      "caps %d = %d used + %d resv + %d avail\n",
 		      mdsc->caps_total_count, mdsc->caps_use_count,
 		      mdsc->caps_reserve_count, mdsc->caps_avail_count);
@@ -215,7 +215,7 @@ int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 	struct ceph_mds_session *s;
 	LIST_HEAD(newcaps);
 
-	doutc(cl, "ctx=%p need=%d\n", ctx, need);
+	boutc(cl, "ctx=%p need=%d\n", ctx, need);
 
 	/* first reserve any caps that are already allocated */
 	spin_lock(&mdsc->caps_list_lock);
@@ -301,7 +301,7 @@ int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 
 	spin_unlock(&mdsc->caps_list_lock);
 
-	doutc(cl, "ctx=%p %d = %d used + %d resv + %d avail\n", ctx,
+	boutc(cl, "ctx=%p %d = %d used + %d resv + %d avail\n", ctx,
 	      mdsc->caps_total_count, mdsc->caps_use_count,
 	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	return err;
@@ -315,7 +315,7 @@ void ceph_unreserve_caps(struct ceph_mds_client *mdsc,
 	if (!ctx->count)
 		return;
 
-	doutc(cl, "ctx=%p count=%d\n", ctx, ctx->count);
+	boutc(cl, "ctx=%p count=%d\n", ctx, ctx->count);
 	spin_lock(&mdsc->caps_list_lock);
 	__ceph_unreserve_caps(mdsc, ctx->count);
 	ctx->count = 0;
@@ -364,7 +364,7 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 	}
 
 	spin_lock(&mdsc->caps_list_lock);
-	doutc(cl, "ctx=%p (%d) %d = %d used + %d resv + %d avail\n", ctx,
+	boutc(cl, "ctx=%p (%d) %d = %d used + %d resv + %d avail\n", ctx,
 	      ctx->count, mdsc->caps_total_count, mdsc->caps_use_count,
 	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	BUG_ON(!ctx->count);
@@ -390,7 +390,7 @@ void ceph_put_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap)
 	struct ceph_client *cl = mdsc->fsc->client;
 
 	spin_lock(&mdsc->caps_list_lock);
-	doutc(cl, "%p %d = %d used + %d resv + %d avail\n", cap,
+	boutc(cl, "%p %d = %d used + %d resv + %d avail\n", cap,
 	      mdsc->caps_total_count, mdsc->caps_use_count,
 	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	mdsc->caps_use_count--;
@@ -503,7 +503,7 @@ static void __cap_set_timeouts(struct ceph_mds_client *mdsc,
 
 	ci->i_hold_caps_max = round_jiffies(jiffies +
 					    opt->caps_wanted_delay_max * HZ);
-	doutc(mdsc->fsc->client, "%p %llx.%llx %lu\n", inode,
+	boutc(mdsc->fsc->client, "%p %llx.%llx %lu\n", inode,
 	      ceph_vinop(inode), ci->i_hold_caps_max - jiffies);
 }
 
@@ -520,7 +520,7 @@ static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
 {
 	struct inode *inode = &ci->netfs.inode;
 
-	doutc(mdsc->fsc->client, "%p %llx.%llx flags 0x%lx at %lu\n",
+	boutc(mdsc->fsc->client, "%p %llx.%llx flags 0x%lx at %lu\n",
 	      inode, ceph_vinop(inode), ci->i_ceph_flags,
 	      ci->i_hold_caps_max);
 	if (!mdsc->stopping) {
@@ -547,7 +547,7 @@ static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 {
 	struct inode *inode = &ci->netfs.inode;
 
-	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	spin_lock(&mdsc->cap_delay_lock);
 	set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
 	if (!list_empty(&ci->i_cap_delay_list))
@@ -566,7 +566,7 @@ static void __cap_delay_cancel(struct ceph_mds_client *mdsc,
 {
 	struct inode *inode = &ci->netfs.inode;
 
-	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (list_empty(&ci->i_cap_delay_list))
 		return;
 	spin_lock(&mdsc->cap_delay_lock);
@@ -605,7 +605,7 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
 		if (issued & CEPH_CAP_FILE_SHARED)
 			atomic_inc(&ci->i_shared_gen);
 		if (S_ISDIR(ci->netfs.inode.i_mode)) {
-			doutc(cl, " marking %p NOT complete\n", inode);
+			boutc(cl, " marking %p NOT complete\n", inode);
 			__ceph_dir_clear_complete(ci);
 		}
 	}
@@ -664,7 +664,7 @@ void ceph_add_cap(struct inode *inode,
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	doutc(cl, "%p %llx.%llx mds%d cap %llx %s seq %d\n", inode,
+	boutc(cl, "%p %llx.%llx mds%d cap %llx %s seq %d\n", inode,
 	      ceph_vinop(inode), session->s_mds, cap_id,
 	      ceph_cap_string(issued), seq);
 
@@ -744,7 +744,7 @@ void ceph_add_cap(struct inode *inode,
 	actual_wanted = __ceph_caps_wanted(ci);
 	if ((wanted & ~actual_wanted) ||
 	    (issued & ~actual_wanted & CEPH_CAP_ANY_WR)) {
-		doutc(cl, "issued %s, mds wanted %s, actual %s, queueing\n",
+		boutc(cl, "issued %s, mds wanted %s, actual %s, queueing\n",
 		      ceph_cap_string(issued), ceph_cap_string(wanted),
 		      ceph_cap_string(actual_wanted));
 		__cap_delay_requeue(mdsc, ci);
@@ -763,7 +763,7 @@ void ceph_add_cap(struct inode *inode,
 		WARN_ON(ci->i_auth_cap == cap);
 	}
 
-	doutc(cl, "inode %p %llx.%llx cap %p %s now %s seq %d mds%d\n",
+	boutc(cl, "inode %p %llx.%llx cap %p %s now %s seq %d mds%d\n",
 	      inode, ceph_vinop(inode), cap, ceph_cap_string(issued),
 	      ceph_cap_string(issued|cap->issued), seq, mds);
 	cap->cap_id = cap_id;
@@ -796,7 +796,7 @@ static int __cap_is_valid(struct ceph_cap *cap)
 	ttl = cap->session->s_cap_ttl;
 
 	if (cap->cap_gen < gen || time_after_eq(jiffies, ttl)) {
-		doutc(cl, "%p %llx.%llx cap %p issued %s but STALE (gen %u vs %u)\n",
+		boutc(cl, "%p %llx.%llx cap %p issued %s but STALE (gen %u vs %u)\n",
 		      inode, ceph_vinop(inode), cap,
 		      ceph_cap_string(cap->issued), cap->cap_gen, gen);
 		return 0;
@@ -824,7 +824,7 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
 		cap = rb_entry(p, struct ceph_cap, ci_node);
 		if (!__cap_is_valid(cap))
 			continue;
-		doutc(cl, "%p %llx.%llx cap %p issued %s\n", inode,
+		boutc(cl, "%p %llx.%llx cap %p issued %s\n", inode,
 		      ceph_vinop(inode), cap, ceph_cap_string(cap->issued));
 		have |= cap->issued;
 		if (implemented)
@@ -874,11 +874,11 @@ static void __touch_cap(struct ceph_cap *cap)
 
 	spin_lock(&s->s_cap_lock);
 	if (!s->s_cap_iterator) {
-		doutc(cl, "%p %llx.%llx cap %p mds%d\n", inode,
+		boutc(cl, "%p %llx.%llx cap %p mds%d\n", inode,
 		      ceph_vinop(inode), cap, s->s_mds);
 		list_move_tail(&cap->session_caps, &s->s_caps);
 	} else {
-		doutc(cl, "%p %llx.%llx cap %p mds%d NOP, iterating over caps\n",
+		boutc(cl, "%p %llx.%llx cap %p mds%d NOP, iterating over caps\n",
 		      inode, ceph_vinop(inode), cap, s->s_mds);
 	}
 	spin_unlock(&s->s_cap_lock);
@@ -898,7 +898,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 	int have = ci->i_snap_caps;
 
 	if ((have & mask) == mask) {
-		doutc(cl, "mask %p %llx.%llx snap issued %s (mask %s)\n",
+		boutc(cl, "mask %p %llx.%llx snap issued %s (mask %s)\n",
 		      inode, ceph_vinop(inode), ceph_cap_string(have),
 		      ceph_cap_string(mask));
 		return 1;
@@ -909,7 +909,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 		if (!__cap_is_valid(cap))
 			continue;
 		if ((cap->issued & mask) == mask) {
-			doutc(cl, "mask %p %llx.%llx cap %p issued %s (mask %s)\n",
+			boutc(cl, "mask %p %llx.%llx cap %p issued %s (mask %s)\n",
 			      inode, ceph_vinop(inode), cap,
 			      ceph_cap_string(cap->issued),
 			      ceph_cap_string(mask));
@@ -921,7 +921,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 		/* does a combination of caps satisfy mask? */
 		have |= cap->issued;
 		if ((have & mask) == mask) {
-			doutc(cl, "mask %p %llx.%llx combo issued %s (mask %s)\n",
+			boutc(cl, "mask %p %llx.%llx combo issued %s (mask %s)\n",
 			      inode, ceph_vinop(inode),
 			      ceph_cap_string(cap->issued),
 			      ceph_cap_string(mask));
@@ -1130,13 +1130,13 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 
 	/* 'ci' being NULL means the remove have already occurred */
 	if (!ci) {
-		doutc(cl, "inode is NULL\n");
+		boutc(cl, "inode is NULL\n");
 		return;
 	}
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	doutc(cl, "%p from %p %llx.%llx\n", cap, inode, ceph_vinop(inode));
+	boutc(cl, "%p from %p %llx.%llx\n", cap, inode, ceph_vinop(inode));
 
 	mdsc = ceph_inode_to_fs_client(&ci->netfs.inode)->mdsc;
 
@@ -1149,7 +1149,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	spin_lock(&session->s_cap_lock);
 	if (session->s_cap_iterator == cap) {
 		/* not yet, we are iterating over this very cap */
-		doutc(cl, "delaying %p removal from session %p\n", cap,
+		boutc(cl, "delaying %p removal from session %p\n", cap,
 		      cap->session);
 	} else {
 		list_del_init(&cap->session_caps);
@@ -1203,7 +1203,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 
 	/* 'ci' being NULL means the remove have already occurred */
 	if (!ci) {
-		doutc(mdsc->fsc->client, "inode is NULL\n");
+		boutc(mdsc->fsc->client, "inode is NULL\n");
 		return;
 	}
 
@@ -1248,7 +1248,7 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
 	struct ceph_mds_client *mdsc = arg->session->s_mdsc;
 	struct ceph_osd_client *osdc = &mdsc->fsc->client->osdc;
 
-	doutc(mdsc->fsc->client,
+	boutc(mdsc->fsc->client,
 	      "%s %llx %llx caps %s wanted %s dirty %s seq %u/%u"
 	      " tid %llu/%llu mseq %u follows %lld size %llu/%llu"
 	      " xattr_ver %llu xattr_len %d\n",
@@ -1403,7 +1403,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	revoking = cap->implemented & ~cap->issued;
 	retain &= ~revoking;
 
-	doutc(cl, "%p %llx.%llx cap %p session %p %s -> %s (revoking %s)\n",
+	boutc(cl, "%p %llx.%llx cap %p session %p %s -> %s (revoking %s)\n",
 	      inode, ceph_vinop(inode), cap, cap->session,
 	      ceph_cap_string(held), ceph_cap_string(held & retain),
 	      ceph_cap_string(revoking));
@@ -1626,7 +1626,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 	u64 oldest_flush_tid = 0;
 	u64 first_tid = 1, last_tid = 0;
 
-	doutc(cl, "%p %llx.%llx session %p\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx session %p\n", inode, ceph_vinop(inode),
 	      session);
 
 	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
@@ -1642,7 +1642,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 		/* only flush each capsnap once */
 		if (capsnap->cap_flush.tid > 0) {
-			doutc(cl, "already flushed %p, skipping\n", capsnap);
+			boutc(cl, "already flushed %p, skipping\n", capsnap);
 			continue;
 		}
 
@@ -1675,7 +1675,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		int ret;
 
 		if (!(cap && cap->session == session)) {
-			doutc(cl, "%p %llx.%llx auth cap %p not mds%d, stop\n",
+			boutc(cl, "%p %llx.%llx auth cap %p not mds%d, stop\n",
 			      inode, ceph_vinop(inode), cap, session->s_mds);
 			break;
 		}
@@ -1697,7 +1697,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		refcount_inc(&capsnap->nref);
 		spin_unlock(&ci->i_ceph_lock);
 
-		doutc(cl, "%p %llx.%llx capsnap %p tid %llu %s\n", inode,
+		boutc(cl, "%p %llx.%llx capsnap %p tid %llu %s\n", inode,
 		      ceph_vinop(inode), capsnap, cf->tid,
 		      ceph_cap_string(capsnap->dirty));
 
@@ -1725,23 +1725,23 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	bool need_put = false;
 	int mds;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (psession)
 		session = *psession;
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (!(ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)) {
-		doutc(cl, " no capsnap needs flush, doing nothing\n");
+		boutc(cl, " no capsnap needs flush, doing nothing\n");
 		goto out;
 	}
 	if (!ci->i_auth_cap) {
-		doutc(cl, " no auth cap (migrating?), doing nothing\n");
+		boutc(cl, " no auth cap (migrating?), doing nothing\n");
 		goto out;
 	}
 
 	mds = ci->i_auth_cap->session->s_mds;
 	if (session && session->s_mds != mds) {
-		doutc(cl, " oops, wrong session %p mutex\n", session);
+		boutc(cl, " oops, wrong session %p mutex\n", session);
 		ceph_put_mds_session(session);
 		session = NULL;
 	}
@@ -1801,7 +1801,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 		return 0;
 	}
 
-	doutc(cl, "%p %llx.%llx %s dirty %s -> %s\n", inode,
+	boutc(cl, "%p %llx.%llx %s dirty %s -> %s\n", inode,
 	      ceph_vinop(inode), ceph_cap_string(mask),
 	      ceph_cap_string(was), ceph_cap_string(was | mask));
 	ci->i_dirty_caps |= mask;
@@ -1816,7 +1816,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 			ci->i_head_snapc = ceph_get_snap_context(
 				ci->i_snap_realm->cached_context);
 		}
-		doutc(cl, "%p %llx.%llx now dirty snapc %p auth cap %p\n",
+		boutc(cl, "%p %llx.%llx now dirty snapc %p auth cap %p\n",
 		      inode, ceph_vinop(inode), ci->i_head_snapc,
 		      ci->i_auth_cap);
 		BUG_ON(!list_empty(&ci->i_dirty_item));
@@ -1924,13 +1924,13 @@ static u64 __mark_caps_flushing(struct inode *inode,
 	BUG_ON(!ci->i_prealloc_cap_flush);
 
 	flushing = ci->i_dirty_caps;
-	doutc(cl, "flushing %s, flushing_caps %s -> %s\n",
+	boutc(cl, "flushing %s, flushing_caps %s -> %s\n",
 	      ceph_cap_string(flushing),
 	      ceph_cap_string(ci->i_flushing_caps),
 	      ceph_cap_string(ci->i_flushing_caps | flushing));
 	ci->i_flushing_caps |= flushing;
 	ci->i_dirty_caps = 0;
-	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
 
 	swap(cf, ci->i_prealloc_cap_flush);
 	cf->ci = ci;
@@ -1974,13 +1974,13 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	if (inode->i_data.nrpages == 0 &&
 	    invalidating_gen == ci->i_rdcache_gen) {
 		/* success. */
-		doutc(cl, "%p %llx.%llx success\n", inode,
+		boutc(cl, "%p %llx.%llx success\n", inode,
 		      ceph_vinop(inode));
 		/* save any racing async invalidate some trouble */
 		ci->i_rdcache_revoking = ci->i_rdcache_gen - 1;
 		return 0;
 	}
-	doutc(cl, "%p %llx.%llx failed\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx failed\n", inode, ceph_vinop(inode));
 	return -1;
 }
 
@@ -2089,7 +2089,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx file_want %s used %s dirty %s "
+	boutc(cl, "%p %llx.%llx file_want %s used %s dirty %s "
 	      "flushing %s issued %s revoking %s retain %s %s%s%s%s\n",
 	     inode, ceph_vinop(inode), ceph_cap_string(file_wanted),
 	     ceph_cap_string(used), ceph_cap_string(ci->i_dirty_caps),
@@ -2113,10 +2113,10 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 	    (revoking & (CEPH_CAP_FILE_CACHE|
 			 CEPH_CAP_FILE_LAZYIO)) && /*  or revoking cache */
 	    !tried_invalidate) {
-		doutc(cl, "trying to invalidate on %p %llx.%llx\n",
+		boutc(cl, "trying to invalidate on %p %llx.%llx\n",
 		      inode, ceph_vinop(inode));
 		if (try_nonblocking_invalidate(inode) < 0) {
-			doutc(cl, "queuing invalidate\n");
+			boutc(cl, "queuing invalidate\n");
 			queue_invalidate = true;
 			ci->i_rdcache_revoking = ci->i_rdcache_gen;
 		}
@@ -2144,7 +2144,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 			cap_used &= ~ci->i_auth_cap->issued;
 
 		revoking = cap->implemented & ~cap->issued;
-		doutc(cl, " mds%d cap %p used %s issued %s implemented %s revoking %s\n",
+		boutc(cl, " mds%d cap %p used %s issued %s implemented %s revoking %s\n",
 		      cap->mds, cap, ceph_cap_string(cap_used),
 		      ceph_cap_string(cap->issued),
 		      ceph_cap_string(cap->implemented),
@@ -2153,7 +2153,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		/* completed revocation? going down and there are no caps? */
 		if (revoking) {
 			if ((revoking & cap_used) == 0) {
-				doutc(cl, "completed revocation of %s\n",
+				boutc(cl, "completed revocation of %s\n",
 				      ceph_cap_string(cap->implemented & ~cap->issued));
 				goto ack;
 			}
@@ -2175,7 +2175,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		}
 
 		if (flags & CHECK_CAPS_FLUSH_FORCE) {
-			doutc(cl, "force to flush caps\n");
+			boutc(cl, "force to flush caps\n");
 			goto ack;
 		}
 
@@ -2184,24 +2184,24 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 			/* request larger max_size from MDS? */
 			if (ci->i_wanted_max_size > ci->i_max_size &&
 			    ci->i_wanted_max_size > ci->i_requested_max_size) {
-				doutc(cl, "requesting new max_size\n");
+				boutc(cl, "requesting new max_size\n");
 				goto ack;
 			}
 
 			/* approaching file_max? */
 			if (__ceph_should_report_size(ci)) {
-				doutc(cl, "i_size approaching max_size\n");
+				boutc(cl, "i_size approaching max_size\n");
 				goto ack;
 			}
 		}
 		/* flush anything dirty? */
 		if (cap == ci->i_auth_cap) {
 			if ((flags & CHECK_CAPS_FLUSH) && ci->i_dirty_caps) {
-				doutc(cl, "flushing dirty caps\n");
+				boutc(cl, "flushing dirty caps\n");
 				goto ack;
 			}
 			if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS) {
-				doutc(cl, "flushing snap caps\n");
+				boutc(cl, "flushing snap caps\n");
 				goto ack;
 			}
 		}
@@ -2453,7 +2453,7 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 		kfree(sessions);
 	}
 
-	doutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
+	boutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
 	      ceph_vinop(inode), req1 ? req1->r_tid : 0ULL,
 	      req2 ? req2->r_tid : 0ULL);
 	if (req1) {
@@ -2480,13 +2480,17 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	u64 flush_tid;
 	int ret, err;
 	int dirty;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	doutc(cl, "%p %llx.%llx%s\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx%s\n", inode, ceph_vinop(inode),
 	      datasync ? " datasync" : "");
 
 	ret = file_write_and_wait_range(file, start, end);
@@ -2498,7 +2502,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	dirty = try_flush_caps(inode, &flush_tid);
-	doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
+	boutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
 
 	err = flush_mdlog_and_wait_inode_unsafe_requests(inode);
 
@@ -2519,8 +2523,9 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (err < 0)
 		ret = err;
 out:
-	doutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
 	      datasync ? " datasync" : "", ret);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2532,19 +2537,25 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	u64 flush_tid;
 	int err = 0;
 	int dirty;
 	int wait = (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync);
+	struct ceph_journal_info __ji;
 
-	doutc(cl, "%p %llx.%llx wait=%d\n", inode, ceph_vinop(inode), wait);
+	ceph_blog_enter(fsc, &__ji);
+
+	boutc(cl, "%p %llx.%llx wait=%d\n", inode, ceph_vinop(inode), wait);
 	ceph_fscache_unpin_writeback(inode, wbc);
 	if (wait) {
 		err = ceph_wait_on_async_create(inode);
-		if (err)
+		if (err) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 		dirty = try_flush_caps(inode, &flush_tid);
 		if (dirty)
 			err = wait_event_interruptible(ci->i_cap_wq,
@@ -2558,6 +2569,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 			__cap_delay_requeue_front(mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
 	}
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -2605,7 +2617,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 		if (!cf->is_capsnap) {
 			struct cap_msg_args arg;
 
-			doutc(cl, "%p %llx.%llx cap %p tid %llu %s\n",
+			boutc(cl, "%p %llx.%llx cap %p tid %llu %s\n",
 			      inode, ceph_vinop(inode), cap, cf->tid,
 			      ceph_cap_string(cf->caps));
 			__prep_cap(&arg, cap, CEPH_CAP_OP_FLUSH,
@@ -2621,7 +2633,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			struct ceph_cap_snap *capsnap =
 					container_of(cf, struct ceph_cap_snap,
 						    cap_flush);
-			doutc(cl, "%p %llx.%llx capsnap %p tid %llu %s\n",
+			boutc(cl, "%p %llx.%llx capsnap %p tid %llu %s\n",
 			      inode, ceph_vinop(inode), capsnap, cf->tid,
 			      ceph_cap_string(capsnap->dirty));
 
@@ -2652,7 +2664,7 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_client *mdsc,
 	struct ceph_cap *cap;
 	u64 oldest_flush_tid;
 
-	doutc(cl, "mds%d\n", session->s_mds);
+	boutc(cl, "mds%d\n", session->s_mds);
 
 	spin_lock(&mdsc->cap_dirty_lock);
 	oldest_flush_tid = __get_oldest_flush_tid(mdsc);
@@ -2706,7 +2718,7 @@ void ceph_kick_flushing_caps(struct ceph_mds_client *mdsc,
 
 	lockdep_assert_held(&session->s_mutex);
 
-	doutc(cl, "mds%d\n", session->s_mds);
+	boutc(cl, "mds%d\n", session->s_mds);
 
 	spin_lock(&mdsc->cap_dirty_lock);
 	oldest_flush_tid = __get_oldest_flush_tid(mdsc);
@@ -2741,7 +2753,7 @@ void ceph_kick_flushing_inode_caps(struct ceph_mds_session *session,
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	doutc(mdsc->fsc->client, "%p %llx.%llx flushing %s\n",
+	boutc(mdsc->fsc->client, "%p %llx.%llx flushing %s\n",
 	      inode, ceph_vinop(inode),
 	      ceph_cap_string(ci->i_flushing_caps));
 
@@ -2790,7 +2802,7 @@ void ceph_take_cap_refs(struct ceph_inode_info *ci, int got,
 		if (ci->i_wb_ref == 0)
 			ihold(inode);
 		ci->i_wb_ref++;
-		doutc(cl, "%p %llx.%llx wb %d -> %d (?)\n", inode,
+		boutc(cl, "%p %llx.%llx wb %d -> %d (?)\n", inode,
 		      ceph_vinop(inode), ci->i_wb_ref-1, ci->i_wb_ref);
 	}
 }
@@ -2824,7 +2836,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	int have, implemented;
 	bool snap_rwsem_locked = false;
 
-	doutc(cl, "%p %llx.%llx need %s want %s\n", inode,
+	boutc(cl, "%p %llx.%llx need %s want %s\n", inode,
 	      ceph_vinop(inode), ceph_cap_string(need),
 	      ceph_cap_string(want));
 
@@ -2833,7 +2845,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 
 	if ((flags & CHECK_FILELOCK) &&
 	    test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
-		doutc(cl, "%p %llx.%llx error filelock\n", inode,
+		boutc(cl, "%p %llx.%llx error filelock\n", inode,
 		      ceph_vinop(inode));
 		ret = -EIO;
 		goto out_unlock;
@@ -2854,7 +2866,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 
 	if (have & need & CEPH_CAP_FILE_WR) {
 		if (endoff >= 0 && endoff > (loff_t)ci->i_max_size) {
-			doutc(cl, "%p %llx.%llx endoff %llu > maxsize %llu\n",
+			boutc(cl, "%p %llx.%llx endoff %llu > maxsize %llu\n",
 			      inode, ceph_vinop(inode), endoff, ci->i_max_size);
 			if (endoff > ci->i_requested_max_size)
 				ret = ci->i_auth_cap ? -EFBIG : -EUCLEAN;
@@ -2865,7 +2877,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 		 * can get a final snapshot value for size+mtime.
 		 */
 		if (__ceph_have_pending_cap_snap(ci)) {
-			doutc(cl, "%p %llx.%llx cap_snap_pending\n", inode,
+			boutc(cl, "%p %llx.%llx cap_snap_pending\n", inode,
 			      ceph_vinop(inode));
 			goto out_unlock;
 		}
@@ -2884,7 +2896,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 		int not = want & ~(have & need);
 		int revoking = implemented & ~have;
 		int exclude = revoking & not;
-		doutc(cl, "%p %llx.%llx have %s but not %s (revoking %s)\n",
+		boutc(cl, "%p %llx.%llx have %s but not %s (revoking %s)\n",
 		      inode, ceph_vinop(inode), ceph_cap_string(have),
 		      ceph_cap_string(not), ceph_cap_string(revoking));
 		if (!exclude || !(exclude & CEPH_CAP_FILE_BUFFER)) {
@@ -2926,7 +2938,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 			spin_unlock(&s->s_cap_lock);
 		}
 		if (session_readonly) {
-			doutc(cl, "%p %llx.%llx need %s but mds%d readonly\n",
+			boutc(cl, "%p %llx.%llx need %s but mds%d readonly\n",
 			      inode, ceph_vinop(inode), ceph_cap_string(need),
 			      ci->i_auth_cap->mds);
 			ret = -EROFS;
@@ -2934,21 +2946,21 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 		}
 
 		if (ceph_inode_is_shutdown(inode)) {
-			doutc(cl, "%p %llx.%llx inode is shutdown\n",
+			boutc(cl, "%p %llx.%llx inode is shutdown\n",
 			      inode, ceph_vinop(inode));
 			ret = -ESTALE;
 			goto out_unlock;
 		}
 		mds_wanted = __ceph_caps_mds_wanted(ci, false);
 		if (need & ~mds_wanted) {
-			doutc(cl, "%p %llx.%llx need %s > mds_wanted %s\n",
+			boutc(cl, "%p %llx.%llx need %s > mds_wanted %s\n",
 			      inode, ceph_vinop(inode), ceph_cap_string(need),
 			      ceph_cap_string(mds_wanted));
 			ret = -EUCLEAN;
 			goto out_unlock;
 		}
 
-		doutc(cl, "%p %llx.%llx have %s need %s\n", inode,
+		boutc(cl, "%p %llx.%llx have %s need %s\n", inode,
 		      ceph_vinop(inode), ceph_cap_string(have),
 		      ceph_cap_string(need));
 	}
@@ -2965,7 +2977,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	else if (ret == 1)
 		ceph_update_cap_hit(&mdsc->metric);
 
-	doutc(cl, "%p %llx.%llx ret %d got %s\n", inode,
+	boutc(cl, "%p %llx.%llx ret %d got %s\n", inode,
 	      ceph_vinop(inode), ret, ceph_cap_string(*got));
 	return ret;
 }
@@ -2984,7 +2996,7 @@ static void check_max_size(struct inode *inode, loff_t endoff)
 	/* do we need to explicitly request a larger max_size? */
 	spin_lock(&ci->i_ceph_lock);
 	if (endoff >= ci->i_max_size && endoff > ci->i_wanted_max_size) {
-		doutc(cl, "write %p %llx.%llx at large endoff %llu, req max_size\n",
+		boutc(cl, "write %p %llx.%llx at large endoff %llu, req max_size\n",
 		      inode, ceph_vinop(inode), endoff);
 		ci->i_wanted_max_size = endoff;
 	}
@@ -3206,7 +3218,7 @@ static int ceph_try_drop_cap_snap(struct ceph_inode_info *ci,
 
 	if (!capsnap->need_flush &&
 	    !capsnap->writing && !capsnap->dirty_pages) {
-		doutc(cl, "%p follows %llu\n", capsnap, capsnap->follows);
+		boutc(cl, "%p follows %llu\n", capsnap, capsnap->follows);
 		BUG_ON(capsnap->cap_flush.tid > 0);
 		ceph_put_snap_context(capsnap->context);
 		if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
@@ -3260,7 +3272,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 			put++;
 			check_flushsnaps = true;
 		}
-		doutc(cl, "%p %llx.%llx wb %d -> %d (?)\n", inode,
+		boutc(cl, "%p %llx.%llx wb %d -> %d (?)\n", inode,
 		      ceph_vinop(inode), ci->i_wb_ref+1, ci->i_wb_ref);
 	}
 	if (had & CEPH_CAP_FILE_WR) {
@@ -3301,7 +3313,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
-	doutc(cl, "%p %llx.%llx had %s%s%s\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx had %s%s%s\n", inode, ceph_vinop(inode),
 	      ceph_cap_string(had), last ? " last" : "", put ? " put" : "");
 
 	switch (mode) {
@@ -3371,7 +3383,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 			ceph_put_snap_context(ci->i_head_snapc);
 			ci->i_head_snapc = NULL;
 		}
-		doutc(cl, "on %p %llx.%llx head %d/%d -> %d/%d %s\n",
+		boutc(cl, "on %p %llx.%llx head %d/%d -> %d/%d %s\n",
 		      inode, ceph_vinop(inode), ci->i_wrbuffer_ref+nr,
 		      ci->i_wrbuffer_ref_head+nr, ci->i_wrbuffer_ref,
 		      ci->i_wrbuffer_ref_head, last ? " LAST" : "");
@@ -3404,7 +3416,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				}
 			}
 		}
-		doutc(cl, "%p %llx.%llx cap_snap %p snap %lld %d/%d -> %d/%d %s%s\n",
+		boutc(cl, "%p %llx.%llx cap_snap %p snap %lld %d/%d -> %d/%d %s%s\n",
 		      inode, ceph_vinop(inode), capsnap, capsnap->context->seq,
 		      ci->i_wrbuffer_ref+nr, capsnap->dirty_pages + nr,
 		      ci->i_wrbuffer_ref, capsnap->dirty_pages,
@@ -3435,7 +3447,7 @@ static void invalidate_aliases(struct inode *inode)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn, *prev = NULL;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
@@ -3520,10 +3532,10 @@ static void handle_cap_grant(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
+	boutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
 	      ceph_vinop(inode), cap, session->s_mds, seq,
 	      ceph_cap_string(newcaps));
-	doutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
+	boutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
 	      max_size, i_size_read(inode));
 
 
@@ -3584,7 +3596,7 @@ static void handle_cap_grant(struct inode *inode,
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
-		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
 		      ceph_vinop(inode), inode->i_mode,
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kgid(&init_user_ns, inode->i_gid));
@@ -3612,7 +3624,7 @@ static void handle_cap_grant(struct inode *inode,
 		u64 version = le64_to_cpu(grant->xattr_version);
 
 		if (version > ci->i_xattrs.version) {
-			doutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
+			boutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
 			      version, inode, ceph_vinop(inode), len);
 			if (ci->i_xattrs.blob)
 				ceph_buffer_put(ci->i_xattrs.blob);
@@ -3664,7 +3676,7 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
 		if (max_size != ci->i_max_size) {
-			doutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
+			boutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
 			      max_size);
 			ci->i_max_size = max_size;
 			if (max_size >= ci->i_wanted_max_size) {
@@ -3679,7 +3691,7 @@ static void handle_cap_grant(struct inode *inode,
 	wanted = __ceph_caps_wanted(ci);
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
-	doutc(cl, " my wanted = %s, used = %s, dirty %s\n",
+	boutc(cl, " my wanted = %s, used = %s, dirty %s\n",
 	      ceph_cap_string(wanted), ceph_cap_string(used),
 	      ceph_cap_string(dirty));
 
@@ -3702,7 +3714,7 @@ static void handle_cap_grant(struct inode *inode,
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
 
-		doutc(cl, "revocation: %s -> %s (revoking %s)\n",
+		boutc(cl, "revocation: %s -> %s (revoking %s)\n",
 		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
 		      ceph_cap_string(revoking));
 		if (S_ISREG(inode->i_mode) &&
@@ -3724,11 +3736,11 @@ static void handle_cap_grant(struct inode *inode,
 		cap->issued = newcaps;
 		cap->implemented |= newcaps;
 	} else if (cap->issued == newcaps) {
-		doutc(cl, "caps unchanged: %s -> %s\n",
+		boutc(cl, "caps unchanged: %s -> %s\n",
 		      ceph_cap_string(cap->issued),
 		      ceph_cap_string(newcaps));
 	} else {
-		doutc(cl, "grant: %s -> %s\n", ceph_cap_string(cap->issued),
+		boutc(cl, "grant: %s -> %s\n", ceph_cap_string(cap->issued),
 		      ceph_cap_string(newcaps));
 		/* non-auth MDS is revoking the newly grant caps ? */
 		if (cap == ci->i_auth_cap &&
@@ -3863,7 +3875,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
 	      inode, ceph_vinop(inode), session->s_mds, seq,
 	      ceph_cap_string(dirty), ceph_cap_string(cleaned),
 	      ceph_cap_string(ci->i_flushing_caps),
@@ -3887,16 +3899,16 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 					    &list_first_entry(&session->s_cap_flushing,
 							      struct ceph_inode_info,
 							      i_flushing_item)->netfs.inode;
-				doutc(cl, " mds%d still flushing cap on %p %llx.%llx\n",
+				boutc(cl, " mds%d still flushing cap on %p %llx.%llx\n",
 				      session->s_mds, inode, ceph_vinop(inode));
 			}
 		}
 		mdsc->num_cap_flushing--;
-		doutc(cl, " %p %llx.%llx now !flushing\n", inode,
+		boutc(cl, " %p %llx.%llx now !flushing\n", inode,
 		      ceph_vinop(inode));
 
 		if (ci->i_dirty_caps == 0) {
-			doutc(cl, " %p %llx.%llx now clean\n", inode,
+			boutc(cl, " %p %llx.%llx now clean\n", inode,
 			      ceph_vinop(inode));
 			BUG_ON(!list_empty(&ci->i_dirty_item));
 			drop = true;
@@ -3941,7 +3953,7 @@ void __ceph_remove_capsnap(struct inode *inode, struct ceph_cap_snap *capsnap,
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	doutc(cl, "removing capsnap %p, %p %llx.%llx ci %p\n", capsnap,
+	boutc(cl, "removing capsnap %p, %p %llx.%llx ci %p\n", capsnap,
 	      inode, ceph_vinop(inode), ci);
 
 	list_del_init(&capsnap->ci_item);
@@ -3988,14 +4000,14 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
-	doutc(cl, "%p %llx.%llx ci %p mds%d follows %lld\n", inode,
+	boutc(cl, "%p %llx.%llx ci %p mds%d follows %lld\n", inode,
 	      ceph_vinop(inode), ci, session->s_mds, follows);
 
 	spin_lock(&ci->i_ceph_lock);
 	list_for_each_entry(iter, &ci->i_cap_snaps, ci_item) {
 		if (iter->follows == follows) {
 			if (iter->cap_flush.tid != flush_tid) {
-				doutc(cl, " cap_snap %p follows %lld "
+				boutc(cl, " cap_snap %p follows %lld "
 				      "tid %lld != %lld\n", iter,
 				      follows, flush_tid,
 				      iter->cap_flush.tid);
@@ -4004,7 +4016,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 			capsnap = iter;
 			break;
 		} else {
-			doutc(cl, " skipping cap_snap %p follows %lld\n",
+			boutc(cl, " skipping cap_snap %p follows %lld\n",
 			      iter, iter->follows);
 		}
 	}
@@ -4057,7 +4069,7 @@ static bool handle_cap_trunc(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
 	      inode, ceph_vinop(inode), mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
@@ -4096,7 +4108,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), target, t_issue_seq, t_mseq);
 retry:
 	down_read(&mdsc->snap_rwsem);
@@ -4131,7 +4143,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_issue_seq) < 0) {
-			doutc(cl, " updating import cap %p mds%d\n", tcap,
+			boutc(cl, " updating import cap %p mds%d\n", tcap,
 			      target);
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_issue_seq - 1;
@@ -4238,7 +4250,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), peer, piseq, pmseq);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
@@ -4265,7 +4277,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
 	if (ocap && ocap->cap_id == p_cap_id) {
-		doutc(cl, " remove export cap %p mds%d flags %d\n",
+		boutc(cl, " remove export cap %p mds%d flags %d\n",
 		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
 		    (ocap->seq != piseq ||
@@ -4524,7 +4536,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ceph_inode(inode), session->s_mds);
 	if (!cap) {
-		doutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
+		boutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
 		      inode, ceph_ino(inode), ceph_snap(inode),
 		      session->s_mds);
 		spin_unlock(&ci->i_ceph_lock);
@@ -4628,14 +4640,14 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 	unsigned long loop_start = jiffies;
 	unsigned long delay = 0;
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 	spin_lock(&mdsc->cap_delay_lock);
 	while (!list_empty(&mdsc->cap_delay_list)) {
 		ci = list_first_entry(&mdsc->cap_delay_list,
 				      struct ceph_inode_info,
 				      i_cap_delay_list);
 		if (time_before(loop_start, ci->i_hold_caps_max - delay_max)) {
-			doutc(cl, "caps added recently.  Exiting loop");
+			boutc(cl, "caps added recently.  Exiting loop");
 			delay = ci->i_hold_caps_max;
 			break;
 		}
@@ -4647,7 +4659,7 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 		inode = igrab(&ci->netfs.inode);
 		if (inode) {
 			spin_unlock(&mdsc->cap_delay_lock);
-			doutc(cl, "on %p %llx.%llx\n", inode,
+			boutc(cl, "on %p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			ceph_check_caps(ci, 0);
 			iput(inode);
@@ -4663,7 +4675,7 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 			break;
 	}
 	spin_unlock(&mdsc->cap_delay_lock);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 
 	return delay;
 }
@@ -4678,14 +4690,14 @@ static void flush_dirty_session_caps(struct ceph_mds_session *s)
 	struct ceph_inode_info *ci;
 	struct inode *inode;
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 	spin_lock(&mdsc->cap_dirty_lock);
 	while (!list_empty(&s->s_cap_dirty)) {
 		ci = list_first_entry(&s->s_cap_dirty, struct ceph_inode_info,
 				      i_dirty_item);
 		inode = &ci->netfs.inode;
 		ihold(inode);
-		doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+		boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 		spin_unlock(&mdsc->cap_dirty_lock);
 		ceph_wait_on_async_create(inode);
 		ceph_check_caps(ci, CHECK_CAPS_FLUSH);
@@ -4693,7 +4705,7 @@ static void flush_dirty_session_caps(struct ceph_mds_session *s)
 		spin_lock(&mdsc->cap_dirty_lock);
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 void ceph_flush_dirty_caps(struct ceph_mds_client *mdsc)
@@ -4709,12 +4721,12 @@ static void flush_cap_releases(struct ceph_mds_session *s)
 	struct ceph_mds_client *mdsc = s->s_mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 	spin_lock(&s->s_cap_lock);
 	if (s->s_num_cap_releases)
 		ceph_flush_session_cap_releases(mdsc, s);
 	spin_unlock(&s->s_cap_lock);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 
 }
 
@@ -4822,7 +4834,7 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
 			struct ceph_mds_client *mdsc =
 				ceph_inode_to_fs_client(inode)->mdsc;
 
-			doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
+			boutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			spin_lock(&mdsc->cap_delay_lock);
 			set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
@@ -4865,7 +4877,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
 
-	doutc(cl, "%p %llx.%llx mds%d used|dirty %s drop %s unless %s\n",
+	boutc(cl, "%p %llx.%llx mds%d used|dirty %s drop %s unless %s\n",
 	      inode, ceph_vinop(inode), mds, ceph_cap_string(used|dirty),
 	      ceph_cap_string(drop), ceph_cap_string(unless));
 
@@ -4889,7 +4901,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 		if (force || (cap->issued & drop)) {
 			if (cap->issued & drop) {
 				int wanted = __ceph_caps_wanted(ci);
-				doutc(cl, "%p %llx.%llx cap %p %s -> %s, "
+				boutc(cl, "%p %llx.%llx cap %p %s -> %s, "
 				      "wanted %s -> %s\n", inode,
 				      ceph_vinop(inode), cap,
 				      ceph_cap_string(cap->issued),
@@ -4904,7 +4916,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 				    !(wanted & CEPH_CAP_ANY_FILE_WR))
 					ci->i_requested_max_size = 0;
 			} else {
-				doutc(cl, "%p %llx.%llx cap %p %s (force)\n",
+				boutc(cl, "%p %llx.%llx cap %p %s (force)\n",
 				      inode, ceph_vinop(inode), cap,
 				      ceph_cap_string(cap->issued));
 			}
@@ -4921,7 +4933,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 			*p += sizeof(*rel);
 			ret = 1;
 		} else {
-			doutc(cl, "%p %llx.%llx cap %p %s (noop)\n",
+			boutc(cl, "%p %llx.%llx cap %p %s (noop)\n",
 			      inode, ceph_vinop(inode), cap,
 			      ceph_cap_string(cap->issued));
 		}
@@ -4972,7 +4984,7 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
 		int len = dentry->d_name.len;
-		doutc(cl, "%p mds%d seq %d\n",  dentry, mds,
+		boutc(cl, "%p mds%d seq %d\n",  dentry, mds,
 		      (int)di->lease_seq);
 		rel->dname_seq = cpu_to_le32(di->lease_seq);
 		__ceph_mdsc_drop_dentry_lease(dentry);
@@ -5000,7 +5012,7 @@ static int remove_capsnaps(struct ceph_mds_client *mdsc, struct inode *inode)
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	doutc(cl, "removing capsnaps, ci is %p, %p %llx.%llx\n",
+	boutc(cl, "removing capsnaps, ci is %p, %p %llx.%llx\n",
 	      ci, inode, ceph_vinop(inode));
 
 	while (!list_empty(&ci->i_cap_snaps)) {
@@ -5028,7 +5040,7 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	doutc(cl, "removing cap %p, ci is %p, %p %llx.%llx\n",
+	boutc(cl, "removing cap %p, ci is %p, %p %llx.%llx\n",
 	      cap, ci, inode, ceph_vinop(inode));
 
 	is_auth = (cap == ci->i_auth_cap);
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9b79a5eaca93..8e86e4df22bd 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -138,7 +138,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 	__insert_snap_realm(&mdsc->snap_realms, realm);
 	mdsc->num_snap_realms++;
 
-	doutc(mdsc->fsc->client, "%llx %p\n", realm->ino, realm);
+	boutc(mdsc->fsc->client, "%llx %p\n", realm->ino, realm);
 	return realm;
 }
 
@@ -163,7 +163,7 @@ static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
 		else if (ino > r->ino)
 			n = n->rb_right;
 		else {
-			doutc(cl, "%llx %p\n", r->ino, r);
+			boutc(cl, "%llx %p\n", r->ino, r);
 			return r;
 		}
 	}
@@ -192,7 +192,7 @@ static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
 	struct ceph_client *cl = mdsc->fsc->client;
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
 
-	doutc(cl, "%p %llx\n", realm, realm->ino);
+	boutc(cl, "%p %llx\n", realm, realm->ino);
 
 	rb_erase(&realm->node, &mdsc->snap_realms);
 	mdsc->num_snap_realms--;
@@ -306,7 +306,7 @@ static int adjust_snap_realm_parent(struct ceph_mds_client *mdsc,
 		if (IS_ERR(parent))
 			return PTR_ERR(parent);
 	}
-	doutc(cl, "%llx %p: %llx %p -> %llx %p\n", realm->ino, realm,
+	boutc(cl, "%llx %p: %llx %p -> %llx %p\n", realm->ino, realm,
 	      realm->parent_ino, realm->parent, parentino, parent);
 	if (realm->parent) {
 		list_del_init(&realm->child_item);
@@ -365,7 +365,7 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
 	    realm->cached_context->seq == realm->seq &&
 	    (!parent ||
 	     realm->cached_context->seq >= parent->cached_context->seq)) {
-		doutc(cl, "%llx %p: %p seq %lld (%u snaps) (unchanged)\n",
+		boutc(cl, "%llx %p: %p seq %lld (%u snaps) (unchanged)\n",
 		      realm->ino, realm, realm->cached_context,
 		      realm->cached_context->seq,
 		      (unsigned int)realm->cached_context->num_snaps);
@@ -405,7 +405,7 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
 
 	sort(snapc->snaps, num, sizeof(u64), cmpu64_rev, NULL);
 	snapc->num_snaps = num;
-	doutc(cl, "%llx %p: %p seq %lld (%u snaps)\n", realm->ino, realm,
+	boutc(cl, "%llx %p: %p seq %lld (%u snaps)\n", realm->ino, realm,
 	      snapc, snapc->seq, (unsigned int) snapc->num_snaps);
 
 	ceph_put_snap_context(realm->cached_context);
@@ -460,7 +460,7 @@ static void rebuild_snap_realms(struct ceph_mds_client *mdsc,
 
 		last = build_snap_context(mdsc, _realm, &realm_queue,
 					  dirty_realms);
-		doutc(cl, "%llx %p, %s\n", realm->ino, realm,
+		boutc(cl, "%llx %p, %s\n", realm->ino, realm,
 		      last > 0 ? "is deferred" : !last ? "succeeded" : "failed");
 
 		/* is any child in the list ? */
@@ -557,13 +557,13 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 		   as no new writes are allowed to start when pending, so any
 		   writes in progress now were started before the previous
 		   cap_snap.  lucky us. */
-		doutc(cl, "%p %llx.%llx already pending\n", inode,
+		boutc(cl, "%p %llx.%llx already pending\n", inode,
 		      ceph_vinop(inode));
 		goto update_snapc;
 	}
 	if (ci->i_wrbuffer_ref_head == 0 &&
 	    !(dirty & (CEPH_CAP_ANY_EXCL|CEPH_CAP_FILE_WR))) {
-		doutc(cl, "%p %llx.%llx nothing dirty|writing\n", inode,
+		boutc(cl, "%p %llx.%llx nothing dirty|writing\n", inode,
 		      ceph_vinop(inode));
 		goto update_snapc;
 	}
@@ -584,13 +584,13 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 	} else {
 		if (!(used & CEPH_CAP_FILE_WR) &&
 		    ci->i_wrbuffer_ref_head == 0) {
-			doutc(cl, "%p %llx.%llx no new_snap|dirty_page|writing\n",
+			boutc(cl, "%p %llx.%llx no new_snap|dirty_page|writing\n",
 			      inode, ceph_vinop(inode));
 			goto update_snapc;
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx cap_snap %p queuing under %p %s %s\n",
+	boutc(cl, "%p %llx.%llx cap_snap %p queuing under %p %s %s\n",
 	      inode, ceph_vinop(inode), capsnap, old_snapc,
 	      ceph_cap_string(dirty), capsnap->need_flush ? "" : "no_flush");
 	ihold(inode);
@@ -624,7 +624,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 	list_add_tail(&capsnap->ci_item, &ci->i_cap_snaps);
 
 	if (used & CEPH_CAP_FILE_WR) {
-		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p seq %llu used WR,"
+		boutc(cl, "%p %llx.%llx cap_snap %p snapc %p seq %llu used WR,"
 		      " now pending\n", inode, ceph_vinop(inode), capsnap,
 		      old_snapc, old_snapc->seq);
 		capsnap->writing = 1;
@@ -643,7 +643,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 		ci->i_head_snapc = NULL;
 	} else {
 		ci->i_head_snapc = ceph_get_snap_context(new_snapc);
-		doutc(cl, " new snapc is %p\n", new_snapc);
+		boutc(cl, " new snapc is %p\n", new_snapc);
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -677,7 +677,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	capsnap->truncate_size = ci->i_truncate_size;
 	capsnap->truncate_seq = ci->i_truncate_seq;
 	if (capsnap->dirty_pages) {
-		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s "
+		boutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s "
 		      "s=%llu still has %d dirty pages\n", inode,
 		      ceph_vinop(inode), capsnap, capsnap->context,
 		      capsnap->context->seq,
@@ -691,7 +691,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	 * And trigger to flush the buffer immediately.
 	 */
 	if (ci->i_wrbuffer_ref) {
-		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s "
+		boutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s "
 		      "s=%llu used WRBUFFER, delaying\n", inode,
 		      ceph_vinop(inode), capsnap, capsnap->context,
 		      capsnap->context->seq, ceph_cap_string(capsnap->dirty),
@@ -701,7 +701,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	}
 
 	set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
-	doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu\n",
+	boutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu\n",
 	      inode, ceph_vinop(inode), capsnap, capsnap->context,
 	      capsnap->context->seq, ceph_cap_string(capsnap->dirty),
 	      capsnap->size);
@@ -727,7 +727,7 @@ static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
 	struct inode *lastinode = NULL;
 	struct ceph_cap_snap *capsnap = NULL;
 
-	doutc(cl, "%p %llx inode\n", realm, realm->ino);
+	boutc(cl, "%p %llx inode\n", realm, realm->ino);
 
 	spin_lock(&realm->inodes_with_caps_lock);
 	list_for_each_entry(ci, &realm->inodes_with_caps, i_snap_realm_item) {
@@ -766,7 +766,7 @@ static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
 
 	if (capsnap)
 		kmem_cache_free(ceph_cap_snap_cachep, capsnap);
-	doutc(cl, "%p %llx done\n", realm, realm->ino);
+	boutc(cl, "%p %llx done\n", realm, realm->ino);
 }
 
 /*
@@ -795,7 +795,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
 
-	doutc(cl, "deletion=%d\n", deletion);
+	boutc(cl, "deletion=%d\n", deletion);
 more:
 	realm = NULL;
 	rebuild_snapcs = 0;
@@ -825,7 +825,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	rebuild_snapcs += err;
 
 	if (le64_to_cpu(ri->seq) > realm->seq) {
-		doutc(cl, "updating %llx %p %lld -> %lld\n", realm->ino,
+		boutc(cl, "updating %llx %p %lld -> %lld\n", realm->ino,
 		      realm, realm->seq, le64_to_cpu(ri->seq));
 		/* update realm parameters, snap lists */
 		realm->seq = le64_to_cpu(ri->seq);
@@ -849,15 +849,15 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 
 		rebuild_snapcs = 1;
 	} else if (!realm->cached_context) {
-		doutc(cl, "%llx %p seq %lld new\n", realm->ino, realm,
+		boutc(cl, "%llx %p seq %lld new\n", realm->ino, realm,
 		      realm->seq);
 		rebuild_snapcs = 1;
 	} else {
-		doutc(cl, "%llx %p seq %lld unchanged\n", realm->ino, realm,
+		boutc(cl, "%llx %p seq %lld unchanged\n", realm->ino, realm,
 		      realm->seq);
 	}
 
-	doutc(cl, "done with %llx %p, rebuild_snapcs=%d, %p %p\n", realm->ino,
+	boutc(cl, "done with %llx %p, rebuild_snapcs=%d, %p %p\n", realm->ino,
 	      realm, rebuild_snapcs, p, e);
 
 	/*
@@ -946,7 +946,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 	struct inode *inode;
 	struct ceph_mds_session *session = NULL;
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 	spin_lock(&mdsc->snap_flush_lock);
 	while (!list_empty(&mdsc->snap_flush_list)) {
 		ci = list_first_entry(&mdsc->snap_flush_list,
@@ -961,7 +961,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 	spin_unlock(&mdsc->snap_flush_lock);
 
 	ceph_put_mds_session(session);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 /**
@@ -1048,7 +1048,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	trace_len = le32_to_cpu(h->trace_len);
 	p += sizeof(*h);
 
-	doutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
+	boutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
 	      ceph_snap_op_name(op), split, trace_len);
 
 	down_write(&mdsc->snap_rwsem);
@@ -1080,7 +1080,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 				goto out;
 		}
 
-		doutc(cl, "splitting snap_realm %llx %p\n", realm->ino, realm);
+		boutc(cl, "splitting snap_realm %llx %p\n", realm->ino, realm);
 		for (i = 0; i < num_split_inos; i++) {
 			struct ceph_vino vino = {
 				.ino = le64_to_cpu(split_inos[i]),
@@ -1105,12 +1105,12 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 			 */
 			if (ci->i_snap_realm->created >
 			    le64_to_cpu(ri->created)) {
-				doutc(cl, " leaving %p %llx.%llx in newer realm %llx %p\n",
+				boutc(cl, " leaving %p %llx.%llx in newer realm %llx %p\n",
 				      inode, ceph_vinop(inode), ci->i_snap_realm->ino,
 				      ci->i_snap_realm);
 				goto skip_inode;
 			}
-			doutc(cl, " will move %p %llx.%llx to split realm %llx %p\n",
+			boutc(cl, " will move %p %llx.%llx to split realm %llx %p\n",
 			      inode, ceph_vinop(inode), realm->ino, realm);
 
 			ceph_get_snap_realm(mdsc, realm);
@@ -1211,7 +1211,7 @@ struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
 	}
 	spin_unlock(&mdsc->snapid_map_lock);
 	if (exist) {
-		doutc(cl, "found snapid map %llx -> %x\n", exist->snap,
+		boutc(cl, "found snapid map %llx -> %x\n", exist->snap,
 		      exist->dev);
 		return exist;
 	}
@@ -1256,12 +1256,12 @@ struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
 	if (exist) {
 		free_anon_bdev(sm->dev);
 		kfree(sm);
-		doutc(cl, "found snapid map %llx -> %x\n", exist->snap,
+		boutc(cl, "found snapid map %llx -> %x\n", exist->snap,
 		      exist->dev);
 		return exist;
 	}
 
-	doutc(cl, "create snapid map %llx -> %x\n", sm->snap, sm->dev);
+	boutc(cl, "create snapid map %llx -> %x\n", sm->snap, sm->dev);
 	return sm;
 }
 
@@ -1308,7 +1308,7 @@ void ceph_trim_snapid_map(struct ceph_mds_client *mdsc)
 	while (!list_empty(&to_free)) {
 		sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
 		list_del(&sm->lru);
-		doutc(cl, "trim snapid map %llx -> %x\n", sm->snap, sm->dev);
+		boutc(cl, "trim snapid map %llx -> %x\n", sm->snap, sm->dev);
 		free_anon_bdev(sm->dev);
 		kfree(sm);
 	}
-- 
2.34.1

