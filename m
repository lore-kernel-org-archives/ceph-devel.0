Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429D39CCFE
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230607; cv=none; b=BQJmuObEUkUhlw+vhbty8saCzec3AgqRk4gSmAKhD2dvNsZWPRxxOCFeUDrZG8Y4JULOcc0K7ks7St4AtMlMiDUHQ9QtiITn/1VV0HuYG+/V458dQkTt1WGuNXvHmQITxFTc9IIPEp/LhRRX5EV2cSO0hf+fEo5AS0PEv0oQdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230607; c=relaxed/simple;
	bh=BKJRVBxRb59RorqHwYL0nn4Evbqf/MDyu8rdYcmfpYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAPjeF1mtdurjNqdTlL0Pu190TVGUS/bNY+WSpWmaKX5DF1nQeWDWITBNF0xw84DgEKfTvMMtDhvIe2vaOvG5Nwm31jLs1QUz/AQuIr2v0KddE4uHGqinruzXKLtbfSqtyEXSEP4wr51/wiVjS1DvI0kaCHUI+Kuxq0QvXnitDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij8zoHOt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYImvjL3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij8zoHOt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYImvjL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2H+4XIx22NrQ46wVqWA7sU8/A4pdpb8T2S41zCGr/8=;
	b=Ij8zoHOtxJxJE04fU8dBDC231GX2/SXCAx0UvUA/eEAfoHSNF9KfjxDYwVQPhFdU2zn0wR
	YquZaGbHb13IatOQ+ILDqmsy5z8Mn4OzXCEiMiNfpvmc5P34Rjn3KDzOxbncXPh5ooWNUy
	vitmnrmgtKB4yaqSoYjBmWVN2MHFeH8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-JRIxGNPsOG6g_GU9UqRagg-1; Thu, 20 Aug 2026 08:56:40 -0400
X-MC-Unique: JRIxGNPsOG6g_GU9UqRagg-1
X-Mimecast-MFC-AGG-ID: JRIxGNPsOG6g_GU9UqRagg_1787230599
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a409088b6eso1436165a12.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230599; x=1787835399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2H+4XIx22NrQ46wVqWA7sU8/A4pdpb8T2S41zCGr/8=;
        b=cYImvjL3bypV5GOzTfCHfiWwQKXU6yVCMEq7P9TMWJ8kvdTbmigdi1i4YJTux3ovB0
         QazXYVZpWibHuVM0j+JUU6aymRELh3GqX2CNhFPMMfR70e++H2iDlIb4mpX4IS5l2yl+
         v01U4PRso9i5GxBrcDYz2bHg1cZkDnKxa2slzS3tsw+NFklstdLQHL6RHaWFotFDk/Wp
         9m8YlQqQ+uctw5L+IRP1xMN4CxgG6lMZCPzknHPitp9TMaZvS+PSuXsIC0cQmycBhVRo
         hgM/Zw/drIiuFV5YOVsq0I92VpRP2NCvet/Hzf6r337uWSlTPeRVjiDPXNyfevRB1u4X
         o5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230599; x=1787835399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k2H+4XIx22NrQ46wVqWA7sU8/A4pdpb8T2S41zCGr/8=;
        b=iyMTQ5wmLeCJSE8/t/B4mFIBNkRp1+9q0dKVB6SUlGMftGIZ6u62RY6p24RD7yjTk1
         M8rPqavIkf8q3iVhHPpx/sGFeWH8DZWekjJo2f+z49sXEYjxJwPq9Yn32ppwxXvJ3VPP
         vIrD/3U1pdCD0PtzT7e8XneQ3SAsywSsngyG2Lb03jodP7kArep9EHdgPnlgALSfISae
         5NMj27qHRIXQFqq68mmZB4NlT5r23UeJmvZOVSwxjFW/Hs3jUcmLMktF9VzNdBztaZrf
         m++z0/5LtwbgYYhO3Xm6PF5mGRjNmn7xEWKL36p8Bt2FevGzTnVdBD6MSVVrLmdkqQzq
         ewZQ==
X-Gm-Message-State: AFuF++mgaltSDGUl2vx7NrI6ZfWm5lB9/lyGdgSp/Z3aywzbNnzt8WZM
	/cCFaKLJk70p87bjb8XwZXBxyoPPzSqFMIGapO97vVB+R9mnh6W+DHUdGbA8txSgiK7Qru7Ac9m
	zj1kyjXJIl6d+5elu5CJ+m5OnPEkUbB/UYxNfrR+1p95qMOJhs1dNXrdhbMdWVshoqRb7m/n0MG
	yNSH24c/sbmBe0fQl/3tjOOJk7siymYXz/DZMhHZNQfMVUVpWzBw==
