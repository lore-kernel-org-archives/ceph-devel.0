Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5655C333
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958483; cv=none; b=l1NjeWtntQc1WqWjZAQBwCtv8GRMy1hqeZ32KL1qHbRM7jO9Gds/hI2motSZoB87R9lBYA9JlcjKQjAbhl9mw5WPz3M9t9vdpWcfHeuN1hZ2BxKvmaSkLtlPkVSjet/uocpeJa6ihi+ctMBhd7arvDlIjsdwd3bM5Bd3mVdY1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958483; c=relaxed/simple;
	bh=6bq6Bbx4DrrTfmrkBKg3Ha8F01BLzAUi4qbYfuaxOjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPvM/nu8RDDaWJ9CqNIsAmT+gLglo7KYIfK1MXBxe6+DMXWphshLu8P9e26iVRTd9IdIEI1VvTFOc2Zz1rMpeRmdFLyneJTZSLV2t/f4iaXO0K3Pd0NLZkJCQ4c/pwQGwIGF2cx8otFCdkIqh0OA8Vp+SkimHfarNjgyuXF0wAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJuP55su; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pCUs7k1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJuP55su";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pCUs7k1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWjdSnjBpBHS8GMqCSo26G8pWVpbyLUFP7k8Dvq8K9A=;
	b=BJuP55su5c9Z1K8O50IVqTgPlm5c5nwnRj6/L3RoNnlKlZSNiuubZ9zNHgt39mOxENCXjd
	oPajdkDmN+I+nHnms2gTikb+EUoOyOL9gfEnCudpmrCXp996bvHT87BviK+Fdmpb/a2Ro4
	RPx36c2AQHy4PsCIEtUJVraWvnXaqGc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-1_sfbvZfPgm5Vt3IBp0OCg-1; Wed, 09 Sep 2026 08:54:38 -0400
X-MC-Unique: 1_sfbvZfPgm5Vt3IBp0OCg-1
X-Mimecast-MFC-AGG-ID: 1_sfbvZfPgm5Vt3IBp0OCg_1788958478
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93915f50a5cso1367601585a.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958478; x=1789563278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWjdSnjBpBHS8GMqCSo26G8pWVpbyLUFP7k8Dvq8K9A=;
        b=pCUs7k1FnBSEst/9mWe6WmyYfPSJbY77Zk0Jq7Kus3mWmexFA9ddxEzHobJI37d2oQ
         9hBYr95rxcUAg034UWLX3MVM0dfcsLxLnnd0+u3GNnLkKPLq3A/dniYW9be/DAx/4Om4
         DHSDn20gT5wpsfQS9ryHM4x6pV8PRcJvhhPupHp95iOvoPtDgsLP2gJIthn11gnJxRHl
         GkAh5CduRJqNP4jZ7hK9sXALzhTOMht3v6XJ01CL2r3+zhElRqR12/AJuTzD0AFMIxQQ
         7LTR8VIGuy37u39K9DlcaryxJgmAnEK1SHRian2C4jI4ljJ6eXd2ONmqcWxykHLc5bzW
         D4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958478; x=1789563278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWjdSnjBpBHS8GMqCSo26G8pWVpbyLUFP7k8Dvq8K9A=;
        b=F/YrGakYQG/9bFVLlO6uOTFDterokwzElksXqNzR0JuBCzO4XG0RKNJeesVcsC8f3K
         1kFYk/Qx8GblOChgtWJdWSnj48oII4PqlV0+f9KhRmkArGRZ+SUaQCO72dj3ahKkxmQF
         PeMh/gNWJ0VHmw/tc0NPzZXUXaW4RYnalJDMepv9EksAG8gehBiu9hDE02ODBHuW+ys6
         1AYzEmYuJIFURmuDlcM303Zl2yDnhzulMOosgoC7muHEr/Q5DH/jptzgcY5EKqubtOni
         px1qztWAE+MqTF3gBnaBvYum0N3RB8seSopo/fwqAu1VWo1dJepScjkZ/rFPLN1aPPs2
         qKvA==
