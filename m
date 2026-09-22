Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EB41BA72
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085689; cv=none; b=ERKSV7R4nNRjy2TSj+ea9EaRXKhXcFp3H9H4SqGXcPeg+W3gO2L5oMWgMlsgQF8IhnGqkpG5zAQgZb6huyZGMlQWEOx3uQCk/fPdQu0NZR3cgyYC4YvQ/9mNTIAOtr7vCHpLTgUOpLspLt7HpUbrMoGARL8hf5tYYry1PICpl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085689; c=relaxed/simple;
	bh=Vp1ASANJvGHzccQZH19LmHGrlgfs2GHFfjfL4g0yJEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbpJ/fKArgktpZ+RTNUKqdEZYj8Bo/MHcw8k7XARKp6s+Pj4T6inIrT824UbXZQc5cUPK82JR23sd4EehOPszwBCo6vFZLJDUsAcAdOzNzHNbwwc33+uDFbxKbge7PpP3crfphGvVwGKGFBU2ofjMG3PHHGqM5y9G4NcDqELAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DatzbwAQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTQGexoA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DatzbwAQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTQGexoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAGuMmP6+H2bp1gzoxXgXHKwQKFzf8SqlHgSN/24JbQ=;
	b=DatzbwAQaoVEBWh4Cpn52nFlxi3j92SpBkFBO654vGjOlXo3tz/6v340Ytz/gf4BsA4/14
	8NnTdN8B9N/E9ePZZa8aMTJIc6XZ0GfA3QozAa/YKLzjfFYcDUCUSthTOFS3aKMt2nEvSj
	74TmBwG8fEqb1r50MaDn/0xxUe8DM7c=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Xd0pGzNcNoe-Y31Zyy21JA-1; Tue, 22 Sep 2026 10:01:24 -0400
X-MC-Unique: Xd0pGzNcNoe-Y31Zyy21JA-1
X-Mimecast-MFC-AGG-ID: Xd0pGzNcNoe-Y31Zyy21JA_1790085684
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-895241d7405so45275417b3.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085684; x=1790690484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MAGuMmP6+H2bp1gzoxXgXHKwQKFzf8SqlHgSN/24JbQ=;
        b=CTQGexoA6NrIZfyYUynMYkkjrHqcEOtFNdBC3HYg0gjBYKLBB0IOiImFVSjFnNRJkV
         mUP1+yvtsgHq2gF+3WR8SXM5d+rPYr+ttHGBIqUncAt4ZtjD+COsCOEdNyFzqOhEd+YU
         QY/vvDR8awgYT0GN2DvcwaUzX4VT438xPa6oryz0K0LGDv98dukIVzvTvDafJC6S4NYP
         CZonrYgU5XQdyd56IidiVNTkTOTQtFBRQQkB5w8MtlBVnxShPJkMF0E1c+l6YnpvL2xk
         4GdLVHCYCTC1aof4LvTODBMMzfzYQSftFekjL16TRNJ6PSmbGUgoh490G5PeU7yygChJ
         dQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085684; x=1790690484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MAGuMmP6+H2bp1gzoxXgXHKwQKFzf8SqlHgSN/24JbQ=;
        b=hjg2nCuCkvORguClo0Nght+ndJTbYH6JTohCQjwH8GNI+GnKwHJ5i2iQDniV6k2jUI
         hSxPdeVcGOFrB7e62QGsSHYc5huxMUmpQQtWRbrHcuie+QdiLomKBmaZD04Q7HNhx2TE
         q/H4RT7d6g48rBkwI0a5i2cHv23G3mK1EJXi4ctgtLmCN7WACMjDK+rwbI9EOylPeT5n
         08o9uA337aV9WMdekuxMyhGUOQEX4ADjBOqT4wjDqycpCgdTUQj7ku4ciuTcNW+X6ILx
         73cmmfz+bdZ15lZ7yWQbsuij7zniJQF8emhwzUzLDscM22hfOmYE2Sj0nashfyhgbXta
         UU8A==