X-Gm-Gg: AR+sD11P7OqlSdNYuft8eF9sbcUs/qpHk57VSaDTjgchYb+oprj6b5JZNLwxt6GlxUZ
	qYHxORMeBnit8tKysKnxDYdkzb0SO9SWDdjTz/BXSNqpx09K8CkpbEenbZrxd6tejUeYfWzRkPY
	DzcolDJ8D9rsGh8w9RFIXM/4ZgWuar3dsfw2cMBf38AxkGUdgN1ZFx+7QCYiv99jy5zQ1vPcQkk
	KaMFMkbfjk2cxOBVCr2txnkHBH04OR9KXgMDFLz4K+81yLtCPe9m8l7cV7Z2h7UlH+oAYhMSGB+
	wVq6JyvRLK0Hv9gh+aFO2UFbDOWUuti1J5G/kw8XjYqi/nM5LQo97sS6e/3nWWzsuFn7dF/DI7/
	sZhIeCJzy4SkIqo3aVrR0e+UG19aNydg1gw==
X-Received: by 2002:a05:6402:380c:b0:697:eb97:a4ed with SMTP id 4fb4d7f45d1cf-6a4112dc8e0mr3486459a12.7.1787230598914;
        Thu, 20 Aug 2026 05:56:38 -0700 (PDT)
X-Received: by 2002:a05:6402:380c:b0:697:eb97:a4ed with SMTP id 4fb4d7f45d1cf-6a4112dc8e0mr3486418a12.7.1787230598369;
        Thu, 20 Aug 2026 05:56:38 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:37 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 13/14] ceph: convert capability and snapshot paths to bout
Date: Thu, 20 Aug 2026 12:56:16 +0000
Message-Id: <f799e5a5b439ec9ee57926c5d4aafd6a9ecca7b4.1787229471.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787229471.git.amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dout()/doutc() with bout()/boutc() only on MDS/VFS paths that
already bind a BLOG context via ceph_blog_enter() (ceph_handle_caps and
its handle_cap_* helpers, ceph_handle_snap/flush_snaps, ceph_fsync,
ceph_write_inode). Leave enter-less helpers and async/workqueue sites
on doutc to avoid false binary coverage (spec P2.2).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c | 112 ++++++++++++++++++++++++++++++-------------------
 fs/ceph/snap.c |  17 +++++---
 2 files changed, 81 insertions(+), 48 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 0b65eacda382..b87c75ef7ecf 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -334,6 +334,7 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_cap *cap = NULL;
+	int count, total, use, resv, avail;
 
 	/* temporary, until we do something about cap import/export */
 	if (!ctx) {
@@ -364,9 +365,11 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 	}
 
 	spin_lock(&mdsc->caps_list_lock);
-	doutc(cl, "ctx=%p (%d) %d = %d used + %d resv + %d avail\n", ctx,
-	      ctx->count, mdsc->caps_total_count, mdsc->caps_use_count,
-	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	count = ctx->count;
+	total = mdsc->caps_total_count;
+	use = mdsc->caps_use_count;
+	resv = mdsc->caps_reserve_count;
+	avail = mdsc->caps_avail_count;
 	BUG_ON(!ctx->count);
 	BUG_ON(ctx->count > mdsc->caps_reserve_count);
 	BUG_ON(list_empty(&mdsc->caps_list));
@@ -382,17 +385,21 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 	BUG_ON(mdsc->caps_total_count != mdsc->caps_use_count +
 	       mdsc->caps_reserve_count + mdsc->caps_avail_count);
 	spin_unlock(&mdsc->caps_list_lock);
+	doutc(cl, "ctx=%p (%d) %d = %d used + %d resv + %d avail\n", ctx,
+	      count, total, use, resv, avail);
 	return cap;
 }
 
 void ceph_put_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	int total, use, resv, avail;
 
 	spin_lock(&mdsc->caps_list_lock);
