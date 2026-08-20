Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390243CE72
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230600; cv=none; b=jzgImLBrq2w8kVsE8fTpC5QA4wj4Z2aQPOQA7eezX/opfhEMN95jUh7t+PkJDeISWRDInaJeAglc1nMwlom7pbZsZWNFq0kVrRSfHYo9BcjhxYW49/jW3G+PuxQMSQ35PqtjYqYN2tfuAxhV+7maFONPdH9LtpGLkIvAoXQwXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230600; c=relaxed/simple;
	bh=Qa6qMCbYAMkbzIqIDB/swjHg6HNk4VhuGID7w7aZgNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJl7GVDhWYukeV6TcJYcdm0u5aEbwWVlxEAAbu3+9xKJCsKSK2H6G7krVcPdaM0+nNnCswW9wnS4HT817X6AblWNDaeL8QItTgfJWok9FTLnsZgxAG7J2pnG28Xvn4FCIUgjUfFvPiVKdanKlvgHumi9IHG1C4AUXVn10h8zo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce63e60O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ptXMcl9W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce63e60O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ptXMcl9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=la4JlyALIh/buvbx2dW7EiCypmDzYg1MYdq2d8l8n5c=;
	b=ce63e60OT+WmQ0qE0VXKkoGsdsA+khiqeknn0kfPljc6tW7WkNoJXuAjo/LRWb1uZkq5ku
	K64j275fsWIYa2IWb+rzpeNdwlSV5AsukcoTHPt53v1KvVn+Ei5lRsofoJUcDVKEjJpf3C
	pkv7grpEDAK5z6wnmxE9KK6oubY6u7E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-BwcbueG-PcGL9Mww6I5kFA-1; Thu, 20 Aug 2026 08:56:34 -0400
X-MC-Unique: BwcbueG-PcGL9Mww6I5kFA-1
X-Mimecast-MFC-AGG-ID: BwcbueG-PcGL9Mww6I5kFA_1787230593
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69abf97d53aso2224436a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230593; x=1787835393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=la4JlyALIh/buvbx2dW7EiCypmDzYg1MYdq2d8l8n5c=;
        b=ptXMcl9WnL0TqeCM9vqZlRWYtGTDcH3LMrsq+nD8C6ei4NhVsv9ev5Dd+4YMxrdT5P
         lMhEuHiEYCFXMNc6ATyVwd5KpwACoe7KHNcuNQJwLt1sAJG9thjl8yRLuYkLTB/GSEXz
         YdOe0UkEowAg9aCfB5JL4ZG24Ow8v5qRkFjZX8rt0ojwy/BYKWZoy/PpO7MN4mLrsoxG
         gkn4azDHf0KNf/TO8tApE7Kel3/jdIbBRXI+vo0pKe+2K6abKr7DOjnrK9yqIttCmX6/
         OS7HAgffyvpDf0vd+ROSkqpuwcFR5katFx4me/uekZ019rJp+OLD4idpMRNxHd6CLNwy
         EvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230593; x=1787835393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=la4JlyALIh/buvbx2dW7EiCypmDzYg1MYdq2d8l8n5c=;
        b=Z6LKmdK+QoVNp5dgfIHRubCvMD/N++i1nwT6HgjDBGGUcMh7bGCy6FybX9BkdnuJKb
         R5LjzW13Y3M9YaGBJFOzBn5cSj7Q1Om0T1VkNQGwjiIuxDkYeUEWL6DpoJHVoPRxST0g
         KtKkd/GWeFwWx320hLzLcG163tL09fBb9mgGsk2rV8yfJOLxJWUaoRYrEuLD9Je0W3Ju
         /zYRcpp3THnj/kbYYWeBgc7bEkkTuvoh2w3TkLfIF/6a51A+vLffXowecA0jP9Qtubbw
         LV4dA5PBVp5kzbGw1Or3pKK5l+Ms1L3vyKdFxAU7Z0k1hKh9QwnZqdyzjesXggAUk9aM
         xB6w==
X-Gm-Message-State: AFuF++l+DI8/HLs0laSxnHRpgCYG/25jpHMYpKl2u1+BWgaHpx4vgZZz
	OnyeBIkMljMjJ61s4XNB5LBOA4581XbKNAfQ9q9Hi9KMpbmjwARQkqz6D4vW5DHAceAmOgUhoW7
	J72qWhti/nkG5iwBQ+w5XPU7Akx1GI+p2gG7bBSCkMbTyyC1Ey+x7Z1Es2d8yIRGHXOrjAeH3Tr
	KL8imNykJ3+mAAs3ROW2KznjpPkTEad7G2zR7RmfFga8GLp47dhg==
X-Gm-Gg: AR+sD13BhdKBWvS5CjdELcY54ERshpP74n3JglVK7aQA+lpIKurj+LC+sKpw6PptrXD
	XcOimJkJUma/LM9d1yMYx1Mf7CpeXigMVOfR61CaAMo6lT7tF61Zp0JXGgZsWzHRK2OSZ28QnVl
	HpcayuVrUZQe+U9OQjNwedl1Gv63tdQ8yvEnWbhjEhRoCn+bqQqblVkPB1AarEHBsk5b5I3glHb
	FuaYEt5KAPt/axoeLjNT5W77Zy1savl51ElfIPqvnQu27IKxWY2Rt3mx4DiuRQJE7vaJNDFybcz
	v0t3FS/knVCL7Q16ikH8muM77QsjWN5uLddm/f7Qnv9RO3TDTdoqxo07YaXUVp+ydrj4UxVRs8x
	m29xUure7nNW7TlJOTJTeDdAsfwZ1t3APzQ==