X-Gm-Message-State: AFuF++mNWAt21yhXgJqp/lDSsufM0k+C2liY34soM4K96YBuEBrJgSIo
	t3ph2vDhe5DHPKa3x2FcQtVB/E3XYJ3t3Kep/dKC4sMJ/UKbqe59jw3aN4+o2ThdnMxkIWQ1ndM
	Lt3wBlBZ+b79rM/9fzrEZOID3xHckICr0fUUL1BozqTsw1Wu4AwbyX0Bt4EkDRSd5TI77AUXuCS
	Uoic5AHTfheeObnIju9E2OeKA6ooizweFDGQTYqY97FPR51fVmmg==
X-Gm-Gg: AYBFou2AYC2zs5y3rJ96x9VYxeQoTfqeUfi+DBfI9JXFVYkDYHtdrikIth1dWiz8WhY
	t3jEWKM9nQBXc8eE6OMnnZUoPL21EVszbIkr9Jbi4k5SsR7SBu8mjxO3HWXpaxt6gx3dAX0ZiBX
	8+aeP+zYPxQtFkAr+RV6Xtq4ObouwKx6XFDnnCygg6KnkWinrJ4MM7C2pqj/xolhlrbIjIjaWrG
	clcMfAF8Oo/i+BmnIuRNawa1XYFQevlIPmOMcAYlYmXtc8P0Gbh1oeKoIf3eG8NgyFNANwHUdrX
	NAuN9n+7zAOQ02HwlDpxgrXtA7RtD8WlpcikjwE/qIiMydpeeegnQhXiIsNeIdPKdKoDewr3EC4
	yP8vq283oH6PKVq3u3bZyv0qj1kvfLddX6q4eKO4vzjINSBJzJn4qromWBdnWfYkIGkXjxBiL08
	/xVkw2+Nl2/FfT0Q==
X-Received: by 2002:a05:690c:385:b0:884:b55c:258 with SMTP id 00721157ae682-8a253faf5d6mr11414527b3.3.1790085683161;
        Tue, 22 Sep 2026 07:01:23 -0700 (PDT)
X-Received: by 2002:a05:690c:385:b0:884:b55c:258 with SMTP id 00721157ae682-8a253faf5d6mr11413257b3.3.1790085682209;
        Tue, 22 Sep 2026 07:01:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:01:21 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 13/14] ceph: convert capability and snapshot paths to BLOG logging
Date: Tue, 22 Sep 2026 14:00:46 +0000
Message-Id: <20260922140047.794405-14-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922140047.794405-1-amarkuze@redhat.com>
References: <20260922140047.794405-1-amarkuze@redhat.com>
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
index 15ba173c07ae..1e880d8b9d6d 100644
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
 
@@ -2573,7 +2585,7 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 		kfree(sessions);
 	}
 
-	doutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
+	boutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
 	      ceph_vinop(inode), req1 ? req1->r_tid : 0ULL,
 	      req2 ? req2->r_tid : 0ULL);
 	if (req1) {
@@ -2600,13 +2612,17 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
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
@@ -2618,7 +2634,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	dirty = try_flush_caps(inode, &flush_tid);
-	doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
+	boutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
 
 	err = flush_mdlog_and_wait_inode_unsafe_requests(inode);
 
@@ -2639,8 +2655,9 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (err < 0)
 		ret = err;
 out:
-	doutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
 	      datasync ? " datasync" : "", ret);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2652,19 +2669,25 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
@@ -2678,6 +2701,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 			__cap_delay_requeue_front(mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
 	}
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -3625,7 +3649,7 @@ static void invalidate_aliases(struct inode *inode)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn, *prev = NULL;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
@@ -3736,10 +3760,10 @@ static void handle_cap_grant(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
+	boutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
 	      ceph_vinop(inode), cap, session->s_mds, seq,
 	      ceph_cap_string(newcaps));
-	doutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
+	boutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
 	      max_size, i_size_read(inode));
 
 