-	doutc(cl, "%p %d = %d used + %d resv + %d avail\n", cap,
-	      mdsc->caps_total_count, mdsc->caps_use_count,
-	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	total = mdsc->caps_total_count;
+	use = mdsc->caps_use_count;
+	resv = mdsc->caps_reserve_count;
+	avail = mdsc->caps_avail_count;
 	mdsc->caps_use_count--;
 	/*
 	 * Keep some preallocated caps around (ceph_min_count), to
@@ -410,6 +417,8 @@ void ceph_put_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap)
 	BUG_ON(mdsc->caps_total_count != mdsc->caps_use_count +
 	       mdsc->caps_reserve_count + mdsc->caps_avail_count);
 	spin_unlock(&mdsc->caps_list_lock);
+	doutc(cl, "%p %d = %d used + %d resv + %d avail\n", cap,
+	      total, use, resv, avail);
 }
 
 void ceph_reservation_status(struct ceph_fs_client *fsc,
@@ -547,7 +556,7 @@ static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 {
 	struct inode *inode = &ci->netfs.inode;
 
-	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	spin_lock(&mdsc->cap_delay_lock);
 	set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
 	if (!list_empty(&ci->i_cap_delay_list))
@@ -872,6 +881,7 @@ static void __touch_cap(struct ceph_inode_info *ci, struct ceph_cap *cap)
 	struct ceph_mds_session *s = cap->session;
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	static u8 skip_counter;
+	bool iterating;
 
 	if (data_race(++skip_counter))
 		/* skip this call most of the time to reduce lock
@@ -881,15 +891,17 @@ static void __touch_cap(struct ceph_inode_info *ci, struct ceph_cap *cap)
 		return;
 
 	spin_lock(&s->s_cap_lock);
-	if (!s->s_cap_iterator) {
+	iterating = !!s->s_cap_iterator;
+	if (!iterating)
+		list_move_tail(&cap->session_caps, &s->s_caps);
+	spin_unlock(&s->s_cap_lock);
+
+	if (!iterating)
 		doutc(cl, "%p %llx.%llx cap %p mds%d\n", inode,
 		      ceph_vinop(inode), cap, s->s_mds);
-		list_move_tail(&cap->session_caps, &s->s_caps);
-	} else {
+	else
 		doutc(cl, "%p %llx.%llx cap %p mds%d NOP, iterating over caps\n",
 		      inode, ceph_vinop(inode), cap, s->s_mds);
-	}
-	spin_unlock(&s->s_cap_lock);
 }
 
 /*
@@ -1238,7 +1250,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	struct ceph_fs_client *fsc;
 
 	if (ceph_cap_is_removed(cap)) {
-		doutc(mdsc->fsc->client, "inode is NULL\n");
+		doutc(mdsc->fsc->client, "cap already removed\n");
 		return;
 	}
 
@@ -2492,7 +2504,7 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 		kfree(sessions);
 	}
 
-	doutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
+	boutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
 	      ceph_vinop(inode), req1 ? req1->r_tid : 0ULL,
 	      req2 ? req2->r_tid : 0ULL);
 	if (req1) {
@@ -2519,13 +2531,17 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
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
@@ -2537,7 +2553,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	dirty = try_flush_caps(inode, &flush_tid);
-	doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
+	boutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
 
 	err = flush_mdlog_and_wait_inode_unsafe_requests(inode);
 
@@ -2558,8 +2574,9 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (err < 0)
 		ret = err;
 out:
-	doutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
 	      datasync ? " datasync" : "", ret);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2571,19 +2588,25 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
+
+	ceph_blog_enter(fsc, &__ji);
 
-	doutc(cl, "%p %llx.%llx wait=%d\n", inode, ceph_vinop(inode), wait);
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
@@ -2597,6 +2620,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 			__cap_delay_requeue_front(mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
 	}
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -3513,7 +3537,7 @@ static void invalidate_aliases(struct inode *inode)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn, *prev = NULL;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
@@ -3598,10 +3622,10 @@ static void handle_cap_grant(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
+	boutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
 	      ceph_vinop(inode), cap, session->s_mds, seq,
 	      ceph_cap_string(newcaps));
-	doutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
+	boutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
 	      max_size, i_size_read(inode));
 
 
@@ -3669,7 +3693,7 @@ static void handle_cap_grant(struct inode *inode,
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
-		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
 		      ceph_vinop(inode), inode->i_mode,
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kgid(&init_user_ns, inode->i_gid));
@@ -3697,7 +3721,7 @@ static void handle_cap_grant(struct inode *inode,
 		u64 version = le64_to_cpu(grant->xattr_version);
 
 		if (version > ci->i_xattrs.version) {
-			doutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
+			boutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
 			      version, inode, ceph_vinop(inode), len);
 			if (ci->i_xattrs.blob)
 				ceph_buffer_put(ci->i_xattrs.blob);
@@ -3749,7 +3773,7 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
 		if (max_size != ci->i_max_size) {
-			doutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
+			boutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
 			      max_size);
 			ci->i_max_size = max_size;
 			if (max_size >= ci->i_wanted_max_size) {
@@ -3765,7 +3789,7 @@ static void handle_cap_grant(struct inode *inode,
 	used = __ceph_caps_used(ci);
 	used = ceph_adjust_caps_used_for_lazyio(used, cap->issued, cap->implemented);
 	dirty = __ceph_caps_dirty(ci);
-	doutc(cl, " my wanted = %s, used = %s, dirty %s\n",
+	boutc(cl, " my wanted = %s, used = %s, dirty %s\n",
 	      ceph_cap_string(wanted), ceph_cap_string(used),
 	      ceph_cap_string(dirty));
 
@@ -3788,7 +3812,7 @@ static void handle_cap_grant(struct inode *inode,
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
 
-		doutc(cl, "revocation: %s -> %s (revoking %s)\n",
+		boutc(cl, "revocation: %s -> %s (revoking %s)\n",
 		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
 		      ceph_cap_string(revoking));
 		/*
@@ -3823,11 +3847,11 @@ static void handle_cap_grant(struct inode *inode,
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
@@ -3962,7 +3986,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
 	      inode, ceph_vinop(inode), session->s_mds, seq,
 	      ceph_cap_string(dirty), ceph_cap_string(cleaned),
 	      ceph_cap_string(ci->i_flushing_caps),
@@ -3986,16 +4010,16 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
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
@@ -4087,14 +4111,14 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
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
@@ -4103,7 +4127,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 			capsnap = iter;
 			break;
 		} else {
-			doutc(cl, " skipping cap_snap %p follows %lld\n",
+			boutc(cl, " skipping cap_snap %p follows %lld\n",
 			      iter, iter->follows);
 		}
 	}
@@ -4156,7 +4180,7 @@ static bool handle_cap_trunc(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
 	      inode, ceph_vinop(inode), mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
@@ -4195,7 +4219,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), target, t_issue_seq, t_mseq);
 retry:
 	down_read(&mdsc->snap_rwsem);
@@ -4230,7 +4254,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_issue_seq) < 0) {
-			doutc(cl, " updating import cap %p mds%d\n", tcap,
+			boutc(cl, " updating import cap %p mds%d\n", tcap,
 			      target);
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_issue_seq - 1;
@@ -4337,7 +4361,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), peer, piseq, pmseq);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
@@ -4364,7 +4388,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
 	if (ocap && ocap->cap_id == p_cap_id) {
-		doutc(cl, " remove export cap %p mds%d flags %d\n",
+		boutc(cl, " remove export cap %p mds%d flags %d\n",
 		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
 		    (ocap->seq != piseq ||
@@ -4456,10 +4480,13 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	bool queue_trunc;
 	bool close_sessions = false;
 	bool do_cap_release = false;
+	struct ceph_journal_info __ji;
 
 	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
 		return;
 
+	ceph_blog_enter(mdsc->fsc, &__ji);
+
 	/* decode */
 	end = msg->front.iov_base + msg->front.iov_len;
 	if (msg->front.iov_len < sizeof(*h))
@@ -4624,7 +4651,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ceph_inode(inode), session->s_mds);
 	if (!cap) {
-		doutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
+		boutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
 		      inode, ceph_ino(inode), ceph_snap(inode),
 		      session->s_mds);
 		spin_unlock(&ci->i_ceph_lock);