X-Received: by 2002:a05:6402:530a:b0:6a1:f95b:8ced with SMTP id 4fb4d7f45d1cf-6a4032d181cmr9364003a12.4.1787230591922;
        Thu, 20 Aug 2026 05:56:31 -0700 (PDT)
X-Received: by 2002:a05:6402:530a:b0:6a1:f95b:8ced with SMTP id 4fb4d7f45d1cf-6a4032d181cmr9363913a12.4.1787230591020;
        Thu, 20 Aug 2026 05:56:31 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:30 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 09/14] ceph: switch MDS request plumbing to struct ceph_journal_info
Date: Thu, 20 Aug 2026 12:56:12 +0000
Message-Id: <af5c63a6919d246f207fc48387c101f5a49b742a.1787229471.git.amarkuze@redhat.com>
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

Replace ad-hoc journal_info setup in handle_reply() with
ceph_blog_enter_req(mdsc->fsc, &ji, req) / ceph_blog_exit(&ji) so nested
VFS callbacks inherit the BLOG context only when the owning fsc
matches.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 358 +++++++++++++++++++++++++------------------
 1 file changed, 206 insertions(+), 152 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2fdef73b28f4..aca4cdb4b3a0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -502,7 +502,9 @@ static int parse_reply_info_readdir(void **p, void *end,
 		ceph_decode_need(p, end, _name_len, bad);
 		_name = *p;
 		*p += _name_len;
-		doutc(cl, "parsed dir dname '%.*s'\n", _name_len, _name);
+		boutc_bounded(cl, "parsed dir dname '%.*s'\n",
+			      (_name_len, BLOG_STR(_name, _name_len)),
+			      (_name_len, (const char *)_name));
 
 		if (info->hash_order)
 			rde->raw_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
@@ -652,7 +654,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
-	doutc(cl, "got %u sets of delegated inodes\n", sets);
+	boutc(cl, "got %u sets of delegated inodes\n", sets);
 	while (sets--) {
 		u64 start, len;
 
@@ -686,7 +688,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 			int err = ceph_insert_deleg_ino(s, start++);
 
 			if (!err) {
-				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
+				boutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
 				pr_warn_client(cl,
 					"MDS delegated inode 0x%llx more than once.\n",
@@ -975,8 +977,19 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 	if (likely(!found))
 		return 0;
 
-	doutc(cl, "dentry %p:%pd conflict with old %p:%pd\n", dentry, dentry,
-	      found, found);
+	{
+		struct name_snapshot dname_snap, found_snap;
+
+		take_dentry_name_snapshot(&dname_snap, dentry);
+		take_dentry_name_snapshot(&found_snap, found);
+		boutc_formats(cl, "dentry %p:%s conflict with old %p:%s\n",
+			      "dentry %p:%pd conflict with old %p:%pd\n",
+			      (dentry, dname_snap.name.name, found,
+			       found_snap.name.name),
+			      (dentry, dentry, found, found));
+		release_dentry_name_snapshot(&dname_snap);
+		release_dentry_name_snapshot(&found_snap);
+	}
 
 	err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
 			  TASK_KILLABLE);
@@ -1078,7 +1091,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		struct ceph_mds_session **sa;
 		size_t ptr_size = sizeof(struct ceph_mds_session *);
 
-		doutc(cl, "realloc to %d\n", newmax);
+		boutc(cl, "realloc to %d\n", newmax);
 		sa = kcalloc(newmax, ptr_size, GFP_NOFS);
 		if (!sa)
 			goto fail_realloc;
@@ -1091,7 +1104,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		mdsc->max_sessions = newmax;
 	}
 
-	doutc(cl, "mds%d\n", mds);
+	boutc(cl, "mds%d\n", mds);
 	s->s_mdsc = mdsc;
 	s->s_mds = mds;
 	s->s_state = CEPH_MDS_SESSION_NEW;
@@ -1135,7 +1148,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 static void __unregister_session(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *s)
 {
-	doutc(mdsc->fsc->client, "mds%d %p\n", s->s_mds, s);
+	boutc(mdsc->fsc->client, "mds%d %p\n", s->s_mds, s);
 	BUG_ON(mdsc->sessions[s->s_mds] != s);
 	mdsc->sessions[s->s_mds] = NULL;
 	ceph_con_close(&s->s_con);
@@ -1278,7 +1291,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 			return;
 		}
 	}
-	doutc(cl, "%p tid %lld\n", req, req->r_tid);
+	boutc(cl, "%p tid %lld\n", req, req->r_tid);
 	ceph_mdsc_get_request(req);
 	insert_request(&mdsc->request_tree, req);
 
@@ -1303,7 +1316,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 static void __unregister_request(struct ceph_mds_client *mdsc,
 				 struct ceph_mds_request *req)
 {
-	doutc(mdsc->fsc->client, "%p tid %lld\n", req, req->r_tid);
+	boutc(mdsc->fsc->client, "%p tid %lld\n", req, req->r_tid);
 
 	/* Never leave an unregistered request on an unsafe list! */
 	list_del_init(&req->r_unsafe_item);
@@ -1401,7 +1414,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	if (req->r_resend_mds >= 0 &&
 	    (__have_session(mdsc, req->r_resend_mds) ||
 	     ceph_mdsmap_get_state(mdsc->mdsmap, req->r_resend_mds) > 0)) {
-		doutc(cl, "using resend_mds mds%d\n", req->r_resend_mds);
+		boutc(cl, "using resend_mds mds%d\n", req->r_resend_mds);
 		return req->r_resend_mds;
 	}
 
@@ -1418,7 +1431,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			rcu_read_lock();
 			inode = get_nonsnap_parent(req->r_dentry);
 			rcu_read_unlock();
-			doutc(cl, "using snapdir's parent %p %llx.%llx\n",
+			boutc(cl, "using snapdir's parent %p %llx.%llx\n",
 			      inode, ceph_vinop(inode));
 		}
 	} else if (req->r_dentry) {
@@ -1439,7 +1452,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			/* direct snapped/virtual snapdir requests
 			 * based on parent dir inode */
 			inode = get_nonsnap_parent(parent);
-			doutc(cl, "using nonsnap parent %p %llx.%llx\n",
+			boutc(cl, "using nonsnap parent %p %llx.%llx\n",
 			      inode, ceph_vinop(inode));
 		} else {
 			/* dentry target */
@@ -1459,7 +1472,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	if (!inode)
 		goto random;
 
-	doutc(cl, "%p %llx.%llx is_hash=%d (0x%x) mode %d\n", inode,
+	boutc(cl, "%p %llx.%llx is_hash=%d (0x%x) mode %d\n", inode,
 	      ceph_vinop(inode), (int)is_hash, hash, mode);
 	ci = ceph_inode(inode);
 
@@ -1476,7 +1489,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 				get_random_bytes(&r, 1);
 				r %= frag.ndist;
 				mds = frag.dist[r];
-				doutc(cl, "%p %llx.%llx frag %u mds%d (%d/%d)\n",
+				boutc(cl, "%p %llx.%llx frag %u mds%d (%d/%d)\n",
 				      inode, ceph_vinop(inode), frag.frag,
 				      mds, (int)r, frag.ndist);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
@@ -1491,7 +1504,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			if (frag.mds >= 0) {
 				/* choose auth mds */
 				mds = frag.mds;
-				doutc(cl, "%p %llx.%llx frag %u mds%d (auth)\n",
+				boutc(cl, "%p %llx.%llx frag %u mds%d (auth)\n",
 				      inode, ceph_vinop(inode), frag.frag, mds);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE) {
@@ -1516,7 +1529,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		goto random;
 	}
 	mds = cap->session->s_mds;
-	doutc(cl, "%p %llx.%llx mds%d (%scap %p)\n", inode,
+	boutc(cl, "%p %llx.%llx mds%d (%scap %p)\n", inode,
 	      ceph_vinop(inode), mds,
 	      cap == ci->i_auth_cap ? "auth " : "", cap);
 	spin_unlock(&ci->i_ceph_lock);
@@ -1529,7 +1542,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		*random = true;
 
 	mds = ceph_mdsmap_get_random_mds(mdsc->mdsmap);
-	doutc(cl, "chose random mds%d\n", mds);
+	boutc(cl, "chose random mds%d\n", mds);
 	return mds;
 }
 
@@ -1769,7 +1782,7 @@ static int __open_session(struct ceph_mds_client *mdsc,
 
 	/* wait for mds to go active? */
 	mstate = ceph_mdsmap_get_state(mdsc->mdsmap, mds);
-	doutc(mdsc->fsc->client, "open_session to mds%d (%s)\n", mds,
+	boutc(mdsc->fsc->client, "open_session to mds%d (%s)\n", mds,
 	      ceph_mds_state_name(mstate));
 	session->s_state = CEPH_MDS_SESSION_OPENING;
 	session->s_renew_requested = jiffies;
@@ -1816,7 +1829,7 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
 	struct ceph_mds_session *session;
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "to mds%d\n", target);
+	boutc(cl, "to mds%d\n", target);
 
 	mutex_lock(&mdsc->mutex);
 	session = __open_export_target_session(mdsc, target);
@@ -1837,7 +1850,7 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
 		return;
 
 	mi = &mdsc->mdsmap->m_info[mds];
-	doutc(cl, "for mds%d (%d targets)\n", session->s_mds,
+	boutc(cl, "for mds%d (%d targets)\n", session->s_mds,
 	      mi->num_export_targets);
 
 	for (i = 0; i < mi->num_export_targets; i++) {
@@ -1860,7 +1873,7 @@ static int detach_cap_releases(struct ceph_mds_session *session,
 
 	list_splice_init(&session->s_cap_releases, target);
 	session->s_num_cap_releases = 0;
-	doutc(cl, "mds%d\n", session->s_mds);
+	boutc(cl, "mds%d\n", session->s_mds);
 
 	return num_cap_releases;
 }
@@ -1884,7 +1897,7 @@ static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req;
 	struct rb_node *p;
 
-	doutc(cl, "mds%d\n", session->s_mds);
+	boutc(cl, "mds%d\n", session->s_mds);
 	mutex_lock(&mdsc->mutex);
 	while (!list_empty(&session->s_unsafe)) {
 		req = list_first_entry(&session->s_unsafe,
@@ -1926,7 +1939,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 	struct ceph_cap *old_cap = NULL;
 	int ret;
 
-	doutc(cl, "%p mds%d\n", session, session->s_mds);
+	boutc(cl, "%p mds%d\n", session, session->s_mds);
 	spin_lock(&session->s_cap_lock);
 	p = session->s_caps.next;
 	while (p != &session->s_caps) {
@@ -1957,7 +1970,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 		spin_lock(&session->s_cap_lock);
 		p = p->next;
 		if (ceph_cap_is_removed(cap)) {
-			doutc(cl, "finishing cap %p removal\n", cap);
+			boutc(cl, "finishing cap %p removal\n", cap);
 			BUG_ON(cap->session != session);
 			cap->session = NULL;
 			list_del_init(&cap->session_caps);
@@ -1994,7 +2007,7 @@ static int remove_session_caps_cb(struct inode *inode, int mds, void *arg)
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ci, mds);
 	if (cap) {
-		doutc(cl, " removing cap %p, ci is %p, inode is %p\n",
+		boutc(cl, " removing cap %p, ci is %p, inode is %p\n",
 		      cap, ci, &ci->netfs.inode);
 
 		iputs = ceph_purge_inode_cap(inode, cap, &invalidate);
@@ -2019,7 +2032,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
 	struct super_block *sb = fsc->sb;
 	LIST_HEAD(dispose);
 
-	doutc(fsc->client, "on %p\n", session);
+	boutc(fsc->client, "on %p\n", session);
 	ceph_iterate_session_caps(session, remove_session_caps_cb, fsc);
 
 	wake_up_all(&fsc->mdsc->cap_flushing_wq);
@@ -2102,7 +2115,7 @@ static void wake_up_session_caps(struct ceph_mds_session *session, int ev)
 {
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
 
-	doutc(cl, "session %p mds%d\n", session, session->s_mds);
+	boutc(cl, "session %p mds%d\n", session, session->s_mds);
 	ceph_iterate_session_caps(session, wake_up_session_cb,
 				  (void *)(unsigned long)ev);
 }
@@ -2129,12 +2142,12 @@ static int send_renew_caps(struct ceph_mds_client *mdsc,
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
@@ -2150,7 +2163,7 @@ static int send_flushmsg_ack(struct ceph_mds_client *mdsc,
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 
-	doutc(cl, "to mds%d (%s)s seq %lld\n", session->s_mds,
+	boutc(cl, "to mds%d (%s)s seq %lld\n", session->s_mds,
 	      ceph_session_state_name(session->s_state), seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_FLUSHMSG_ACK, seq);
 	if (!msg)
@@ -2188,7 +2201,7 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
 				       session->s_mds);
 		}
 	}
-	doutc(cl, "mds%d ttl now %lu, was %s, now %s\n", session->s_mds,
+	boutc(cl, "mds%d ttl now %lu, was %s, now %s\n", session->s_mds,
 	      session->s_cap_ttl, was_stale ? "stale" : "fresh",
 	      time_before(jiffies, session->s_cap_ttl) ? "stale" : "fresh");
 	spin_unlock(&session->s_cap_lock);
@@ -2205,7 +2218,7 @@ static int request_close_session(struct ceph_mds_session *session)
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	struct ceph_msg *msg;
 
-	doutc(cl, "mds%d state %s seq %lld\n", session->s_mds,
+	boutc(cl, "mds%d state %s seq %lld\n", session->s_mds,
 	      ceph_session_state_name(session->s_state), session->s_seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_REQUEST_CLOSE,
 				      session->s_seq);
@@ -2283,7 +2296,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 	wanted = __ceph_caps_file_wanted(ci);
 	oissued = __ceph_caps_issued_other(ci, cap);
 
-	doutc(cl, "%p %llx.%llx cap %p mine %s oissued %s used %s wanted %s\n",
+	boutc(cl, "%p %llx.%llx cap %p mine %s oissued %s used %s wanted %s\n",
 	      inode, ceph_vinop(inode), cap, ceph_cap_string(mine),
 	      ceph_cap_string(oissued), ceph_cap_string(used),
 	      ceph_cap_string(wanted));
@@ -2326,7 +2339,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 			count = icount_read_once(inode);
 			if (count == 1)
 				(*remaining)--;
-			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
+			boutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
 			      inode, ceph_vinop(inode), cap, count);
 		} else {
 			dput(dentry);
@@ -2349,13 +2362,13 @@ int ceph_trim_caps(struct ceph_mds_client *mdsc,
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
@@ -2376,7 +2389,7 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 			list_first_entry(&mdsc->cap_flush_list,
 					 struct ceph_cap_flush, g_list);
 		if (cf->tid <= want_flush_tid) {
-			doutc(cl, "still flushing tid %llu <= %llu\n",
+			boutc(cl, "still flushing tid %llu <= %llu\n",
 			      cf->tid, want_flush_tid);
 			ret = 0;
 		}
@@ -2476,7 +2489,7 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 	int i = 0;
 	long ret;
 
-	doutc(cl, "want %llu\n", want_flush_tid);
+	boutc(cl, "want %llu\n", want_flush_tid);
 
 	do {
 		/* 60 * HZ fits in a long on all supported architectures. */
@@ -2493,7 +2506,7 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 		}
 	} while (ret == 0);
 
-	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
+	boutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
 
 /*
@@ -2559,7 +2572,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 			msg->front.iov_len += sizeof(*cap_barrier);
 
 			msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-			doutc(cl, "mds%d %p\n", session->s_mds, msg);
+			boutc(cl, "mds%d %p\n", session->s_mds, msg);
 			ceph_con_send(&session->s_con, msg);
 			msg = NULL;
 		}
@@ -2579,7 +2592,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 		msg->front.iov_len += sizeof(*cap_barrier);
 
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-		doutc(cl, "mds%d %p\n", session->s_mds, msg);
+		boutc(cl, "mds%d %p\n", session->s_mds, msg);
 		ceph_con_send(&session->s_con, msg);
 	}
 	return;
@@ -2615,10 +2628,10 @@ void ceph_flush_session_cap_releases(struct ceph_mds_client *mdsc,
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
 
@@ -2639,9 +2652,14 @@ static void ceph_cap_reclaim_work(struct work_struct *work)
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
@@ -2650,11 +2668,10 @@ void ceph_queue_cap_reclaim_work(struct ceph_mds_client *mdsc)
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
@@ -2675,11 +2692,10 @@ void ceph_queue_cap_unlink_work(struct ceph_mds_client *mdsc)
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
@@ -2687,8 +2703,11 @@ static void ceph_cap_unlink_work(struct work_struct *work)
 	struct ceph_mds_client *mdsc =
 		container_of(work, struct ceph_mds_client, cap_unlink_work);
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_journal_info __ji;
 
-	doutc(cl, "begin\n");
+	ceph_blog_enter(mdsc->fsc, &__ji);
+
+	boutc(cl, "begin\n");
 	spin_lock(&mdsc->cap_delay_lock);
 	while (!list_empty(&mdsc->cap_unlink_delay_list)) {
 		struct ceph_inode_info *ci;
@@ -2702,7 +2721,7 @@ static void ceph_cap_unlink_work(struct work_struct *work)
 		inode = igrab(&ci->netfs.inode);
 		if (inode) {
 			spin_unlock(&mdsc->cap_delay_lock);
-			doutc(cl, "on %p %llx.%llx\n", inode,
+			boutc(cl, "on %p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			ceph_check_caps(ci, CHECK_CAPS_FLUSH);
 			iput(inode);
@@ -2710,7 +2729,8 @@ static void ceph_cap_unlink_work(struct work_struct *work)
 		}
 	}
 	spin_unlock(&mdsc->cap_delay_lock);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
+	ceph_blog_exit(&__ji);
 }
 
 /*
@@ -2925,7 +2945,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 		spin_lock(&cur->d_lock);
 		inode = d_inode(cur);
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
-			doutc(cl, "path+%d: %p SNAPDIR\n", pos, cur);
+			boutc(cl, "path+%d: %p SNAPDIR\n", pos, cur);
 			spin_unlock(&cur->d_lock);
 			parent = dget_parent(cur);
 		} else if (for_wire && inode && dentry != cur &&
@@ -3024,8 +3044,11 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
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
 
@@ -3102,12 +3125,15 @@ static int set_request_path_attr(struct ceph_mds_client *mdsc, struct inode *rin
 
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
@@ -3115,7 +3141,10 @@ static int set_request_path_attr(struct ceph_mds_client *mdsc, struct inode *rin
 		path_info->pathlen = rpath ? strlen(rpath) : 0;
 		path_info->freepath = false;
 
-		doutc(cl, " path %.*s\n", path_info->pathlen, rpath);
+		boutc_bounded(cl, " path %.*s\n",
+			      (path_info->pathlen,
+			       BLOG_STR(rpath, path_info->pathlen)),
+			      (path_info->pathlen, (const char *)rpath));
 	}
 
 	return r;
@@ -3534,7 +3563,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		else
 			req->r_sent_on_mseq = -1;
 	}
-	doutc(cl, "%p tid %lld %s (attempt %d)\n", req, req->r_tid,
+	boutc(cl, "%p tid %lld %s (attempt %d)\n", req, req->r_tid,
 	      ceph_mds_op_name(req->r_op), req->r_attempts);
 
 	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
@@ -3603,7 +3632,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		nhead->ext_num_retry = cpu_to_le32(req->r_attempts - 1);
 	}
 
-	doutc(cl, " r_parent = %p\n", req->r_parent);
+	boutc(cl, " r_parent = %p\n", req->r_parent);
 	return 0;
 }
 
@@ -3709,7 +3738,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	}
 	req->r_session = ceph_get_mds_session(session);
 
-	doutc(cl, "mds%d session %p state %s\n", mds, session,
+	boutc(cl, "mds%d session %p state %s\n", mds, session,
 	      ceph_session_state_name(session->s_state));
 
 	/*
@@ -3806,7 +3835,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		cap = ci->i_auth_cap;
 		if (test_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
 		    mds != cap->mds) {
-			doutc(cl, "session changed for auth cap %d -> %d\n",
+			boutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
 			/* Remove the auth cap from old session */
@@ -3834,7 +3863,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	ceph_put_mds_session(session);
 finish:
 	if (err) {
-		doutc(cl, "early error %d\n", err);
+		boutc(cl, "early error %d\n", err);
 		req->r_err = err;
 		complete_request(mdsc, req);
 		__unregister_request(mdsc, req);
@@ -3875,7 +3904,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	struct ceph_mds_request *req;
 	struct rb_node *p = rb_first(&mdsc->request_tree);
 
-	doutc(cl, "kick_requests mds%d\n", mds);
+	boutc(cl, "kick_requests mds%d\n", mds);
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
@@ -3934,7 +3963,7 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	if (req->r_inode) {
 		err = ceph_wait_on_async_create(req->r_inode);
 		if (err) {
-			doutc(cl, "wait for async create returned: %d\n", err);
+			boutc(cl, "wait for async create returned: %d\n", err);
 			return err;
 		}
 	}
@@ -3965,7 +3994,7 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 	int err;
 
 	/* wait */
-	doutc(cl, "do_request waiting\n");
+	boutc(cl, "do_request waiting\n");
 	if (wait_func) {
 		err = wait_func(mdsc, req);
 	} else {
@@ -3979,14 +4008,14 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
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
@@ -4020,13 +4049,13 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
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
 
@@ -4040,7 +4069,7 @@ void ceph_invalidate_dir_request(struct ceph_mds_request *req)
 	struct inode *old_dir = req->r_old_dentry_dir;
 	struct ceph_client *cl = req->r_mdsc->fsc->client;
 
-	doutc(cl, "invalidate_dir_request %p %p (complete, lease(s))\n",
+	boutc(cl, "invalidate_dir_request %p %p (complete, lease(s))\n",
 	      dir, old_dir);
 
 	ceph_dir_clear_complete(dir);
@@ -4072,10 +4101,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
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
 
@@ -4084,11 +4117,12 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
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
@@ -4132,7 +4166,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			 * response.  And even if it did, there is nothing
 			 * useful we could do with a revised return value.
 			 */
-			doutc(cl, "got safe reply %llu, mds%d\n", tid, mds);
+			boutc(cl, "got safe reply %llu, mds%d\n", tid, mds);
 
 			mutex_unlock(&mdsc->mutex);
 			goto out;
@@ -4149,7 +4183,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	 */
 	mutex_unlock(&mdsc->mutex);
 
-	doutc(cl, "tid %lld result %d\n", tid, result);
+	boutc(cl, "tid %lld result %d\n", tid, result);
 	if (test_bit(CEPHFS_FEATURE_REPLY_ENCODING, &session->s_features))
 		err = parse_reply_info(session, msg, req, (u64)-1);
 	else
@@ -4218,21 +4252,20 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
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
 
@@ -4263,7 +4296,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			set_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
 		}
 	} else {
-		doutc(cl, "reply arrived after request %lld was aborted\n", tid);
+		boutc(cl, "reply arrived after request %lld was aborted\n", tid);
 	}
 	mutex_unlock(&mdsc->mutex);
 
@@ -4280,6 +4313,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	/* Defer closing the sessions after s_mutex lock being released */
 	if (close_sessions)
 		ceph_mdsc_close_sessions(mdsc);
+	ceph_blog_exit(&__ji);
 	return;
 }
 
@@ -4301,6 +4335,9 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *end = p + msg->front.iov_len;
 	bool aborted = false;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(mdsc->fsc, &__ji);
 
 	ceph_decode_need(&p, end, 2*sizeof(u32), bad);
 	next_mds = ceph_decode_32(&p);
@@ -4310,12 +4347,13 @@ static void handle_forward(struct ceph_mds_client *mdsc,
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
@@ -4335,7 +4373,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 					   tid);
 	} else {
 		/* resend. forward race not possible; mds would drop */
-		doutc(cl, "forward tid %llu to mds%d (we resend)\n", tid, next_mds);
+		boutc(cl, "forward tid %llu to mds%d (we resend)\n", tid, next_mds);
 		BUG_ON(req->r_err);
 		BUG_ON(test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags));
 		req->r_attempts = 0;
@@ -4350,11 +4388,13 @@ static void handle_forward(struct ceph_mds_client *mdsc,
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
@@ -4404,7 +4444,9 @@ static void handle_session(struct ceph_mds_session *session,
 	int wake = 0;
 	bool blocklisted = false;
 	u32 i;
+	struct ceph_journal_info __ji;
 
+	ceph_blog_enter(mdsc->fsc, &__ji);
 
 	/* decode */
 	ceph_decode_need(&p, end, sizeof(*h), bad);
@@ -4451,7 +4493,7 @@ static void handle_session(struct ceph_mds_session *session,
 
 	if (msg_version >= 6) {
 		ceph_decode_32_safe(&p, end, cap_auths_num, bad);
-		doutc(cl, "cap_auths_num %d\n", cap_auths_num);
+		boutc(cl, "cap_auths_num %d\n", cap_auths_num);
 
 		if (cap_auths_num && op != CEPH_SESSION_OPEN) {
 			WARN_ON_ONCE(op != CEPH_SESSION_OPEN);
@@ -4462,6 +4504,7 @@ static void handle_session(struct ceph_mds_session *session,
 					 cap_auths_num);
 		if (!cap_auths) {
 			pr_err_client(cl, "No memory for cap_auths\n");
+			ceph_blog_exit(&__ji);
 			return;
 		}
 
@@ -4525,7 +4568,7 @@ static void handle_session(struct ceph_mds_session *session,
 			ceph_decode_8_safe(&p, end, cap_auths[i].match.root_squash, bad);
 			ceph_decode_8_safe(&p, end, cap_auths[i].readable, bad);
 			ceph_decode_8_safe(&p, end, cap_auths[i].writeable, bad);
-			doutc(cl, "uid %lld, num_gids %u, path %s, fs_name %s, root_squash %d, readable %d, writeable %d\n",
+			boutc(cl, "uid %lld, num_gids %u, path %s, fs_name %s, root_squash %d, readable %d, writeable %d\n",
 			      cap_auths[i].match.uid, cap_auths[i].match.num_gids,
 			      cap_auths[i].match.path, cap_auths[i].match.fs_name,
 			      cap_auths[i].match.root_squash,
@@ -4562,7 +4605,7 @@ static void handle_session(struct ceph_mds_session *session,
 
 	mutex_lock(&session->s_mutex);
 
-	doutc(cl, "mds%d %s %p state %s seq %llu\n", mds,
+	boutc(cl, "mds%d %s %p state %s seq %llu\n", mds,
 	      ceph_session_op_name(op), session,
 	      ceph_session_state_name(session->s_state), seq);
 
@@ -4645,7 +4688,7 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_FORCE_RO:
-		doutc(cl, "force_session_readonly %p\n", session);
+		boutc(cl, "force_session_readonly %p\n", session);
 		spin_lock(&session->s_cap_lock);
 		session->s_readonly = true;
 		spin_unlock(&session->s_cap_lock);
@@ -4684,6 +4727,7 @@ static void handle_session(struct ceph_mds_session *session,
 	}
 	if (op == CEPH_SESSION_CLOSE)
 		ceph_put_mds_session(session);
+	ceph_blog_exit(&__ji);
 	return;
 
 bad:
@@ -4697,6 +4741,7 @@ static void handle_session(struct ceph_mds_session *session,
 		kfree(cap_auths[i].match.fs_name);
 	}
 	kfree(cap_auths);
+	ceph_blog_exit(&__ji);
 	return;
 }
 
@@ -4707,7 +4752,7 @@ void ceph_mdsc_release_dir_caps(struct ceph_mds_request *req)
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		doutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		boutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs(ceph_inode(req->r_parent), dcaps);
 	}
 }
@@ -4719,7 +4764,7 @@ void ceph_mdsc_release_dir_caps_async(struct ceph_mds_request *req)
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		doutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		boutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs_async(ceph_inode(req->r_parent), dcaps);
 	}
 }
@@ -4733,7 +4778,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req, *nreq;
 	struct rb_node *p;
 
-	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
+	boutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
 	mutex_lock(&mdsc->mutex);
 	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item)
@@ -4911,7 +4956,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		err = 0;
 		goto out_err;
 	}
-	doutc(cl, " adding %p ino %llx.%llx cap %p %lld %s\n", inode,
+	boutc(cl, " adding %p ino %llx.%llx cap %p %lld %s\n", inode,
 	      ceph_vinop(inode), cap, cap->cap_id,
 	      ceph_cap_string(cap->issued));
 
@@ -5115,7 +5160,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			ceph_pagelist_encode_32(pagelist, sizeof(sr_rec));
 		}
 
-		doutc(cl, " adding snap realm %llx seq %lld parent %llx\n",
+		boutc(cl, " adding snap realm %llx seq %lld parent %llx\n",
 		      realm->ino, realm->seq, realm->parent_ino);
 		sr_rec.ino = cpu_to_le64(realm->ino);
 		sr_rec.seq = cpu_to_le64(realm->seq);
@@ -5198,7 +5243,7 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
-	doutc(cl, "session %p state %s\n", session,
+	boutc(cl, "session %p state %s\n", session,
 	      ceph_session_state_name(session->s_state));
 
 	atomic_inc(&session->s_cap_gen);
@@ -5850,7 +5895,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	unsigned long targets[DIV_ROUND_UP(CEPH_MAX_MDS, sizeof(unsigned long))] = {0};
 	struct ceph_client *cl = mdsc->fsc->client;
 
-	doutc(cl, "new %u old %u\n", newmap->m_epoch, oldmap->m_epoch);
+	boutc(cl, "new %u old %u\n", newmap->m_epoch, oldmap->m_epoch);
 
 	if (newmap->m_info) {
 		for (i = 0; i < newmap->possible_max_rank; i++) {
@@ -5866,7 +5911,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
-		doutc(cl, "mds%d state %s%s -> %s%s (session %s)\n",
+		boutc(cl, "mds%d state %s%s -> %s%s (session %s)\n",
 		      i, ceph_mds_state_name(oldstate),
 		      ceph_mdsmap_is_laggy(oldmap, i) ? " (laggy)" : "",
 		      ceph_mds_state_name(newstate),
@@ -5987,7 +6032,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				continue;
 			}
 		}
-		doutc(cl, "send reconnect to export target mds.%d\n", i);
+		boutc(cl, "send reconnect to export target mds.%d\n", i);
 		mutex_unlock(&mdsc->mutex);
 		err = send_mds_reconnect(mdsc, s);
 		if (err)
@@ -6007,7 +6052,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		if (s->s_state == CEPH_MDS_SESSION_OPEN ||
 		    s->s_state == CEPH_MDS_SESSION_HUNG ||
 		    s->s_state == CEPH_MDS_SESSION_CLOSING) {
-			doutc(cl, " connecting to export targets of laggy mds%d\n", i);
+			boutc(cl, " connecting to export targets of laggy mds%d\n", i);
 			__open_export_target_sessions(mdsc, s);
 		}
 	}
@@ -6046,7 +6091,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 	struct qstr dname;
 	int release = 0;
 
-	doutc(cl, "from mds%d\n", mds);
+	boutc(cl, "from mds%d\n", mds);
 
 	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
 		return;
@@ -6064,19 +6109,22 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 
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
@@ -6150,7 +6198,7 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 	struct inode *dir;
 	int len = sizeof(*lease) + sizeof(u32) + NAME_MAX;
 
-	doutc(cl, "identry %p %s to mds%d\n", dentry, ceph_lease_op_name(action),
+	boutc(cl, "identry %p %s to mds%d\n", dentry, ceph_lease_op_name(action),
 	      session->s_mds);
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_LEASE, len, GFP_NOFS, false);
@@ -6237,7 +6285,7 @@ void inc_session_sequence(struct ceph_mds_session *s)
 	if (s->s_state == CEPH_MDS_SESSION_CLOSING) {
 		int ret;
 
-		doutc(cl, "resending session close request for mds%d\n", s->s_mds);
+		boutc(cl, "resending session close request for mds%d\n", s->s_mds);
 		ret = request_close_session(s);
 		if (ret < 0)
 			pr_err_client(cl, "unable to close session to mds%d: %d\n",
@@ -6265,15 +6313,20 @@ static void delayed_work(struct work_struct *work)
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
@@ -6319,6 +6372,7 @@ static void delayed_work(struct work_struct *work)
 	maybe_recover_session(mdsc);
 
 	schedule_delayed(mdsc, delay);
+	ceph_blog_exit(&__ji);
 }
 
 int ceph_mdsc_init(struct ceph_fs_client *fsc)
@@ -6426,20 +6480,20 @@ static void wait_requests(struct ceph_mds_client *mdsc)
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
@@ -6454,7 +6508,7 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 		return;
 
 	mutex_lock(&s->s_mutex);
-	doutc(cl, "request mdlog flush to mds%d (%s)s seq %lld\n",
+	boutc(cl, "request mdlog flush to mds%d (%s)s seq %lld\n",
 	      s->s_mds, ceph_session_state_name(s->s_state), s->s_seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_REQUEST_FLUSH_MDLOG,
 				      s->s_seq);
@@ -6529,7 +6583,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 			bool free_tpath = false;
 			int m, n;
 
-			doutc(cl, "server path %s, tpath %s, match.path %s\n",
+			boutc(cl, "server path %s, tpath %s, match.path %s\n",
 			      spath, tpath, auth->match.path);
 			if (spath && (m = strlen(spath)) != 1) {
 				/* mount path + '/' + tpath + an extra space */
@@ -6553,7 +6607,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 				_tpath[tlen - 1] = '\0';
 				tlen -= 1;
 			}
-			doutc(cl, "_tpath %s\n", _tpath);
+			boutc(cl, "_tpath %s\n", _tpath);
 
 			/*
 			 * In case first == _tpath && tlen == len:
@@ -6583,7 +6637,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 		}
 	}
 
-	doutc(cl, "matched\n");
+	boutc(cl, "matched\n");
 	return 1;
 }
 
@@ -6597,7 +6651,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	bool root_squash_perms = true;
 	int i, err;
 
-	doutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
+	boutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
 	      tpath, mask, caller_uid, caller_gid);
 
 	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
@@ -6623,23 +6677,23 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 
 	put_cred(cred);
 
-	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
+	boutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
 	      rw_perms_s);
 	if (root_squash_perms && rw_perms_s == NULL) {
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
 	return -EACCES;
 }
 
@@ -6649,7 +6703,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
  */
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
-	doutc(mdsc->fsc->client, "begin\n");
+	boutc(mdsc->fsc->client, "begin\n");
 	mdsc->stopping = CEPH_MDSC_STOPPING_BEGIN;
 
 	ceph_mdsc_iterate_sessions(mdsc, send_flush_mdlog, true);
@@ -6664,7 +6718,7 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 	ceph_msgr_flush();
 
 	ceph_cleanup_quotarealms_inodes(mdsc);
-	doutc(mdsc->fsc->client, "done\n");
+	boutc(mdsc->fsc->client, "done\n");
 }
 
 /*
@@ -6679,7 +6733,7 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	struct rb_node *n;
 
 	mutex_lock(&mdsc->mutex);
-	doutc(cl, "want %lld\n", want_tid);
+	boutc(cl, "want %lld\n", want_tid);
 restart:
 	req = __get_oldest_req(mdsc);
 	while (req && req->r_tid <= want_tid) {
@@ -6713,7 +6767,7 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 			} else {
 				ceph_put_mds_session(s);
 			}
-			doutc(cl, "wait on %llu (want %llu)\n",
+			boutc(cl, "wait on %llu (want %llu)\n",
 			      req->r_tid, want_tid);
 			wait_for_completion(&req->r_safe_completion);
 
@@ -6732,7 +6786,7 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	}
 	mutex_unlock(&mdsc->mutex);
 	ceph_put_mds_session(last_session);
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
@@ -6743,7 +6797,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 	if (READ_ONCE(mdsc->fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN)
 		return;
 
-	doutc(cl, "sync\n");
+	boutc(cl, "sync\n");
 	mutex_lock(&mdsc->mutex);
 	want_tid = mdsc->last_tid;
 	mutex_unlock(&mdsc->mutex);
@@ -6760,7 +6814,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
 
-	doutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
+	boutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
 
 	flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
 	wait_caps_flush(mdsc, want_flush);
@@ -6787,7 +6841,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	int i;
 	int skipped = 0;
 
-	doutc(cl, "begin\n");
+	boutc(cl, "begin\n");
 
 	/* close sessions */
 	mutex_lock(&mdsc->mutex);
@@ -6805,7 +6859,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	}
 	mutex_unlock(&mdsc->mutex);
 
-	doutc(cl, "waiting for sessions to close\n");
+	boutc(cl, "waiting for sessions to close\n");
 	wait_event_timeout(mdsc->session_close_wq,
 			   done_closing_sessions(mdsc, skipped),
 			   ceph_timeout_jiffies(opts->mount_timeout));
@@ -6834,7 +6888,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	cancel_work_sync(&mdsc->cap_unlink_work);
 	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
 
-	doutc(cl, "done\n");
+	boutc(cl, "done\n");
 }
 
 void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
@@ -6842,7 +6896,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 	struct ceph_mds_session *session;
 	int mds;
 
-	doutc(mdsc->fsc->client, "force umount\n");
+	boutc(mdsc->fsc->client, "force umount\n");
 
 	mutex_lock(&mdsc->mutex);
 	for (mds = 0; mds < mdsc->max_sessions; mds++) {
@@ -6873,7 +6927,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 
 static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 {
-	doutc(mdsc->fsc->client, "stop\n");
+	boutc(mdsc->fsc->client, "stop\n");
 	/*
 	 * Make sure the delayed work stopped before releasing
 	 * the resources.
@@ -6906,7 +6960,7 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 {
 	struct ceph_mds_client *mdsc = fsc->mdsc;
-	doutc(fsc->client, "%p\n", mdsc);
+	boutc(fsc->client, "%p\n", mdsc);
 
 	if (!mdsc)
 		return;
@@ -6939,7 +6993,7 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 
 	fsc->mdsc = NULL;
 	kfree(mdsc);
-	doutc(fsc->client, "%p done\n", mdsc);
+	boutc(fsc->client, "%p done\n", mdsc);
 }
 
 void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
@@ -6957,7 +7011,7 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	ceph_decode_need(&p, end, sizeof(u32), bad);
 	epoch = ceph_decode_32(&p);
 
-	doutc(cl, "epoch %u\n", epoch);
+	boutc(cl, "epoch %u\n", epoch);
 
 	/* struct_v, struct_cv, map_len, epoch, legacy_client_fscid */
 	ceph_decode_skip_n(&p, end, 2 + sizeof(u32) * 3, bad);
@@ -7033,12 +7087,12 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
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

