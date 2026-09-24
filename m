Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AAA4A64EA
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263875; cv=none; b=U1LCU0/OhYWIMhiJjlKGxxRiW7i45g8FOsnsW4B4fLT8TDw/9jxwawyUlCLVLuwhywKeSsWZsAupXTKh0rVJFvs52yFpCmX7Bc8IqgXtX0X6P/Cp5777bV4oXPlWVKxIwcJfvm0lABzOl4pwOsxOOfd9RC2dmB/WAmUz2bW1heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263875; c=relaxed/simple;
	bh=EsaHsY51PDC5jkqbr7iDzKc41oczFlEDD0J8yVbtFc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rU5+rDLgZ43NpzKun+tAzl/H8MVxV7lLKXdUnuLVmI9a6beelDgEZ4Eq7nOa5sv9xYewMeus8lqWSc/WzUtDFfTw98IsmDyK1KvLA3xHVCkdyEVip3YgqrjgtAzm0ei0EXFn9YW32F2+DrcKKLaQ1z6R9uUHqIPG0n5U+23HG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByZmR+dx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVGvcNzs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByZmR+dx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVGvcNzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Woy5mloXJ7vRgnjnHhhjMGpJbXSHRNkt5uBuxs8BDS8=;
	b=ByZmR+dxyBM5wSl3AIVyZWWVBpbQMxWNVX65Mhx08sGp7/9ruGDnkGXjcHcDB8LQlJOkBV
	WPgQ55J8T435bGI5wvpzf6UPAqkjRDEG2xuAQZpKFZRr4/NqfbdTzS4wYVL4T36m96mxUR
	MhiuVP6IVEd7m1gx62Px5+3rG8fU0S0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-qqc1_9a_N0mcPn2n0Rk-Bw-1; Thu, 24 Sep 2026 11:31:09 -0400
X-MC-Unique: qqc1_9a_N0mcPn2n0Rk-Bw-1
X-Mimecast-MFC-AGG-ID: qqc1_9a_N0mcPn2n0Rk-Bw_1790263869
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6aa47eed2c3so2776604a12.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263869; x=1790868669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Woy5mloXJ7vRgnjnHhhjMGpJbXSHRNkt5uBuxs8BDS8=;
        b=NVGvcNzsuqZS4kfU9WbdbcwvK1/3MPOSh8aq76fOWm2LgKLhFyrtpVMn+6llUDcAy6
         QopMzOzJA0KZclr3m7tko1zlOvfv8WVYsMVHeLuSFtv/da0bUp0/2Xpb8drSURQb9v0z
         IiWBkCwvz8OcSp/nCCiQmbTPcWb2EsWmF+9efL1a43Q4DFDL7TA67ZknYYIrKeOfSl1B
         /mtRaPRWpVxAfrQGAWkNq1evqLdrGJn5ZD68lAeDUi1boteS627MoJn2FWrcRJuLjRZq
         lxBqcs2mOr10z86qyBTZq1viYapaw5t2CbfbmxMhntlg9NrqkuTl3CcmsQjNcPTXHsk+
         0nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263869; x=1790868669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Woy5mloXJ7vRgnjnHhhjMGpJbXSHRNkt5uBuxs8BDS8=;
        b=QVEgoOVZIdbDn7iUUJyTqJ7J1UiSz5vF0cS+Qob3KuUcsWq6/XGnbz50Xbp40SL7W9
         JsPkwELF8CA7QMPyPYUzlxQ6bO59FYN34PrOMpQavQw+6gnzhuLjpHRMHcPPKtBPsdeh
         LTKXJZ6kBT3kKVbYvEqhmnSbNsXtme8SqeZOhQDSMwx5Ta4j4TcP2FAzKgjEVmW49BNJ
         YhA1Fv7EAWgycEKI1ctaYN3Jbg0G+L/9IADE5wMxFYIdDr+oMsBMhoRh8yXbQWAosk/n
         +GlGPW6adZQuqIAwBZhnCYgdCOjwbjM+UEafy58sMtBS0wSH0EI1U+8qoo4zTb8B/E76
         EaYA==
X-Gm-Message-State: AFuF++lh9Om1DNygtrEdzfq03ty754Bu5NMy65Wt1MoRtyHEB3NXeMMe
	SfFO1y9OOWUvaZV88cP2SVPjbeZiThPkg8xMx6JtamkDYR5YJGM3hayjWHvcl41PNBwRt1mamOi
	7afLRPMogIZiTLJZllATguF+FpZ+0sNkQFkLScpTePSXIj5EQm9alZDpeNqxHXRP3cuDWicg1BL
	ToVrSkypH90/Aa0Y0mk60uYb7BeWeyn7DsQE/mw8QT3jzZWysvrQ==