@@ -4682,6 +4709,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		ceph_mdsc_close_sessions(mdsc);
 
 	kfree(extra_info.fscrypt_auth);
+	ceph_blog_exit(&__ji);
 	return;
 
 flush_cap_releases:
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index e5d8d59ffc17..f451a2fd0de8 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
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
@@ -1032,10 +1032,13 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	int i;
 	int locked_rwsem = 0;
 	bool close_sessions = false;
+	struct ceph_journal_info __ji;
 
 	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
 		return;
 
+	ceph_blog_enter(mdsc->fsc, &__ji);
+
 	/* decode */
 	if (msg->front.iov_len < sizeof(*h))
 		goto bad;
@@ -1048,7 +1051,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	trace_len = le32_to_cpu(h->trace_len);
 	p += sizeof(*h);
 
-	doutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
+	boutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
 	      ceph_snap_op_name(op), split, trace_len);
 
 	down_write(&mdsc->snap_rwsem);
@@ -1080,7 +1083,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 				goto out;
 		}
 
-		doutc(cl, "splitting snap_realm %llx %p\n", realm->ino, realm);
+		boutc(cl, "splitting snap_realm %llx %p\n", realm->ino, realm);
 		for (i = 0; i < num_split_inos; i++) {
 			struct ceph_vino vino = {
 				.ino = le64_to_cpu(split_inos[i]),
@@ -1105,12 +1108,12 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
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
@@ -1169,6 +1172,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 
 	flush_snaps(mdsc);
 	ceph_dec_mds_stopping_blocker(mdsc);
+	ceph_blog_exit(&__ji);
 	return;
 
 bad:
@@ -1182,6 +1186,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 
 	if (close_sessions)
 		ceph_mdsc_close_sessions(mdsc);
+	ceph_blog_exit(&__ji);
 	return;
 }
 
-- 
2.34.1