X-Gm-Message-State: AFuF++lgF+HTw5r+GW+OjffaLEnsx99hf5Tww4LixbbGGZfoZUOH5cTD
	NGzUj/Y6+3YRI51TGv82/qQVEY0DVzD1tRfbBRChM0mBjRsf+6E3gbmLBiAM46hOzTHUV/AVyOP
	bIXHRQAFLOoG/ziFAitv+cm5xtOD2d0vjb0TE/tgFgeekVT8l70PUT2uBzbU1fzGgkjrccWvCSX
	aV6l1tao+j7p2Zez7fsk0Tek+pWEqWA2R+JbhOfo+edRU5mvZOcg==
X-Gm-Gg: AYBFou3/rTjIiSVWXPYl11CvJ6BiLpumP1tbDp73xkw+wenq9bfkyal9UGvU60wA9mU
	cD7yEunyrIGJG+GoRr06C6qiqz9sGNpCaDKyk3vbTqNdziEzUX9a8mUiDTmPI9QqqwthI/EtXj+
	1jHBHmBh9Zzojx36VIWXoWnqnEFyzZwFb3kh0yIR5yDTUQQEKrgTQ5TTm+c7oY4OiirpmpLavlk
	DpGhN8t5rGcWIS1/9ez4zNYZHnjI4jpe1i2qaGS6+vihYG9BDc3iQfn0AJKsgRPHIcHI0g8EF2W
	Fu3EKstBun+0mk71VmvDZdzR0dA3xcRrgxbB0IUjUIUNUjpRCFyTIYRXlMCO6st6V/28Pbhcwxe
	3C4Gz1Af9RhBVr5BaqCpFFBWxM+ft49xJamYcmO4GUYG2oUVwdCXV4wZvq0u9tXRdIQwE18ex5v
	njW8Xcux0JtN3ovA==
X-Received: by 2002:a05:620a:aa09:b0:939:a45:8c96 with SMTP id af79cd13be357-9396e07a4d1mr2995304685a.19.1788958477662;
        Wed, 09 Sep 2026 05:54:37 -0700 (PDT)
X-Received: by 2002:a05:620a:aa09:b0:939:a45:8c96 with SMTP id af79cd13be357-9396e07a4d1mr2995299485a.19.1788958476964;
        Wed, 09 Sep 2026 05:54:36 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:36 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 13/14] ceph: convert capability and snapshot paths to bout
Date: Wed,  9 Sep 2026 12:54:15 +0000
Message-Id: <20260909125416.3969532-14-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909125416.3969532-1-amarkuze@redhat.com>
References: <20260909125416.3969532-1-amarkuze@redhat.com>
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
ceph_write_inode).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c | 116 ++++++++++++++++++++++++++++++-------------------
 fs/ceph/snap.c |  17 +++++---
 2 files changed, 83 insertions(+), 50 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 8e582cbcfc6b..8e21abe6dce3 100644
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
@@ -1234,7 +1246,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	struct ceph_fs_client *fsc;
 
 	if (ceph_cap_is_removed(cap)) {
-		doutc(mdsc->fsc->client, "inode is NULL\n");
+		doutc(mdsc->fsc->client, "cap already removed\n");
 		return;
 	}
 
@@ -2495,7 +2507,7 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 		kfree(sessions);
 	}
 
-	doutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
+	boutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
 	      ceph_vinop(inode), req1 ? req1->r_tid : 0ULL,
 	      req2 ? req2->r_tid : 0ULL);
 	if (req1) {
@@ -2522,13 +2534,17 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
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
@@ -2540,7 +2556,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	dirty = try_flush_caps(inode, &flush_tid);
-	doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
+	boutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
 
 	err = flush_mdlog_and_wait_inode_unsafe_requests(inode);
 
@@ -2561,8 +2577,9 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (err < 0)
 		ret = err;
 out:
-	doutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
 	      datasync ? " datasync" : "", ret);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2574,19 +2591,25 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
@@ -2600,6 +2623,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 			__cap_delay_requeue_front(mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
 	}
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -3501,7 +3525,7 @@ static void invalidate_aliases(struct inode *inode)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn, *prev = NULL;
 
-	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+	boutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
@@ -3612,10 +3636,10 @@ static void handle_cap_grant(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
+	boutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
 	      ceph_vinop(inode), cap, session->s_mds, seq,
 	      ceph_cap_string(newcaps));
-	doutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
+	boutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
 	      max_size, i_size_read(inode));
 
 