X-Gm-Gg: AYBFou3PoCUztFYcsv1UvQ+yjFAVSClDRT1v2Ly74Rc25P733C7aMNVIghoLcVLFmIK
	ccMuSdosP9TEaD/R8kPi/VODs9xYm7VAFbBjFapZXnYX0zZ9Ioa0y42Yq1J2wdc0816Yc59JLAT
	amrrFsqWegaY4rZDnZQsLb4WL8GqOqzxURfJfLg/gQRrvn5+Z2whOq/9yaaehb8PT6rufS24mmi
	GHJM+fdyIcxJ1W5p8b/yTEX666hZiEH0zw3EzdoFKFOnqXqFmCiECVN0o/9vQFGiGJp2HSVP8cL
	QhoF2MPjbL7X6Uh6a6ta6dex4k0DUJNeoC0KgAHCum9JY2iwIDIMsy9HVdybiXTZow4Ge9qrZeq
	aE2i4bnURhoov+O013nF7KNrkPUzKqIA02d1sHlkMKWpVuSMYVEWqjZJUBdST0jyUKNOqW8hMVZ
	Z/E6Z3qFFYz2p9DQ==
X-Received: by 2002:a05:6402:2347:b0:6a7:f25b:d281 with SMTP id 4fb4d7f45d1cf-6aac8f404ecmr2772050a12.13.1790263868554;
        Thu, 24 Sep 2026 08:31:08 -0700 (PDT)
X-Received: by 2002:a05:6402:2347:b0:6a7:f25b:d281 with SMTP id 4fb4d7f45d1cf-6aac8f404ecmr2771996a12.13.1790263867760;
        Thu, 24 Sep 2026 08:31:07 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:31:06 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 13/14] ceph: convert capability and snapshot paths to BLOG logging
Date: Thu, 24 Sep 2026 15:30:43 +0000
Message-Id: <20260924153045.994784-14-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924153045.994784-1-amarkuze@redhat.com>
References: <20260924153045.994784-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace text debug logging with the boutc() wrappers only on MDS/VFS
paths that already bind a BLOG context via ceph_blog_enter()
(ceph_handle_caps and its handle_cap_* helpers,
ceph_handle_snap/flush_snaps, ceph_fsync, ceph_write_inode).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c | 116 ++++++++++++++++++++++++++++++-------------------
 fs/ceph/snap.c |  17 +++++---
 2 files changed, 83 insertions(+), 50 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 16e13ba9c9ac..9d1dcbd38d37 100644
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
@@ -1281,7 +1293,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	struct ceph_fs_client *fsc;
 
 	if (ceph_cap_is_removed(cap)) {
-		doutc(mdsc->fsc->client, "inode is NULL\n");
+		doutc(mdsc->fsc->client, "cap already removed\n");
 		return;
 	}
 
@@ -2575,7 +2587,7 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 		kfree(sessions);
 	}
 
-	doutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
+	boutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
 	      ceph_vinop(inode), req1 ? req1->r_tid : 0ULL,
 	      req2 ? req2->r_tid : 0ULL);
 	if (req1) {
@@ -2602,13 +2614,17 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
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
@@ -2620,7 +2636,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	dirty = try_flush_caps(inode, &flush_tid);
-	doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
+	boutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
 
 	err = flush_mdlog_and_wait_inode_unsafe_requests(inode);
 
@@ -2641,8 +2657,9 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (err < 0)
 		ret = err;
 out:
-	doutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
 	      datasync ? " datasync" : "", ret);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2654,19 +2671,25 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
@@ -2680,6 +2703,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 			__cap_delay_requeue_front(mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
 	}
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -3627,7 +3651,7 @@ static void invalidate_aliases(struct inode *inode)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn, *prev = NULL;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
@@ -3738,10 +3762,10 @@ static void handle_cap_grant(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
+	boutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
 	      ceph_vinop(inode), cap, session->s_mds, seq,
 	      ceph_cap_string(newcaps));
-	doutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
+	boutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
 	      max_size, i_size_read(inode));
 
 
