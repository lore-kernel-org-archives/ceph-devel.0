Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670F4A64C9
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263869; cv=none; b=oY7yo4GoqLiHAKHFp8zXtyFp2mWlIjPI+2j/ssXqB646xg2kgDAJ3wElbThumXtaddv4i+rQRlWwjUmnzPAqaie40SQq6ErnS43Vu4MNFJ2YB4ETLLg+ccFme5aTNJjGDo+iMsPDYwtgvhe/xtoaSgCjMHFut6eiTGx9MZSDZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263869; c=relaxed/simple;
	bh=44721EPV5+pW7+5PdQZCJJ8ko/qhnXYqVS5s5vuDGmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ldVXu002mz+cKkWsPDuFHWoOk2loM6y3nE2SybM/z9wT0pqZ80OIxeR2upRX862RcSUIcwNTAmpSw3l13Ar0eb1RMtj0CsNe8aW5rN0M9svv5R5nQU1YOUqoeUDb1gLZmwkjvcrYMEBMB+8Ws/fokaJuN1cnHT717SeOIClZNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAO5LPa6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnXROhdt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAO5LPa6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnXROhdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a47+U3tqdVU5MdGX34A/o6y+V93YeOsEi8ukHqKSGSQ=;
	b=fAO5LPa6fSHi6CddF8B4cTDFihJF+yprtsuIU80IEjWZZ1Uh+9pGY2zDw6AOAxftsLM0QW
	dpz5UtPJOYSR+5R+QgWTTy0pwxTtRX0+Dary24qpZGu1fxh0woq0c3WaiDk3DyD5OZLj6E
	Qa4ndjXd44U1e6WmrCesf5QYQl3IWO8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-D2_v-9T1No2xIZq7j0Y6QQ-1; Thu, 24 Sep 2026 11:31:02 -0400
X-MC-Unique: D2_v-9T1No2xIZq7j0Y6QQ-1
X-Mimecast-MFC-AGG-ID: D2_v-9T1No2xIZq7j0Y6QQ_1790263861
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a642d690caso3134466a12.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263861; x=1790868661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a47+U3tqdVU5MdGX34A/o6y+V93YeOsEi8ukHqKSGSQ=;
        b=fnXROhdt0/8WtIO2AmHyqlM7Uf/EnS7RCyJ5fLlgqXmD420Y3TCLD2ERtxc+lq8Bih
         Ne/+TUkETzW2U+3J3JFkJZlqPAHSeKPx9FWwDYdfi4te9pTR/DrEnI19rYLpuKKhCwmd
         lL8I5Jt8E2n5KrqLeI2xKG7WHIchsr66jqCqYzxFn4TFMzXSv+SDPH0f9vMiXNZ35ffV
         oKDtmhw7PxsVKzw6fiSrAG0zbNhMpWJbRNAuuhpbFy/kkwRKRU2uHYCx4vRxQXtD3IME
         94ceWDjhsh0r3UvUCEoEhylgOAcB4G++yx7EaIRb/fKu+mtOILYrs+q8SJ3WpYeVhHZG
         OKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263861; x=1790868661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a47+U3tqdVU5MdGX34A/o6y+V93YeOsEi8ukHqKSGSQ=;
        b=rRiLaxo+8poGj/XuFgb2tbbe2lmDQohM57qA4A5DJVE1RLEP1SMDkzPumw8MgnjL5D
         CcVag3ZaEtuAsjbzJlROubAUopLyjVnyGRoVAe1OpYykL/IuxE+JEDJFXwrm3+ZZnDtc
         gwGoqWygvR3a0ihHmakv6jenO+BN5v3JN54O3rtHR/01bG+FUglgglTmDGnnGL0dIG2y
         klxSslhDFq9ijNWAFkDWHgKz9TcH2QFGkYZjIalbpmG7WRIwPut5i9ZbXsWi/rZKF7zg
         BDKHFKi90w+IDUnWZQrdGjEVGjzWQcencQdljYqliFjveDwKjYmv5EtU+BFP14diphki
         UhbA==
X-Gm-Message-State: AFuF++mBWOxa1C8Q6MnXcYnoDXdxT0tnnmEWM0eQUFTNumHWoUJ8oWe/
	Fh8APSrZAam1GKMZT/AcDBO5hnuyCA1M5CZm7v+wsH9eN/g92Iw5RhnLAabEanCkgBpp2gnasnM
	Jhlvve1CYeo7m14Q6bvTFeafC492TV8/nxG2fHKeI2rNIqDWNG4q5Gm03LNjrcGt/LzVDTQ24h7
	ZLktNJONW6XBIWg8o76vKMihfCRFZ8D4j5z9nLofPyqQRpg1pLhA==
X-Gm-Gg: AYBFou3NIzI5L6FCCrKZUPUwy5obG9d35bx1iJoG1PXcnlM0LUOWyTjx07a69z4x7lb
	4/9Ud7Zc2Y2bYJk6Xto54Z6BpXo4ObB2N3jDQ6oBsYRf/QJIALhvIPtYv6prgXQQw6uC0UKDowg
	JFOCCRU3ih55XkcGSIDjvtgMyNR1yN3NtUZF1QdwPyVRBBCKAus/kzyLM6IT5P2gqcMug9rKrp6
	zFZ6E5FgQ0WUS+reBkTruTZmM7xaGYNHYeWnXuNtC72kbw43WbsZYMWjYEn37ZWWlssIfmMMcZs
	DmqfUaM8pLFpK/TdK+2oGw7RDK9nDThLBdvh3ILcRiwrQ0YlSJ314jK/G7oEyB6j5203florU8J
	lGIm6ybVVxlrpRQgvVj3txTlOaNcbfqTh8FEhyqOZLJ/FMPlbRBkYQirMvseoiGiWtP4HqU0Du2
	2iV7RNOmG7bR1iFQ==
X-Received: by 2002:a05:6402:388f:b0:6aa:734a:a086 with SMTP id 4fb4d7f45d1cf-6aac8f8a39emr2929050a12.29.1790263860125;
        Thu, 24 Sep 2026 08:31:00 -0700 (PDT)
X-Received: by 2002:a05:6402:388f:b0:6aa:734a:a086 with SMTP id 4fb4d7f45d1cf-6aac8f8a39emr2928938a12.29.1790263859174;
        Thu, 24 Sep 2026 08:30:59 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:58 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 09/14] ceph: switch MDS request plumbing to struct ceph_journal_info
Date: Thu, 24 Sep 2026 15:30:39 +0000
Message-Id: <20260924153045.994784-10-amarkuze@redhat.com>
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

Replace ad-hoc journal_info setup in handle_reply() with
ceph_blog_enter_req(mdsc->fsc, &ji, req) / ceph_blog_exit(&ji) so nested
VFS callbacks inherit the BLOG context only when the owning fsc
matches.