@@ -3676,7 +3700,7 @@ static void handle_cap_grant(struct inode *inode,
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
-		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
 		      ceph_vinop(inode), inode->i_mode,
 		      from_kuid(&init_user_ns, inode->i_uid),
 		      from_kgid(&init_user_ns, inode->i_gid));
@@ -3704,7 +3728,7 @@ static void handle_cap_grant(struct inode *inode,
 		u64 version = le64_to_cpu(grant->xattr_version);
 
 		if (version > ci->i_xattrs.version) {
-			doutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
+			boutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
 			      version, inode, ceph_vinop(inode), len);
 			if (ci->i_xattrs.blob)
 				ceph_buffer_put(ci->i_xattrs.blob);
@@ -3756,7 +3780,7 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
 		if (max_size != ci->i_max_size) {
-			doutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
+			boutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
 			      max_size);
 			ci->i_max_size = max_size;
 			if (max_size >= ci->i_wanted_max_size) {
@@ -3771,7 +3795,7 @@ static void handle_cap_grant(struct inode *inode,
 	wanted = __ceph_caps_wanted(ci);
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
-	doutc(cl, " my wanted = %s, used = %s, dirty %s\n",
+	boutc(cl, " my wanted = %s, used = %s, dirty %s\n",
 	      ceph_cap_string(wanted), ceph_cap_string(used),
 	      ceph_cap_string(dirty));
 
@@ -3794,7 +3818,7 @@ static void handle_cap_grant(struct inode *inode,
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
 
-		doutc(cl, "revocation: %s -> %s (revoking %s)\n",
+		boutc(cl, "revocation: %s -> %s (revoking %s)\n",
 		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
 		      ceph_cap_string(revoking));
 		if (S_ISREG(inode->i_mode) &&
@@ -3816,11 +3840,11 @@ static void handle_cap_grant(struct inode *inode,
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
@@ -3972,7 +3996,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
 	      inode, ceph_vinop(inode), session->s_mds, seq,
 	      ceph_cap_string(dirty), ceph_cap_string(cleaned),
 	      ceph_cap_string(ci->i_flushing_caps),
@@ -3996,16 +4020,16 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
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
@@ -4097,14 +4121,14 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
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
@@ -4113,7 +4137,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 			capsnap = iter;
 			break;
 		} else {
-			doutc(cl, " skipping cap_snap %p follows %lld\n",
+			boutc(cl, " skipping cap_snap %p follows %lld\n",
 			      iter, iter->follows);
 		}
 	}
@@ -4166,7 +4190,7 @@ static bool handle_cap_trunc(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	doutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
+	boutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
 	      inode, ceph_vinop(inode), mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
@@ -4205,7 +4229,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), target, t_issue_seq, t_mseq);
 retry:
 	down_read(&mdsc->snap_rwsem);
@@ -4240,7 +4264,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_issue_seq) < 0) {
-			doutc(cl, " updating import cap %p mds%d\n", tcap,
+			boutc(cl, " updating import cap %p mds%d\n", tcap,
 			      target);
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_issue_seq - 1;
@@ -4347,7 +4371,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
-	doutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
+	boutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), peer, piseq, pmseq);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
@@ -4374,7 +4398,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
 	if (ocap && ocap->cap_id == p_cap_id) {
-		doutc(cl, " remove export cap %p mds%d flags %d\n",
+		boutc(cl, " remove export cap %p mds%d flags %d\n",
 		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
 		    (ocap->seq != piseq ||
@@ -4467,10 +4491,13 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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
@@ -4567,7 +4594,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
-	doutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
+	boutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
 	      session->s_mds, ceph_cap_op_name(op), vino.ino, vino.snap, inode,
 	      seq, issue_seq, mseq);
 
@@ -4577,7 +4604,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	mutex_lock(&session->s_mutex);
 
 	if (!inode) {
-		doutc(cl, " i don't have ino %llx\n", vino.ino);
+		boutc(cl, " i don't have ino %llx\n", vino.ino);
 
 		switch (op) {
 		case CEPH_CAP_OP_IMPORT:
@@ -4632,7 +4659,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ceph_inode(inode), session->s_mds);
 	if (!cap) {
-		doutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
+		boutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
 		      inode, ceph_ino(inode), ceph_snap(inode),
 		      session->s_mds);
 		spin_unlock(&ci->i_ceph_lock);
@@ -4690,6 +4717,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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