@@ -3857,7 +3881,7 @@ static void handle_cap_grant(struct inode *inode,
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
-		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
 		      ceph_vinop(inode), inode->i_mode,
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kgid(&init_user_ns, inode->i_gid));
@@ -3885,7 +3909,7 @@ static void handle_cap_grant(struct inode *inode,
 		u64 version = le64_to_cpu(grant->xattr_version);
 
 		if (version > ci->i_xattrs.version) {
-			doutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
+			boutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
 			      version, inode, ceph_vinop(inode), len);
 			if (ci->i_xattrs.blob)
 				ceph_buffer_put(ci->i_xattrs.blob);
@@ -3937,7 +3961,7 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
 		if (max_size != ci->i_max_size) {
-			doutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
+			boutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
 			      max_size);
 			ci->i_max_size = max_size;
 			if (max_size >= ci->i_wanted_max_size) {
@@ -3954,7 +3978,7 @@ static void handle_cap_grant(struct inode *inode,
 	used = ceph_adjust_caps_used_for_lazyio(ci, used, cap->issued,
 						cap->implemented);
 	dirty = __ceph_caps_dirty(ci);
-	doutc(cl, " my wanted = %s, used = %s, dirty %s\n",
+	boutc(cl, " my wanted = %s, used = %s, dirty %s\n",
 	      ceph_cap_string(wanted), ceph_cap_string(used),
 	      ceph_cap_string(dirty));
 
@@ -3977,7 +4001,7 @@ static void handle_cap_grant(struct inode *inode,
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
 
-		doutc(cl, "revocation: %s -> %s (revoking %s)\n",
+		boutc(cl, "revocation: %s -> %s (revoking %s)\n",
 		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
 		      ceph_cap_string(revoking));
 		/*
@@ -4012,11 +4036,11 @@ static void handle_cap_grant(struct inode *inode,
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
@@ -4168,7 +4192,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
 	      inode, ceph_vinop(inode), session->s_mds, seq,
 	      ceph_cap_string(dirty), ceph_cap_string(cleaned),
 	      ceph_cap_string(ci->i_flushing_caps),
@@ -4192,16 +4216,16 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
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
@@ -4293,14 +4317,14 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
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
@@ -4309,7 +4333,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 			capsnap = iter;
 			break;
 		} else {
-			doutc(cl, " skipping cap_snap %p follows %lld\n",
+			boutc(cl, " skipping cap_snap %p follows %lld\n",
 			      iter, iter->follows);
 		}
 	}
@@ -4362,7 +4386,7 @@ static bool handle_cap_trunc(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
 	      inode, ceph_vinop(inode), mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
@@ -4401,7 +4425,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), target, t_issue_seq, t_mseq);
 retry:
 	down_read(&mdsc->snap_rwsem);
@@ -4436,7 +4460,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_issue_seq) < 0) {
-			doutc(cl, " updating import cap %p mds%d\n", tcap,
+			boutc(cl, " updating import cap %p mds%d\n", tcap,
 			      target);
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_issue_seq - 1;
@@ -4543,7 +4567,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), peer, piseq, pmseq);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
@@ -4570,7 +4594,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
 	if (ocap && ocap->cap_id == p_cap_id) {
-		doutc(cl, " remove export cap %p mds%d flags %d\n",
+		boutc(cl, " remove export cap %p mds%d flags %d\n",
 		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
 		    (ocap->seq != piseq ||
@@ -4663,10 +4687,13 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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
@@ -4763,7 +4790,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
-	doutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
+	boutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
 	      session->s_mds, ceph_cap_op_name(op), vino.ino, vino.snap, inode,
 	      seq, issue_seq, mseq);
 
@@ -4773,7 +4800,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	mutex_lock(&session->s_mutex);
 
 	if (!inode) {
-		doutc(cl, " i don't have ino %llx\n", vino.ino);
+		boutc(cl, " i don't have ino %llx\n", vino.ino);
 
 		switch (op) {
 		case CEPH_CAP_OP_IMPORT:
@@ -4828,7 +4855,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ceph_inode(inode), session->s_mds);
 	if (!cap) {
-		doutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
+		boutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
 		      inode, ceph_ino(inode), ceph_snap(inode),
 		      session->s_mds);
 		spin_unlock(&ci->i_ceph_lock);
@@ -4886,6 +4913,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		ceph_mdsc_close_sessions(mdsc);
 
 	kfree(extra_info.fscrypt_auth);
+	ceph_blog_exit(&__ji);
 	return;
 
 flush_cap_releases:
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 8818fe481fa4..0b0205c0d53b 100644
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