Snapshot unlink-conflict names only when a binary context is present.
Keep that preparation in an out-of-line helper and retain the lazy
%pd text fallback.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Assisted-by: LLM
---
 fs/ceph/mds_client.c | 369 +++++++++++++++++++++++++------------------
 1 file changed, 217 insertions(+), 152 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0185c3c5edab..8ae3fa099b45 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -527,7 +527,9 @@ static int parse_reply_info_readdir(void **p, void *end,
 		ceph_decode_need(p, end, _name_len, bad);
 		_name = *p;
 		*p += _name_len;
-		doutc(cl, "parsed dir dname '%.*s'\n", _name_len, _name);
+		boutc_bounded(cl, "parsed dir dname '%.*s'\n",
+			      (_name_len, BLOG_STR(_name, _name_len)),
+			      (_name_len, (const char *)_name));
 
 		if (info->hash_order)
 			rde->raw_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
@@ -677,7 +679,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
-	doutc(cl, "got %u sets of delegated inodes\n", sets);
+	boutc(cl, "got %u sets of delegated inodes\n", sets);
 	while (sets--) {
 		u64 start, len;
 
@@ -711,7 +713,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 			int err = ceph_insert_deleg_ino(s, start++);
 
 			if (!err) {
-				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
+				boutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
 				pr_warn_client(cl,
 					"MDS delegated inode 0x%llx more than once.\n",
@@ -935,6 +937,23 @@ static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
 }
 
+static noinline void ceph_blog_unlink_conflict(struct blog_tls_ctx *blog_ctx,
+					       struct ceph_client *cl,
+					       struct dentry *dentry,
+					       struct dentry *found)
+{
+	struct name_snapshot dname_snap, found_snap;
+
+	take_dentry_name_snapshot(&dname_snap, dentry);
+	take_dentry_name_snapshot(&found_snap, found);
+	CEPH_BLOG_LOG_CLIENT(blog_ctx, cl,
+			     "dentry %p:%s conflict with old %p:%s\n",
+			     dentry, BLOG_STR(dname_snap.name.name, dname_snap.name.len),
+			     found, BLOG_STR(found_snap.name.name, found_snap.name.len));
+	release_dentry_name_snapshot(&dname_snap);
+	release_dentry_name_snapshot(&found_snap);
+}
+
 /*
  * In async unlink case the kclient won't wait for the first reply
  * from MDS and just drop all the links and unhash the dentry and then
@@ -960,6 +979,7 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 	struct ceph_client *cl = fsc->client;
 	struct dentry *pdentry = dentry->d_parent;
+	struct blog_tls_ctx *blog_ctx;
 	struct dentry *udentry, *found = NULL;
 	struct ceph_dentry_info *di;
 	struct qstr dname;
@@ -1000,8 +1020,12 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 	if (likely(!found))
 		return 0;
 
-	doutc(cl, "dentry %p:%pd conflict with old %p:%pd\n", dentry, dentry,
-	      found, found);
+	blog_ctx = ceph_blog_get_ctx(fsc);
+	if (blog_ctx)
+		ceph_blog_unlink_conflict(blog_ctx, cl, dentry, found);
+	else
+		doutc(cl, "dentry %p:%pd conflict with old %p:%pd\n",
+		      dentry, dentry, found, found);
 
 	err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
 			  TASK_KILLABLE);
@@ -1103,7 +1127,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		struct ceph_mds_session **sa;
 		size_t ptr_size = sizeof(struct ceph_mds_session *);
 
-		doutc(cl, "realloc to %d\n", newmax);
+		boutc(cl, "realloc to %d\n", newmax);
 		sa = kcalloc(newmax, ptr_size, GFP_NOFS);
 		if (!sa)
 			goto fail_realloc;
@@ -1116,7 +1140,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		mdsc->max_sessions = newmax;
 	}
 
-	doutc(cl, "mds%d\n", mds);
+	boutc(cl, "mds%d\n", mds);
 	s->s_mdsc = mdsc;
 	s->s_mds = mds;
 	s->s_state = CEPH_MDS_SESSION_NEW;
@@ -1160,7 +1184,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 static void __unregister_session(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *s)
 {
-	doutc(mdsc->fsc->client, "mds%d %p\n", s->s_mds, s);
+	boutc(mdsc->fsc->client, "mds%d %p\n", s->s_mds, s);
 	BUG_ON(mdsc->sessions[s->s_mds] != s);
 	mdsc->sessions[s->s_mds] = NULL;
 	ceph_con_close(&s->s_con);
@@ -1303,7 +1327,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 			return;
 		}
 	}
-	doutc(cl, "%p tid %lld\n", req, req->r_tid);
+	boutc(cl, "%p tid %lld\n", req, req->r_tid);
 	ceph_mdsc_get_request(req);
 	insert_request(&mdsc->request_tree, req);
 
@@ -1328,7 +1352,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 static void __unregister_request(struct ceph_mds_client *mdsc,
 				 struct ceph_mds_request *req)
 {
-	doutc(mdsc->fsc->client, "%p tid %lld\n", req, req->r_tid);
+	boutc(mdsc->fsc->client, "%p tid %lld\n", req, req->r_tid);
 
 	/* Never leave an unregistered request on an unsafe list! */
 	list_del_init(&req->r_unsafe_item);
@@ -1426,7 +1450,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	if (req->r_resend_mds >= 0 &&
 	    (__have_session(mdsc, req->r_resend_mds) ||
 	     ceph_mdsmap_get_state(mdsc->mdsmap, req->r_resend_mds) > 0)) {
-		doutc(cl, "using resend_mds mds%d\n", req->r_resend_mds);
+		boutc(cl, "using resend_mds mds%d\n", req->r_resend_mds);
 		return req->r_resend_mds;
 	}
 
@@ -1443,7 +1467,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			rcu_read_lock();
 			inode = get_nonsnap_parent(req->r_dentry);
 			rcu_read_unlock();
-			doutc(cl, "using snapdir's parent %p %llx.%llx\n",
+			boutc(cl, "using snapdir's parent %p %llx.%llx\n",
 			      inode, ceph_vinop(inode));
 		}
 	} else if (req->r_dentry) {
@@ -1464,7 +1488,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			/* direct snapped/virtual snapdir requests
 			 * based on parent dir inode */
 			inode = get_nonsnap_parent(parent);
-			doutc(cl, "using nonsnap parent %p %llx.%llx\n",
+			boutc(cl, "using nonsnap parent %p %llx.%llx\n",
 			      inode, ceph_vinop(inode));
 		} else {
 			/* dentry target */
@@ -1484,7 +1508,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	if (!inode)
 		goto random;
 
-	doutc(cl, "%p %llx.%llx is_hash=%d (0x%x) mode %d\n", inode,
+	boutc(cl, "%p %llx.%llx is_hash=%d (0x%x) mode %d\n", inode,
 	      ceph_vinop(inode), (int)is_hash, hash, mode);
 	ci = ceph_inode(inode);
 
@@ -1501,7 +1525,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 				get_random_bytes(&r, 1);
 				r %= frag.ndist;
 				mds = frag.dist[r];
-				doutc(cl, "%p %llx.%llx frag %u mds%d (%d/%d)\n",
+				boutc(cl, "%p %llx.%llx frag %u mds%d (%d/%d)\n",
 				      inode, ceph_vinop(inode), frag.frag,
 				      mds, (int)r, frag.ndist);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
@@ -1516,7 +1540,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			if (frag.mds >= 0) {
 				/* choose auth mds */
 				mds = frag.mds;
-				doutc(cl, "%p %llx.%llx frag %u mds%d (auth)\n",
+				boutc(cl, "%p %llx.%llx frag %u mds%d (auth)\n",
 				      inode, ceph_vinop(inode), frag.frag, mds);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE) {
@@ -1541,7 +1565,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		goto random;
 	}
 	mds = cap->session->s_mds;
-	doutc(cl, "%p %llx.%llx mds%d (%scap %p)\n", inode,
+	boutc(cl, "%p %llx.%llx mds%d (%scap %p)\n", inode,
 	      ceph_vinop(inode), mds,
 	      cap == ci->i_auth_cap ? "auth " : "", cap);
 	spin_unlock(&ci->i_ceph_lock);
@@ -1554,7 +1578,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		*random = true;
 
 	mds = ceph_mdsmap_get_random_mds(mdsc->mdsmap);
-	doutc(cl, "chose random mds%d\n", mds);
+	boutc(cl, "chose random mds%d\n", mds);
 	return mds;
 }
 
@@ -1794,7 +1818,7 @@ static int __open_session(struct ceph_mds_client *mdsc,
 
 	/* wait for mds to go active? */
 	mstate = ceph_mdsmap_get_state(mdsc->mdsmap, mds);
-	doutc(mdsc->fsc->client, "open_session to mds%d (%s)\n", mds,
+	boutc(mdsc->fsc->client, "open_session to mds%d (%s)\n", mds,
 	      ceph_mds_state_name(mstate));
 	session->s_state = CEPH_MDS_SESSION_OPENING;
 	session->s_renew_requested = jiffies;
@@ -1843,7 +1867,7 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
 	struct ceph_mds_session *session;
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "to mds%d\n", target);
+	boutc(cl, "to mds%d\n", target);
 
 	mutex_lock(&mdsc->mutex);
 	session = __open_export_target_session(mdsc, target);
@@ -1864,7 +1888,7 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
 		return;
 
 	mi = &mdsc->mdsmap->m_info[mds];
-	doutc(cl, "for mds%d (%d targets)\n", session->s_mds,
+	boutc(cl, "for mds%d (%d targets)\n", session->s_mds,
 	      mi->num_export_targets);
 
 	for (i = 0; i < mi->num_export_targets; i++) {
@@ -1887,7 +1911,7 @@ static int detach_cap_releases(struct ceph_mds_session *session,
 
 	list_splice_init(&session->s_cap_releases, target);
 	session->s_num_cap_releases = 0;
-	doutc(cl, "mds%d\n", session->s_mds);
+	boutc(cl, "mds%d\n", session->s_mds);
 
 	return num_cap_releases;
 }
@@ -1911,7 +1935,7 @@ static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req;
 	struct rb_node *p;
 
-	doutc(cl, "mds%d\n", session->s_mds);
+	boutc(cl, "mds%d\n", session->s_mds);
 	mutex_lock(&mdsc->mutex);
 	while (!list_empty(&session->s_unsafe)) {
 		req = list_first_entry(&session->s_unsafe,
@@ -1953,7 +1977,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 	struct ceph_cap *old_cap = NULL;
 	int ret;
 
-	doutc(cl, "%p mds%d\n", session, session->s_mds);
+	boutc(cl, "%p mds%d\n", session, session->s_mds);
 	spin_lock(&session->s_cap_lock);
 	p = session->s_caps.next;
 	while (p != &session->s_caps) {
@@ -1984,7 +2008,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 		spin_lock(&session->s_cap_lock);
 		p = p->next;
 		if (ceph_cap_is_removed(cap)) {
-			doutc(cl, "finishing cap %p removal\n", cap);
+			boutc(cl, "finishing cap %p removal\n", cap);
 			BUG_ON(cap->session != session);
 			cap->session = NULL;
 			list_del_init(&cap->session_caps);
@@ -2021,7 +2045,7 @@ static int remove_session_caps_cb(struct inode *inode, int mds, void *arg)
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ci, mds);
 	if (cap) {
-		doutc(cl, " removing cap %p, ci is %p, inode is %p\n",
+		boutc(cl, " removing cap %p, ci is %p, inode is %p\n",
 		      cap, ci, &ci->netfs.inode);
 
 		iputs = ceph_purge_inode_cap(inode, cap, &invalidate);
@@ -2046,7 +2070,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
 	struct super_block *sb = fsc->sb;
 	LIST_HEAD(dispose);
 
-	doutc(fsc->client, "on %p\n", session);
+	boutc(fsc->client, "on %p\n", session);
 	ceph_iterate_session_caps(session, remove_session_caps_cb, fsc);
 
 	wake_up_all(&fsc->mdsc->cap_flushing_wq);
@@ -2129,7 +2153,7 @@ static void wake_up_session_caps(struct ceph_mds_session *session, int ev)
 {
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
 
-	doutc(cl, "session %p mds%d\n", session, session->s_mds);
+	boutc(cl, "session %p mds%d\n", session, session->s_mds);
 	ceph_iterate_session_caps(session, wake_up_session_cb,
 				  (void *)(unsigned long)ev);
 }
@@ -2156,12 +2180,12 @@ static int send_renew_caps(struct ceph_mds_client *mdsc,
 	 * with its clients. */
 	state = ceph_mdsmap_get_state(mdsc->mdsmap, session->s_mds);
 	if (state < CEPH_MDS_STATE_RECONNECT) {
-		doutc(cl, "ignoring mds%d (%s)\n", session->s_mds,
+		boutc(cl, "ignoring mds%d (%s)\n", session->s_mds,
 		      ceph_mds_state_name(state));
 		return 0;
 	}
 
-	doutc(cl, "to mds%d (%s)\n", session->s_mds,
+	boutc(cl, "to mds%d (%s)\n", session->s_mds,
 	      ceph_mds_state_name(state));
 	msg = create_session_full_msg(mdsc, CEPH_SESSION_REQUEST_RENEWCAPS,
 				      ++session->s_renew_seq);
@@ -2177,7 +2201,7 @@ static int send_flushmsg_ack(struct ceph_mds_client *mdsc,
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 
-	doutc(cl, "to mds%d (%s)s seq %lld\n", session->s_mds,
+	boutc(cl, "to mds%d (%s)s seq %lld\n", session->s_mds,
 	      ceph_session_state_name(session->s_state), seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_FLUSHMSG_ACK, seq);
 	if (!msg)
@@ -2215,7 +2239,7 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
 				       session->s_mds);
 		}
 	}
-	doutc(cl, "mds%d ttl now %lu, was %s, now %s\n", session->s_mds,
+	boutc(cl, "mds%d ttl now %lu, was %s, now %s\n", session->s_mds,
 	      session->s_cap_ttl, was_stale ? "stale" : "fresh",
 	      time_before(jiffies, session->s_cap_ttl) ? "stale" : "fresh");
 	spin_unlock(&session->s_cap_lock);
@@ -2232,7 +2256,7 @@ static int request_close_session(struct ceph_mds_session *session)
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	struct ceph_msg *msg;
 
-	doutc(cl, "mds%d state %s seq %lld\n", session->s_mds,
+	boutc(cl, "mds%d state %s seq %lld\n", session->s_mds,
 	      ceph_session_state_name(session->s_state), session->s_seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_REQUEST_CLOSE,
 				      session->s_seq);
@@ -2311,7 +2335,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 	wanted = __ceph_caps_file_wanted(ci);
 	oissued = __ceph_caps_issued_other(ci, cap);
 
-	doutc(cl, "%p %llx.%llx cap %p mine %s oissued %s used %s wanted %s\n",
+	boutc(cl, "%p %llx.%llx cap %p mine %s oissued %s used %s wanted %s\n",
 	      inode, ceph_vinop(inode), cap, ceph_cap_string(mine),
 	      ceph_cap_string(oissued), ceph_cap_string(used),
 	      ceph_cap_string(wanted));
@@ -2380,7 +2404,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 			count = icount_read_once(inode);
 			if (count == 1)
 				(*remaining)--;
-			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
+			boutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
 			      inode, ceph_vinop(inode), cap, count);
 		}
 		return 0;
@@ -2401,13 +2425,13 @@ int ceph_trim_caps(struct ceph_mds_client *mdsc,
 	struct ceph_client *cl = mdsc->fsc->client;
 	int trim_caps = session->s_nr_caps - max_caps;
 
-	doutc(cl, "mds%d start: %d / %d, trim %d\n", session->s_mds,
+	boutc(cl, "mds%d start: %d / %d, trim %d\n", session->s_mds,
 	      session->s_nr_caps, max_caps, trim_caps);
 	if (trim_caps > 0) {
 		int remaining = trim_caps;
 
 		ceph_iterate_session_caps(session, trim_caps_cb, &remaining);
-		doutc(cl, "mds%d done: %d / %d, trimmed %d\n",
+		boutc(cl, "mds%d done: %d / %d, trimmed %d\n",
 		      session->s_mds, session->s_nr_caps, max_caps,
 		      trim_caps - remaining);
 	}
@@ -2428,7 +2452,7 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 			list_first_entry(&mdsc->cap_flush_list,
 					 struct ceph_cap_flush, g_list);
 		if (cf->tid <= want_flush_tid) {
-			doutc(cl, "still flushing tid %llu <= %llu\n",
+			boutc(cl, "still flushing tid %llu <= %llu\n",
 			      cf->tid, want_flush_tid);
 			ret = 0;
 		}
@@ -2528,7 +2552,7 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 	int i = 0;
 	long ret;
 
-	doutc(cl, "want %llu\n", want_flush_tid);
+	boutc(cl, "want %llu\n", want_flush_tid);
 
 	do {
 		/* 60 * HZ fits in a long on all supported architectures. */
@@ -2545,7 +2569,7 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 		}
 	} while (ret == 0);
 
-	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
+	boutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
 
 /*
@@ -2611,7 +2635,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 			msg->front.iov_len += sizeof(*cap_barrier);
 
 			msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-			doutc(cl, "mds%d %p\n", session->s_mds, msg);
+			boutc(cl, "mds%d %p\n", session->s_mds, msg);
 			ceph_con_send(&session->s_con, msg);
 			msg = NULL;
 		}
@@ -2631,7 +2655,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 		msg->front.iov_len += sizeof(*cap_barrier);
 
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-		doutc(cl, "mds%d %p\n", session->s_mds, msg);
+		boutc(cl, "mds%d %p\n", session->s_mds, msg);
 		ceph_con_send(&session->s_con, msg);
 	}
 	return;
@@ -2667,10 +2691,10 @@ void ceph_flush_session_cap_releases(struct ceph_mds_client *mdsc,
 	ceph_get_mds_session(session);
 	if (queue_work(mdsc->fsc->cap_wq,
 		       &session->s_cap_release_work)) {
-		doutc(cl, "cap release work queued\n");
+		boutc(cl, "cap release work queued\n");
 	} else {
 		ceph_put_mds_session(session);
-		doutc(cl, "failed to queue cap release work\n");
+		boutc(cl, "failed to queue cap release work\n");
 	}
 }
 
@@ -2691,9 +2715,14 @@ static void ceph_cap_reclaim_work(struct work_struct *work)
 {
 	struct ceph_mds_client *mdsc =
 		container_of(work, struct ceph_mds_client, cap_reclaim_work);
-	int ret = ceph_trim_dentries(mdsc);
+	struct ceph_journal_info __ji;
+	int ret;
+
+	ceph_blog_enter(mdsc->fsc, &__ji);
+	ret = ceph_trim_dentries(mdsc);
 	if (ret == -EAGAIN)
 		ceph_queue_cap_reclaim_work(mdsc);
+	ceph_blog_exit(&__ji);
 }
 
 void ceph_queue_cap_reclaim_work(struct ceph_mds_client *mdsc)
@@ -2702,11 +2731,10 @@ void ceph_queue_cap_reclaim_work(struct ceph_mds_client *mdsc)
 	if (mdsc->stopping)
 		return;
 
-        if (queue_work(mdsc->fsc->cap_wq, &mdsc->cap_reclaim_work)) {
-                doutc(cl, "caps reclaim work queued\n");
-        } else {
-                doutc(cl, "failed to queue caps release work\n");
-        }
+	if (queue_work(mdsc->fsc->cap_wq, &mdsc->cap_reclaim_work))
+		doutc(cl, "caps reclaim work queued\n");
+	else
+		doutc(cl, "failed to queue caps release work\n");
 }
 
 void ceph_reclaim_caps_nr(struct ceph_mds_client *mdsc, int nr)
@@ -2727,11 +2755,10 @@ void ceph_queue_cap_unlink_work(struct ceph_mds_client *mdsc)
 	if (mdsc->stopping)
 		return;
 
-        if (queue_work(mdsc->fsc->cap_wq, &mdsc->cap_unlink_work)) {
-                doutc(cl, "caps unlink work queued\n");
-        } else {
-                doutc(cl, "failed to queue caps unlink work\n");
-        }
+	if (queue_work(mdsc->fsc->cap_wq, &mdsc->cap_unlink_work))
+		doutc(cl, "caps unlink work queued\n");
+	else
+		doutc(cl, "failed to queue caps unlink work\n");
 }
 
 static void ceph_cap_unlink_work(struct work_struct *work)
@@ -2739,8 +2766,11 @@ static void ceph_cap_unlink_work(struct work_struct *work)
 	struct ceph_mds_client *mdsc =
 		container_of(work, struct ceph_mds_client, cap_unlink_work);
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(mdsc->fsc, &__ji);
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 	spin_lock(&mdsc->cap_delay_lock);
 	while (!list_empty(&mdsc->cap_unlink_delay_list)) {
 		struct ceph_inode_info *ci;
@@ -2754,7 +2784,7 @@ static void ceph_cap_unlink_work(struct work_struct *work)
 		inode = igrab(&ci->netfs.inode);
 		if (inode) {
 			spin_unlock(&mdsc->cap_delay_lock);
-			doutc(cl, "on %p %llx.%llx\n", inode,
+			boutc(cl, "on %p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			ceph_check_caps(ci, CHECK_CAPS_FLUSH);
 			iput(inode);
@@ -2762,7 +2792,8 @@ static void ceph_cap_unlink_work(struct work_struct *work)
 		}
 	}
 	spin_unlock(&mdsc->cap_delay_lock);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
+	ceph_blog_exit(&__ji);
 }
 
 /*
@@ -2977,7 +3008,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 		spin_lock(&cur->d_lock);
 		inode = d_inode(cur);
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
-			doutc(cl, "path+%d: %p SNAPDIR\n", pos, cur);
+			boutc(cl, "path+%d: %p SNAPDIR\n", pos, cur);
 			spin_unlock(&cur->d_lock);
 			parent = dget_parent(cur);
 		} else if (for_wire && inode && dentry != cur &&
@@ -3076,8 +3107,11 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 	else
 		path_info->vino.snap = CEPH_NOSNAP;
 
-	doutc(cl, "on %p %d built %llx '%.*s'\n", dentry, d_count(dentry),
-	      base, PATH_MAX - 1 - pos, path + pos);
+	boutc_bounded(cl, "on %p %d built %llx '%.*s'\n",
+		      (dentry, d_count(dentry), base, PATH_MAX - 1 - pos,
+		       BLOG_STR(path + pos, PATH_MAX - 1 - pos)),
+		      (dentry, d_count(dentry), base, PATH_MAX - 1 - pos,
+		       (const char *)(path + pos)));
 	return path + pos;
 }
 
@@ -3154,12 +3188,15 @@ static int set_request_path_attr(struct ceph_mds_client *mdsc, struct inode *rin
 
 	if (rinode) {
 		r = build_inode_path(rinode, path_info);
-		doutc(cl, " inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
+		boutc(cl, " inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
 		      ceph_snap(rinode));
 	} else if (rdentry) {
 		r = build_dentry_path(mdsc, rdentry, rdiri, path_info, parent_locked);
-		doutc(cl, " dentry %p %llx/%.*s\n", rdentry, path_info->vino.ino,
-		      path_info->pathlen, path_info->path);
+		boutc_bounded(cl, " dentry %p %llx/%.*s\n",
+			      (rdentry, path_info->vino.ino, path_info->pathlen,
+			       BLOG_STR(path_info->path, path_info->pathlen)),
+			      (rdentry, path_info->vino.ino, path_info->pathlen,
+			       (const char *)path_info->path));
 	} else if (rpath || rino) {
 		path_info->vino.ino = rino;
 		path_info->vino.snap = CEPH_NOSNAP;
@@ -3167,7 +3204,10 @@ static int set_request_path_attr(struct ceph_mds_client *mdsc, struct inode *rin
 		path_info->pathlen = rpath ? strlen(rpath) : 0;
 		path_info->freepath = false;
 
-		doutc(cl, " path %.*s\n", path_info->pathlen, rpath);
+		boutc_bounded(cl, " path %.*s\n",
+			      (path_info->pathlen,
+			       BLOG_STR(rpath, path_info->pathlen)),
+			      (path_info->pathlen, (const char *)rpath));
 	}
 
 	return r;
@@ -3586,7 +3626,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		else
 			req->r_sent_on_mseq = -1;
 	}
-	doutc(cl, "%p tid %lld %s (attempt %d)\n", req, req->r_tid,
+	boutc(cl, "%p tid %lld %s (attempt %d)\n", req, req->r_tid,
 	      ceph_mds_op_name(req->r_op), req->r_attempts);
 
 	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
@@ -3655,7 +3695,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		nhead->ext_num_retry = cpu_to_le32(req->r_attempts - 1);
 	}
 
-	doutc(cl, " r_parent = %p\n", req->r_parent);
+	boutc(cl, " r_parent = %p\n", req->r_parent);
 	return 0;
 }
 
@@ -3761,7 +3801,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	}
 	req->r_session = ceph_get_mds_session(session);
 
-	doutc(cl, "mds%d session %p state %s\n", mds, session,
+	boutc(cl, "mds%d session %p state %s\n", mds, session,
 	      ceph_session_state_name(session->s_state));
 
 	/*
@@ -3858,7 +3898,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		cap = ci->i_auth_cap;
 		if (test_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
 		    mds != cap->mds) {
-			doutc(cl, "session changed for auth cap %d -> %d\n",
+			boutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
 			/* Remove the auth cap from old session */
@@ -3886,7 +3926,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	ceph_put_mds_session(session);
 finish:
 	if (err) {
-		doutc(cl, "early error %d\n", err);
+		boutc(cl, "early error %d\n", err);
 		req->r_err = err;
 		complete_request(mdsc, req);
 		__unregister_request(mdsc, req);
@@ -3927,7 +3967,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	struct ceph_mds_request *req;
 	struct rb_node *p = rb_first(&mdsc->request_tree);
 
-	doutc(cl, "kick_requests mds%d\n", mds);
+	boutc(cl, "kick_requests mds%d\n", mds);
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
@@ -3986,7 +4026,7 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	if (req->r_inode) {
 		err = ceph_wait_on_async_create(req->r_inode);
 		if (err) {
-			doutc(cl, "wait for async create returned: %d\n", err);
+			boutc(cl, "wait for async create returned: %d\n", err);
 			return err;
 		}
 	}
@@ -4017,7 +4057,7 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 	int err;
 
 	/* wait */
-	doutc(cl, "do_request waiting\n");
+	boutc(cl, "do_request waiting\n");
 	if (wait_func) {
 		err = wait_func(mdsc, req);
 	} else {
@@ -4031,14 +4071,14 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 		else
 			err = timeleft;  /* killed */
 	}
-	doutc(cl, "do_request waited, got %d\n", err);
+	boutc(cl, "do_request waited, got %d\n", err);
 	mutex_lock(&mdsc->mutex);
 
 	/* only abort if we didn't race with a real reply */
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = le32_to_cpu(req->r_reply_info.head->result);
 	} else if (err < 0) {
-		doutc(cl, "aborted request %lld with %d\n", req->r_tid, err);
+		boutc(cl, "aborted request %lld with %d\n", req->r_tid, err);
 
 		/*
 		 * ensure we aren't running concurrently with
@@ -4072,13 +4112,13 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 	struct ceph_client *cl = mdsc->fsc->client;
 	int err;
 
-	doutc(cl, "do_request on %p\n", req);
+	boutc(cl, "do_request on %p\n", req);
 
 	/* issue */
 	err = ceph_mdsc_submit_request(mdsc, dir, req);
 	if (!err)
 		err = ceph_mdsc_wait_request(mdsc, req, NULL);
-	doutc(cl, "do_request %p done, result %d\n", req, err);
+	boutc(cl, "do_request %p done, result %d\n", req, err);
 	return err;
 }
 
@@ -4092,7 +4132,7 @@ void ceph_invalidate_dir_request(struct ceph_mds_request *req)
 	struct inode *old_dir = req->r_old_dentry_dir;
 	struct ceph_client *cl = req->r_mdsc->fsc->client;
 
-	doutc(cl, "invalidate_dir_request %p %p (complete, lease(s))\n",
+	boutc(cl, "invalidate_dir_request %p %p (complete, lease(s))\n",
 	      dir, old_dir);
 
 	ceph_dir_clear_complete(dir);
@@ -4124,10 +4164,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	int err, result;
 	int mds = session->s_mds;
 	bool close_sessions = false;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(mdsc->fsc, &__ji);
 
 	if (msg->front.iov_len < sizeof(*head)) {
 		pr_err_client(cl, "got corrupt (short) reply\n");
 		ceph_msg_dump(msg);
+		ceph_blog_exit(&__ji);
 		return;
 	}
 
@@ -4136,11 +4180,12 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	mutex_lock(&mdsc->mutex);
 	req = lookup_get_request(mdsc, tid);
 	if (!req) {
-		doutc(cl, "on unknown tid %llu\n", tid);
+		boutc(cl, "on unknown tid %llu\n", tid);
 		mutex_unlock(&mdsc->mutex);
+		ceph_blog_exit(&__ji);
 		return;
 	}
-	doutc(cl, "handle_reply %p\n", req);
+	boutc(cl, "handle_reply %p\n", req);
 
 	/* correct session? */
 	if (req->r_session != session) {
@@ -4184,7 +4229,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			 * response.  And even if it did, there is nothing
 			 * useful we could do with a revised return value.
 			 */
-			doutc(cl, "got safe reply %llu, mds%d\n", tid, mds);
+			boutc(cl, "got safe reply %llu, mds%d\n", tid, mds);
 
 			mutex_unlock(&mdsc->mutex);
 			goto out;
@@ -4201,7 +4246,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	 */
 	mutex_unlock(&mdsc->mutex);
 
-	doutc(cl, "tid %lld result %d\n", tid, result);
+	boutc(cl, "tid %lld result %d\n", tid, result);
 	if (test_bit(CEPHFS_FEATURE_REPLY_ENCODING, &session->s_features))
 		err = parse_reply_info(session, msg, req, (u64)-1);
 	else
@@ -4270,21 +4315,20 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	/* insert trace into our cache */
 	mutex_lock(&req->r_fill_mutex);
 
-	/* disable fs reclaim while we are using current->journal_info
-	 * for our own purposes, or else shrinkers of other
-	 * filesystems might dereference this pointer as a different
-	 * type
-	 */
+	/* Disable filesystem reclaim while journal_info carries Ceph state. */
 	nofs_flags = memalloc_nofs_save();
-
-	current->journal_info = req;
-	err = ceph_fill_trace(mdsc->fsc->sb, req);
-	if (err == 0) {
-		if (result == 0 && (req->r_op == CEPH_MDS_OP_READDIR ||
-				    req->r_op == CEPH_MDS_OP_LSSNAP))
-			err = ceph_readdir_prepopulate(req, req->r_session);
+	{
+		struct ceph_journal_info ji;
+
+		ceph_blog_enter_req(mdsc->fsc, &ji, req);
+		err = ceph_fill_trace(mdsc->fsc->sb, req);
+		if (err == 0) {
+			if (result == 0 && (req->r_op == CEPH_MDS_OP_READDIR ||
+					    req->r_op == CEPH_MDS_OP_LSSNAP))
+				err = ceph_readdir_prepopulate(req, req->r_session);
+		}
+		ceph_blog_exit(&ji);
 	}
-	current->journal_info = NULL;
 	memalloc_nofs_restore(nofs_flags);
 	mutex_unlock(&req->r_fill_mutex);
 
@@ -4315,7 +4359,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			set_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
 		}
 	} else {
-		doutc(cl, "reply arrived after request %lld was aborted\n", tid);
+		boutc(cl, "reply arrived after request %lld was aborted\n", tid);
 	}
 	mutex_unlock(&mdsc->mutex);
 
@@ -4332,6 +4376,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	/* Defer closing the sessions after s_mutex lock being released */
 	if (close_sessions)
 		ceph_mdsc_close_sessions(mdsc);
+	ceph_blog_exit(&__ji);
 	return;
 }
 
@@ -4353,6 +4398,9 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *end = p + msg->front.iov_len;
 	bool aborted = false;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(mdsc->fsc, &__ji);
 
 	ceph_decode_need(&p, end, 2*sizeof(u32), bad);
 	next_mds = ceph_decode_32(&p);
@@ -4362,12 +4410,13 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	req = lookup_get_request(mdsc, tid);
 	if (!req) {
 		mutex_unlock(&mdsc->mutex);
-		doutc(cl, "forward tid %llu to mds%d - req dne\n", tid, next_mds);
+		boutc(cl, "forward tid %llu to mds%d - req dne\n", tid, next_mds);
+		ceph_blog_exit(&__ji);
 		return;  /* dup reply? */
 	}
 
 	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
-		doutc(cl, "forward tid %llu aborted, unregistering\n", tid);
+		boutc(cl, "forward tid %llu aborted, unregistering\n", tid);
 		__unregister_request(mdsc, req);
 	} else if (fwd_seq <= req->r_num_fwd || (uint32_t)fwd_seq >= U32_MAX) {
 		/*
@@ -4387,7 +4436,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 					   tid);
 	} else {
 		/* resend. forward race not possible; mds would drop */
-		doutc(cl, "forward tid %llu to mds%d (we resend)\n", tid, next_mds);
+		boutc(cl, "forward tid %llu to mds%d (we resend)\n", tid, next_mds);
 		BUG_ON(req->r_err);
 		BUG_ON(test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags));
 		req->r_attempts = 0;
@@ -4402,11 +4451,13 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	if (aborted)
 		complete_request(mdsc, req);
 	ceph_mdsc_put_request(req);
+	ceph_blog_exit(&__ji);
 	return;
 
 bad:
 	pr_err_client(cl, "decode error err=%d\n", err);
 	ceph_msg_dump(msg);
+	ceph_blog_exit(&__ji);
 }
 
 static int __decode_session_metadata(void **p, void *end,
@@ -4456,7 +4507,9 @@ static void handle_session(struct ceph_mds_session *session,
 	int wake = 0;
 	bool blocklisted = false;
 	u32 i;
+	struct ceph_journal_info __ji;
 
+	ceph_blog_enter(mdsc->fsc, &__ji);
 
 	/* decode */
 	ceph_decode_need(&p, end, sizeof(*h), bad);
@@ -4503,7 +4556,7 @@ static void handle_session(struct ceph_mds_session *session,
 
 	if (msg_version >= 6) {
 		ceph_decode_32_safe(&p, end, cap_auths_num, bad);
-		doutc(cl, "cap_auths_num %d\n", cap_auths_num);
+		boutc(cl, "cap_auths_num %d\n", cap_auths_num);
 
 		if (cap_auths_num && op != CEPH_SESSION_OPEN) {
 			WARN_ON_ONCE(op != CEPH_SESSION_OPEN);
@@ -4514,6 +4567,7 @@ static void handle_session(struct ceph_mds_session *session,
 					 cap_auths_num);
 		if (!cap_auths) {
 			pr_err_client(cl, "No memory for cap_auths\n");
+			ceph_blog_exit(&__ji);
 			return;
 		}
 
@@ -4577,7 +4631,7 @@ static void handle_session(struct ceph_mds_session *session,
 			ceph_decode_8_safe(&p, end, cap_auths[i].match.root_squash, bad);
 			ceph_decode_8_safe(&p, end, cap_auths[i].readable, bad);
 			ceph_decode_8_safe(&p, end, cap_auths[i].writeable, bad);
-			doutc(cl, "uid %lld, num_gids %u, path %s, fs_name %s, root_squash %d, readable %d, writeable %d\n",
+			boutc(cl, "uid %lld, num_gids %u, path %s, fs_name %s, root_squash %d, readable %d, writeable %d\n",
 			      cap_auths[i].match.uid, cap_auths[i].match.num_gids,
 			      cap_auths[i].match.path, cap_auths[i].match.fs_name,
 			      cap_auths[i].match.root_squash,
@@ -4614,7 +4668,7 @@ static void handle_session(struct ceph_mds_session *session,
 
 	mutex_lock(&session->s_mutex);
 
-	doutc(cl, "mds%d %s %p state %s seq %llu\n", mds,
+	boutc(cl, "mds%d %s %p state %s seq %llu\n", mds,
 	      ceph_session_op_name(op), session,
 	      ceph_session_state_name(session->s_state), seq);
 
@@ -4697,7 +4751,7 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_FORCE_RO:
-		doutc(cl, "force_session_readonly %p\n", session);
+		boutc(cl, "force_session_readonly %p\n", session);
 		spin_lock(&session->s_cap_lock);
 		session->s_readonly = true;
 		spin_unlock(&session->s_cap_lock);
@@ -4736,6 +4790,7 @@ static void handle_session(struct ceph_mds_session *session,
 	}
 	if (op == CEPH_SESSION_CLOSE)
 		ceph_put_mds_session(session);
+	ceph_blog_exit(&__ji);
 	return;
 
 bad:
@@ -4749,6 +4804,7 @@ static void handle_session(struct ceph_mds_session *session,
 		kfree(cap_auths[i].match.fs_name);
 	}
 	kfree(cap_auths);
+	ceph_blog_exit(&__ji);
 	return;
 }
 
@@ -4759,7 +4815,7 @@ void ceph_mdsc_release_dir_caps(struct ceph_mds_request *req)
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		doutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		boutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs(ceph_inode(req->r_parent), dcaps);
 	}
 }
@@ -4771,7 +4827,7 @@ void ceph_mdsc_release_dir_caps_async(struct ceph_mds_request *req)
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		doutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		boutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs_async(ceph_inode(req->r_parent), dcaps);
 	}
 }
@@ -4785,7 +4841,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req, *nreq;
 	struct rb_node *p;
 
-	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
+	boutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
 	mutex_lock(&mdsc->mutex);
 	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item)
@@ -4963,7 +5019,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		err = 0;
 		goto out_err;
 	}
-	doutc(cl, " adding %p ino %llx.%llx cap %p %lld %s\n", inode,
+	boutc(cl, " adding %p ino %llx.%llx cap %p %lld %s\n", inode,
 	      ceph_vinop(inode), cap, cap->cap_id,
 	      ceph_cap_string(cap->issued));
 
@@ -5167,7 +5223,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			ceph_pagelist_encode_32(pagelist, sizeof(sr_rec));
 		}
 
-		doutc(cl, " adding snap realm %llx seq %lld parent %llx\n",
+		boutc(cl, " adding snap realm %llx seq %lld parent %llx\n",
 		      realm->ino, realm->seq, realm->parent_ino);
 		sr_rec.ino = cpu_to_le64(realm->ino);
 		sr_rec.seq = cpu_to_le64(realm->seq);
@@ -5250,7 +5306,7 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
-	doutc(cl, "session %p state %s\n", session,
+	boutc(cl, "session %p state %s\n", session,
 	      ceph_session_state_name(session->s_state));
 
 	atomic_inc(&session->s_cap_gen);
@@ -5902,7 +5958,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	unsigned long targets[DIV_ROUND_UP(CEPH_MAX_MDS, sizeof(unsigned long))] = {0};
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "new %u old %u\n", newmap->m_epoch, oldmap->m_epoch);
+	boutc(cl, "new %u old %u\n", newmap->m_epoch, oldmap->m_epoch);
 
 	if (newmap->m_info) {
 		for (i = 0; i < newmap->possible_max_rank; i++) {
@@ -5918,7 +5974,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
-		doutc(cl, "mds%d state %s%s -> %s%s (session %s)\n",
+		boutc(cl, "mds%d state %s%s -> %s%s (session %s)\n",
 		      i, ceph_mds_state_name(oldstate),
 		      ceph_mdsmap_is_laggy(oldmap, i) ? " (laggy)" : "",
 		      ceph_mds_state_name(newstate),
@@ -6039,7 +6095,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				continue;
 			}
 		}
-		doutc(cl, "send reconnect to export target mds.%d\n", i);
+		boutc(cl, "send reconnect to export target mds.%d\n", i);
 		mutex_unlock(&mdsc->mutex);
 		err = send_mds_reconnect(mdsc, s);
 		if (err)
@@ -6059,7 +6115,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		if (s->s_state == CEPH_MDS_SESSION_OPEN ||
 		    s->s_state == CEPH_MDS_SESSION_HUNG ||
 		    s->s_state == CEPH_MDS_SESSION_CLOSING) {
-			doutc(cl, " connecting to export targets of laggy mds%d\n", i);
+			boutc(cl, " connecting to export targets of laggy mds%d\n", i);
 			__open_export_target_sessions(mdsc, s);
 		}
 	}
@@ -6098,7 +6154,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 	struct qstr dname;
 	int release = 0;
 
-	doutc(cl, "from mds%d\n", mds);
+	boutc(cl, "from mds%d\n", mds);
 
 	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
 		return;
@@ -6116,19 +6172,22 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 
 	/* lookup inode */
 	inode = ceph_find_inode(sb, vino);
-	doutc(cl, "%s, ino %llx %p %.*s\n", ceph_lease_op_name(h->action),
-	      vino.ino, inode, dname.len, dname.name);
+	boutc_bounded(cl, "%s, ino %llx %p %.*s\n",
+		      (ceph_lease_op_name(h->action), vino.ino, inode, dname.len,
+		       BLOG_STR(dname.name, dname.len)),
+		      (ceph_lease_op_name(h->action), vino.ino, inode, dname.len,
+		       (const char *)dname.name));
 
 	mutex_lock(&session->s_mutex);
 	if (!inode) {
-		doutc(cl, "no inode %llx\n", vino.ino);
+		boutc(cl, "no inode %llx\n", vino.ino);
 		goto release;
 	}
 
 	/* dentry */
 	parent = d_find_alias(inode);
 	if (!parent) {
-		doutc(cl, "no parent dentry on inode %p\n", inode);
+		boutc(cl, "no parent dentry on inode %p\n", inode);
 		WARN_ON(1);
 		goto release;  /* hrm... */
 	}
@@ -6202,7 +6261,7 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 	struct inode *dir;
 	int len = sizeof(*lease) + sizeof(u32) + NAME_MAX;
 
-	doutc(cl, "identry %p %s to mds%d\n", dentry, ceph_lease_op_name(action),
+	boutc(cl, "identry %p %s to mds%d\n", dentry, ceph_lease_op_name(action),
 	      session->s_mds);
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_LEASE, len, GFP_NOFS, false);
@@ -6289,7 +6348,7 @@ void inc_session_sequence(struct ceph_mds_session *s)
 	if (s->s_state == CEPH_MDS_SESSION_CLOSING) {
 		int ret;
 
-		doutc(cl, "resending session close request for mds%d\n", s->s_mds);
+		boutc(cl, "resending session close request for mds%d\n", s->s_mds);
 		ret = request_close_session(s);
 		if (ret < 0)
 			pr_err_client(cl, "unable to close session to mds%d: %d\n",
@@ -6317,15 +6376,20 @@ static void delayed_work(struct work_struct *work)
 {
 	struct ceph_mds_client *mdsc =
 		container_of(work, struct ceph_mds_client, delayed_work.work);
+	struct ceph_journal_info __ji;
 	unsigned long delay;
 	int renew_interval;
 	int renew_caps;
 	int i;
 
-	doutc(mdsc->fsc->client, "mdsc delayed_work\n");
+	ceph_blog_enter(mdsc->fsc, &__ji);
 
-	if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED)
+	boutc(mdsc->fsc->client, "mdsc delayed_work\n");
+
+	if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED) {
+		ceph_blog_exit(&__ji);
 		return;
+	}
 
 	mutex_lock(&mdsc->mutex);
 	renew_interval = mdsc->mdsmap->m_session_timeout >> 2;
@@ -6371,6 +6435,7 @@ static void delayed_work(struct work_struct *work)
 	maybe_recover_session(mdsc);
 
 	schedule_delayed(mdsc, delay);
+	ceph_blog_exit(&__ji);
 }
 
 int ceph_mdsc_init(struct ceph_fs_client *fsc)
@@ -6478,20 +6543,20 @@ static void wait_requests(struct ceph_mds_client *mdsc)
 	if (__get_oldest_req(mdsc)) {
 		mutex_unlock(&mdsc->mutex);
 
-		doutc(cl, "waiting for requests\n");
+		boutc(cl, "waiting for requests\n");
 		wait_for_completion_timeout(&mdsc->safe_umount_waiters,
 				    ceph_timeout_jiffies(opts->mount_timeout));
 
 		/* tear down remaining requests */
 		mutex_lock(&mdsc->mutex);
 		while ((req = __get_oldest_req(mdsc))) {
-			doutc(cl, "timed out on tid %llu\n", req->r_tid);
+			boutc(cl, "timed out on tid %llu\n", req->r_tid);
 			list_del_init(&req->r_wait);
 			__unregister_request(mdsc, req);
 		}
 	}
 	mutex_unlock(&mdsc->mutex);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 void send_flush_mdlog(struct ceph_mds_session *s)
@@ -6506,7 +6571,7 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 		return;
 
 	mutex_lock(&s->s_mutex);
-	doutc(cl, "request mdlog flush to mds%d (%s)s seq %lld\n",
+	boutc(cl, "request mdlog flush to mds%d (%s)s seq %lld\n",
 	      s->s_mds, ceph_session_state_name(s->s_state), s->s_seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_REQUEST_FLUSH_MDLOG,
 				      s->s_seq);
@@ -6581,7 +6646,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 			bool free_tpath = false;
 			int m, n;
 
-			doutc(cl, "server path %s, tpath %s, match.path %s\n",
+			boutc(cl, "server path %s, tpath %s, match.path %s\n",
 			      spath, tpath, auth->match.path);
 			if (spath && (m = strlen(spath)) != 1) {
 				/* mount path + '/' + tpath + an extra space */
@@ -6605,7 +6670,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 				_tpath[tlen - 1] = '\0';
 				tlen -= 1;
 			}
-			doutc(cl, "_tpath %s\n", _tpath);
+			boutc(cl, "_tpath %s\n", _tpath);
 
 			/*
 			 * In case first == _tpath && tlen == len:
@@ -6635,7 +6700,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 		}
 	}
 
-	doutc(cl, "matched\n");
+	boutc(cl, "matched\n");
 	return 1;
 }
 
@@ -6649,7 +6714,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	bool root_squash_perms = true;
 	int i, err;
 
-	doutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
+	boutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
 	      tpath, mask, caller_uid, caller_gid);
 
 	mutex_lock(&mdsc->mutex);
@@ -6677,24 +6742,24 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 
 	put_cred(cred);
 
-	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
+	boutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
 	      rw_perms_s);
 	if (root_squash_perms && rw_perms_s == NULL) {
 		mutex_unlock(&mdsc->mutex);
-		doutc(cl, "access allowed\n");
+		boutc(cl, "access allowed\n");
 		return 0;
 	}
 
 	if (!root_squash_perms) {
-		doutc(cl, "root_squash is enabled and user(%d %d) isn't allowed to write",
+		boutc(cl, "root_squash is enabled and user(%d %d) isn't allowed to write",
 		      caller_uid, caller_gid);
 	}
 	if (rw_perms_s) {
-		doutc(cl, "mds auth caps readable/writeable %d/%d while request r/w %d/%d",
+		boutc(cl, "mds auth caps readable/writeable %d/%d while request r/w %d/%d",
 		      rw_perms_s->readable, rw_perms_s->writeable,
 		      !!(mask & MAY_READ), !!(mask & MAY_WRITE));
 	}
-	doutc(cl, "access denied\n");
+	boutc(cl, "access denied\n");
 	mutex_unlock(&mdsc->mutex);
 	return -EACCES;
 }
@@ -6705,7 +6770,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
  */
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
-	doutc(mdsc->fsc->client, "begin\n");
+	boutc(mdsc->fsc->client, "begin\n");
 	mdsc->stopping = CEPH_MDSC_STOPPING_BEGIN;
 
 	ceph_mdsc_iterate_sessions(mdsc, send_flush_mdlog, true);
@@ -6720,7 +6785,7 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 	ceph_msgr_flush();
 
 	ceph_cleanup_quotarealms_inodes(mdsc);
-	doutc(mdsc->fsc->client, "done\n");
+	boutc(mdsc->fsc->client, "done\n");
 }
 
 /*
@@ -6735,7 +6800,7 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	struct rb_node *n;
 
 	mutex_lock(&mdsc->mutex);
-	doutc(cl, "want %lld\n", want_tid);
+	boutc(cl, "want %lld\n", want_tid);
 restart:
 	req = __get_oldest_req(mdsc);
 	while (req && req->r_tid <= want_tid) {
@@ -6769,7 +6834,7 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 			} else {
 				ceph_put_mds_session(s);
 			}
-			doutc(cl, "wait on %llu (want %llu)\n",
+			boutc(cl, "wait on %llu (want %llu)\n",
 			      req->r_tid, want_tid);
 			wait_for_completion(&req->r_safe_completion);
 
@@ -6788,7 +6853,7 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	}
 	mutex_unlock(&mdsc->mutex);
 	ceph_put_mds_session(last_session);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
@@ -6799,7 +6864,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 	if (READ_ONCE(mdsc->fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN)
 		return;
 
-	doutc(cl, "sync\n");
+	boutc(cl, "sync\n");
 	mutex_lock(&mdsc->mutex);
 	want_tid = mdsc->last_tid;
 	mutex_unlock(&mdsc->mutex);
@@ -6816,7 +6881,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
 
-	doutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
+	boutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
 
 	flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
 	wait_caps_flush(mdsc, want_flush);
@@ -6843,7 +6908,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	int i;
 	int skipped = 0;
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 
 	/* close sessions */
 	mutex_lock(&mdsc->mutex);
@@ -6861,7 +6926,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	}
 	mutex_unlock(&mdsc->mutex);
 
-	doutc(cl, "waiting for sessions to close\n");
+	boutc(cl, "waiting for sessions to close\n");
 	wait_event_timeout(mdsc->session_close_wq,
 			   done_closing_sessions(mdsc, skipped),
 			   ceph_timeout_jiffies(opts->mount_timeout));
@@ -6890,7 +6955,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	cancel_work_sync(&mdsc->cap_unlink_work);
 	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
 
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
@@ -6898,7 +6963,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 	struct ceph_mds_session *session;
 	int mds;
 
-	doutc(mdsc->fsc->client, "force umount\n");
+	boutc(mdsc->fsc->client, "force umount\n");
 
 	mutex_lock(&mdsc->mutex);
 	for (mds = 0; mds < mdsc->max_sessions; mds++) {
@@ -6929,7 +6994,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 
 static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 {
-	doutc(mdsc->fsc->client, "stop\n");
+	boutc(mdsc->fsc->client, "stop\n");
 	/*
 	 * Make sure the delayed work stopped before releasing
 	 * the resources.
@@ -6962,7 +7027,7 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 {
 	struct ceph_mds_client *mdsc = fsc->mdsc;
-	doutc(fsc->client, "%p\n", mdsc);
+	boutc(fsc->client, "%p\n", mdsc);
 
 	if (!mdsc)
 		return;
@@ -6995,7 +7060,7 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 
 	fsc->mdsc = NULL;
 	kfree(mdsc);
-	doutc(fsc->client, "%p done\n", mdsc);
+	boutc(fsc->client, "%p done\n", mdsc);
 }
 
 void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
@@ -7013,7 +7078,7 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	ceph_decode_need(&p, end, sizeof(u32), bad);
 	epoch = ceph_decode_32(&p);
 
-	doutc(cl, "epoch %u\n", epoch);
+	boutc(cl, "epoch %u\n", epoch);
 
 	/* struct_v, struct_cv, map_len, epoch, legacy_client_fscid */
 	ceph_decode_skip_n(&p, end, 2 + sizeof(u32) * 3, bad);
@@ -7089,12 +7154,12 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 		return;
 	epoch = ceph_decode_32(&p);
 	maplen = ceph_decode_32(&p);
-	doutc(cl, "epoch %u len %d\n", epoch, (int)maplen);
+	boutc(cl, "epoch %u len %d\n", epoch, (int)maplen);
 
 	/* do we need it? */
 	mutex_lock(&mdsc->mutex);
 	if (mdsc->mdsmap && epoch <= mdsc->mdsmap->m_epoch) {
-		doutc(cl, "epoch %u <= our %u\n", epoch, mdsc->mdsmap->m_epoch);
+		boutc(cl, "epoch %u <= our %u\n", epoch, mdsc->mdsmap->m_epoch);
 		mutex_unlock(&mdsc->mutex);
 		return;
 	}
-- 
2.34.1