@@ -3859,7 +3883,7 @@ static void handle_cap_grant(struct inode *inode,
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
-		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
 		      ceph_vinop(inode), inode->i_mode,
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kgid(&init_user_ns, inode->i_gid));
@@ -3887,7 +3911,7 @@ static void handle_cap_grant(struct inode *inode,
 		u64 version = le64_to_cpu(grant->xattr_version);
 
 		if (version > ci->i_xattrs.version) {
-			doutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
+			boutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
 			      version, inode, ceph_vinop(inode), len);
 			if (ci->i_xattrs.blob)
 				ceph_buffer_put(ci->i_xattrs.blob);
@@ -3939,7 +3963,7 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
 		if (max_size != ci->i_max_size) {
-			doutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
+			boutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
 			      max_size);
 			ci->i_max_size = max_size;
 			if (max_size >= ci->i_wanted_max_size) {
@@ -3956,7 +3980,7 @@ static void handle_cap_grant(struct inode *inode,
 	used = ceph_adjust_caps_used_for_lazyio(ci, used, cap->issued,
 						cap->implemented);
 	dirty = __ceph_caps_dirty(ci);
-	doutc(cl, " my wanted = %s, used = %s, dirty %s\n",
+	boutc(cl, " my wanted = %s, used = %s, dirty %s\n",
 	      ceph_cap_string(wanted), ceph_cap_string(used),
 	      ceph_cap_string(dirty));
 
@@ -3979,7 +4003,7 @@ static void handle_cap_grant(struct inode *inode,
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
 
-		doutc(cl, "revocation: %s -> %s (revoking %s)\n",
+		boutc(cl, "revocation: %s -> %s (revoking %s)\n",
 		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
 		      ceph_cap_string(revoking));
 		/*
@@ -4014,11 +4038,11 @@ static void handle_cap_grant(struct inode *inode,
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
@@ -4170,7 +4194,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
 	      inode, ceph_vinop(inode), session->s_mds, seq,
 	      ceph_cap_string(dirty), ceph_cap_string(cleaned),
 	      ceph_cap_string(ci->i_flushing_caps),
@@ -4194,16 +4218,16 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
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
@@ -4295,14 +4319,14 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
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
@@ -4311,7 +4335,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 			capsnap = iter;
 			break;
 		} else {
-			doutc(cl, " skipping cap_snap %p follows %lld\n",
+			boutc(cl, " skipping cap_snap %p follows %lld\n",
 			      iter, iter->follows);
 		}
 	}
@@ -4364,7 +4388,7 @@ static bool handle_cap_trunc(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
 	      inode, ceph_vinop(inode), mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
@@ -4403,7 +4427,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), target, t_issue_seq, t_mseq);
 retry:
 	down_read(&mdsc->snap_rwsem);
@@ -4438,7 +4462,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_issue_seq) < 0) {
-			doutc(cl, " updating import cap %p mds%d\n", tcap,
+			boutc(cl, " updating import cap %p mds%d\n", tcap,
 			      target);
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_issue_seq - 1;
@@ -4545,7 +4569,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), peer, piseq, pmseq);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
@@ -4572,7 +4596,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
 	if (ocap && ocap->cap_id == p_cap_id) {
-		doutc(cl, " remove export cap %p mds%d flags %d\n",
+		boutc(cl, " remove export cap %p mds%d flags %d\n",
 		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
 		    (ocap->seq != piseq ||
@@ -4665,10 +4689,13 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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
@@ -4765,7 +4792,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
-	doutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
+	boutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
 	      session->s_mds, ceph_cap_op_name(op), vino.ino, vino.snap, inode,
 	      seq, issue_seq, mseq);
 
@@ -4775,7 +4802,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	mutex_lock(&session->s_mutex);
 
 	if (!inode) {
-		doutc(cl, " i don't have ino %llx\n", vino.ino);
+		boutc(cl, " i don't have ino %llx\n", vino.ino);
 
 		switch (op) {
 		case CEPH_CAP_OP_IMPORT:
@@ -4830,7 +4857,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ceph_inode(inode), session->s_mds);
 	if (!cap) {
-		doutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
+		boutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
 		      inode, ceph_ino(inode), ceph_snap(inode),
 		      session->s_mds);
 		spin_unlock(&ci->i_ceph_lock);
@@ -4888,6 +4915,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		ceph_mdsc_close_sessions(mdsc);
 
 	kfree(extra_info.fscrypt_auth);
+	ceph_blog_exit(&__ji);
 	return;
 
 flush_cap_releases:
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index c1a0c645567d..f59b83a97d52 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -949,7 +949,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 	struct inode *inode;
 	struct ceph_mds_session *session = NULL;
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 	spin_lock(&mdsc->snap_flush_lock);
 	while (!list_empty(&mdsc->snap_flush_list)) {
 		ci = list_first_entry(&mdsc->snap_flush_list,
@@ -964,7 +964,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 	spin_unlock(&mdsc->snap_flush_lock);
 
 	ceph_put_mds_session(session);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 /**
@@ -1035,10 +1035,13 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
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
@@ -1051,7 +1054,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	trace_len = le32_to_cpu(h->trace_len);
 	p += sizeof(*h);
 
-	doutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
+	boutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
 	      ceph_snap_op_name(op), split, trace_len);
 
 	down_write(&mdsc->snap_rwsem);
@@ -1083,7 +1086,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 				goto out;
 		}
 
-		doutc(cl, "splitting snap_realm %llx %p\n", realm->ino, realm);
+		boutc(cl, "splitting snap_realm %llx %p\n", realm->ino, realm);
 		for (i = 0; i < num_split_inos; i++) {
 			struct ceph_vino vino = {
 				.ino = le64_to_cpu(split_inos[i]),
@@ -1108,12 +1111,12 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
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
@@ -1172,6 +1175,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 
 	flush_snaps(mdsc);
 	ceph_dec_mds_stopping_blocker(mdsc);
+	ceph_blog_exit(&__ji);
 	return;
 
 bad:
@@ -1185,6 +1189,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 
 	if (close_sessions)
 		ceph_mdsc_close_sessions(mdsc);
+	ceph_blog_exit(&__ji);
 	return;
 }
 
-- 
2.34.1

