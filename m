Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792649801;
	b=R8Db2MYAwAntjrxHkTSkKqhKhU2ZXuKrQc7j8Lcy9lA9cJUbFILS31F/ITghhbvIBo5I
	 v88J/bkF3CmBgl/PxlzZW2/XNfxZU44lwG6e3Ypx77X5d960gIo9GLK0fELS9t42bf0ey
	 x2l4FFqdnc3zvfUv/dvay0EWcKobqVCC/tDr2B5ra1jcp07TbQbfkWmHHte7D251o/RS2
	 pMz64G07jyyDNpWBkydYUfgmkICDagkdeVDpV8DR3HLWAOVNvXFr8dvutDEx8ky75sp5c
	 CatWEVUZzrdxwvla2SeBKUCrDwsfT+aLn5b4Yd+DjyzalD7LiTqXNKUxez4W9NZKJLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792649801;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XzPvf2iKkhaJifauJB0mvXhkikmUxEgqKqnn9ElV/ss=;
	b=Fuxk8bUyBDzfett6+6MgQkZzw8TXpLxsJMksaP0ZVNQlstVqtVsmkpJ9Bn2H9PhcE6ML
	 5Fkyr3k9bv/Bc1OlDNtTR7ij5LZGbVBHVqnhBruEq5s7K9a4whKj6Q5Yca/HDpi5z6DnK
	 Mq+jsU4oE6+X2fb5NrO/ds8nY2bQ9AHvqbt9QmsXPxf0vhzTMbtHO0VuAwgH7lpiZp4v3
	 c7UXnG0/Uu7xwqrMg4s9Wxw2/RjqMe3OTtknueJdLR2pijDzE7SiJWTVXFN8Hwh+nSbEh
	 y/UkC/bNXP9WJ0MG6nx6LL440aSQDLB1dYs7x83O9R4Af5L+OwAu3TEWrMuDfpGVQuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N6gnSPcu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="VW/N9Vxp";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE96606A32A
	for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 06:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE96606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N6gnSPcu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VW/N9Vxp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792649799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzPvf2iKkhaJifauJB0mvXhkikmUxEgqKqnn9ElV/ss=;
	b=N6gnSPculM2QKalriDwDcqWp5+4wcYWrjB8iJJ+tR8NikZINPGfWaKxpJAzSusKu3YrSaS
	jrbsnOBu9sB+wvlTGWscYFoOjvrlSYWznp2ShjFuZ0io01iCJ3x2toGbR3CNB4k6kzmWUH
	9DM4t1HWvcTXTGnwA2bLRUN23YUYmeU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-xqKzcvbTONeCwXYedg8y8Q-1; Thu, 22 Oct 2026 02:16:37 -0400
X-MC-Unique: xqKzcvbTONeCwXYedg8y8Q-1
X-Mimecast-MFC-AGG-ID: xqKzcvbTONeCwXYedg8y8Q_1792649796
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6aff6a8ee69so1326363a12.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2026 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792649796; x=1793254596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzPvf2iKkhaJifauJB0mvXhkikmUxEgqKqnn9ElV/ss=;
        b=VW/N9Vxp2raQAHQNSwRoFrBhwa285z3SMGCv3BZSS/TDut4Gp0xfvk3YaWtI0d2AOC
         r8fppI1Zx4EBpTUwAJgT0HEFboRfDT5BGRJgKxJYPtiJI+AC8oNep7DVQAv33dA2OtPE
         HhpgcbMJ5nx3RXLIWEuBa045qZtZveQ/aQ/H0fGH24DCbfapHthUvhKCE1BvXz6NFuU3
         4LRf6TRMpgFIRZDQGxdHLS4IVvlQgoiXlhH7Ua9gF7jnBDXPzNaZ3JpaQ9I585a2UGLx
         NE6V7Hx+Wgu6uQFZEi5yF3WThPuU36mMA7L6IzYCAmQCT4yYlwhgk1ebyre0xLGJVSbn
         yywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792649796; x=1793254596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XzPvf2iKkhaJifauJB0mvXhkikmUxEgqKqnn9ElV/ss=;
        b=SnompQOQEWCiL3iVXLbBdGq5Ihs9p1Wvby/dh3qzQqXbUc1Vblo7C8kZg8kPTxndL1
         OyI3ybr9oHOkRoU3g53TvTUvXYEzEc6Bf/KkR4gecVzVQvkVMp8rI7agczBRNTfylGtC
         snjlIBfl1ZJtMpc/cjlK2VqnN6OkkTA7XDa3mWVnClhBjmmenrHzZQImDkbFTpsZMTgS
         W32zTkDgqBsxieQZYfARXNJ6YfX+z/gzvMFGYglqOHkVJOEjFgCEkz5ZQUevtsTWGo4Z
         nJFJpAjn1X+2rLIGW78QzCShimJumKMqZE28HJXIYYHLaU0QGCJ8CcLduunjkYZHRbO/
         8ELg==
X-Gm-Message-State: AFq9FYJgJuHLFryzZ+2mx7ONGQMyQMiCv7IEVCELnp0loZskqWsJQye5
	YQDXF1o9kVkwGPZpcu/yWZMP6fEKekb9bZansRDcYuDgzNTiLlOGo+f+wQujFsx3FvpClrxAB96
	g0ZFkLHNbHzxFXkm8PkNAaatk62a7/YfJzY0qRSLCKORY5oCMt98Rjf2HtofmIJw61JfZhBCj4X
	87a904cuPqaLv/IlguWEbfQk+fPf7AaOg46SW3cPljlby3W74=
X-Gm-Gg: AYBFou37BiHousotuy2Wej43UNOtECoXxDu0xV5U8lqqlxoZ2Oo3XjXNt9WtPHEQH0S
	AxcNiZZJOY+owK/Mb2LcxFHZOEUWT34FUdOgmeE4FG3E/cZfgNiunq5CcZVCnPrbBWKwG/Vxi4T
	4dHBPzQdaDMKzbK0d1aXbKcJRkYY2Sk68UnVaI4NgdZLDF1QX/j3UStes1F+dFSNnQEZVn9QTCf
	nWp5lFKEoZryQm8jtS3IHktg/pYQmb/LpUFekbeyVDvGYKG7qyQVZk8jfqydP8uyCrN8U+Yl24q
	1xkmllLDC2RK11FjUi9tGxELJ7L38uTITyf64nyPEVhgqXJR0a0bSMQCnfgIwf/gdQA4LiGj/8+
	GQwx9wRd4hZsqbVCPxD9SMbWp9+AxF4c458tWa8x465kAG2GqtP3mlDWHYe7rD9e4/MiZ3I9+Ix
	Uv3ElthDhRBNMwrakuAK7rBB5+84SwtuA4S3gD7QLZPthv/Ycx26D5t9euuijnOvewoprYbPsyH
	2I=
X-Received: by 2002:a05:6402:4018:b0:6ac:62c2:bd35 with SMTP id 4fb4d7f45d1cf-6b408ea5bb6mr3557260a12.13.1792649796255;
        Wed, 21 Oct 2026 23:16:36 -0700 (PDT)
X-Received: by 2002:a05:6402:4018:b0:6ac:62c2:bd35 with SMTP id 4fb4d7f45d1cf-6b408ea5bb6mr3557232a12.13.1792649795809;
        Wed, 21 Oct 2026 23:16:35 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4030db05esm1525188a12.10.2026.10.21.23.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:16:34 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Xiubo Li <xiubli@kernel.org>,
	Venky Shankar <vshankar@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Vaishnavi Deshpande <vadeshpa@redhat.com>
Subject: [PATCH] ceph: unlock an abandoned file-lock grant from its reply
Date: Thu, 22 Oct 2026 06:16:30 +0000
Message-Id: <20261022061630.1832692-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAOuZWzxd85AzOGGh_DQduVRbGLnDrfyQ0ZJXcWEDJmVEVZPdcg@mail.gmail.com>
References: <20261015064202.62886-2-vshankar@redhat.com> <20261015155808.140236-1-amarkuze@redhat.com> <CAOuZWzxd85AzOGGh_DQduVRbGLnDrfyQ0ZJXcWEDJmVEVZPdcg@mail.gmail.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Venky Shankar's "ceph: don't drop a lock grant that races with an
interrupt" keeps a sent SETFILELOCK registered and waits for the MDS
reply, so a grant is not dropped. Xiubo Li pointed out that
wait_for_completion() leaves a killed task in D state, and that a
failed interrupt request still aborts a request the MDS may already
have granted.

After the interrupt is sent, wait with wait_for_completion_killable().
If that wait is killed, or the interrupt request fails with -ENOMEM,
-EIO, -ETIMEDOUT, or -ERESTARTSYS, leave the original request
registered and mark it abandoned. ceph_mdsc_wait_request() returns
that error instead of aborting or reporting a late grant as success.
The reply callback sends an unlock when the result is a grant.

Suggested-by: Xiubo Li <xiubli@kernel.org>
Cc: Venky Shankar <vshankar@redhat.com>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
Base: https://github.com/ceph/ceph-client.git testing
797fedea5c2bc44fc6d92526999fd4242052a4ee ("ceph: fix uninitialized err in ceph_netfs_issue_read()")

 fs/ceph/locks.c      | 119 +++++++++++++++++++++++++++++++++----------
 fs/ceph/mds_client.c |  11 +++-
 fs/ceph/mds_client.h |   1 +
 3 files changed, 102 insertions(+), 29 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 4bd96d0beba4..308de4c4f31a 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -163,6 +163,66 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	return err;
 }
 
+/*
+ * The waiter was killed, or the interrupt request failed, after the
+ * original SETFILELOCK was sent. The MDS may still grant it. Unlock a
+ * grant so the lock is not left held by a caller that already returned
+ * an error and did not record it locally.
+ */
+static void ceph_lock_orphan_cb(struct ceph_mds_client *mdsc,
+				struct ceph_mds_request *req)
+{
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_mds_request *unlock;
+	struct inode *inode = req->r_inode;
+	int result, err;
+
+	if (!req->r_reply_info.head)
+		return;
+	result = le32_to_cpu(req->r_reply_info.head->result);
+	if (result)
+		return;
+
+	unlock = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETFILELOCK,
+					  USE_AUTH_MDS);
+	if (IS_ERR(unlock)) {
+		pr_warn_ratelimited_client(cl,
+			"abandoned lock grant on %llx.%llx could not be unlocked: %ld\n",
+			ceph_vinop(inode), PTR_ERR(unlock));
+		return;
+	}
+
+	unlock->r_inode = inode;
+	ihold(inode);
+	unlock->r_num_caps = 1;
+	unlock->r_args.filelock_change = req->r_args.filelock_change;
+	unlock->r_args.filelock_change.type = CEPH_LOCK_UNLOCK;
+	unlock->r_args.filelock_change.wait = 0;
+
+	err = ceph_mdsc_submit_request(mdsc, inode, unlock);
+	if (err)
+		pr_warn_ratelimited_client(cl,
+			"abandoned lock grant on %llx.%llx could not be unlocked: %d\n",
+			ceph_vinop(inode), err);
+	ceph_mdsc_put_request(unlock);
+}
+
+/* mdsc->mutex held. The request has been sent and has no result yet. */
+static int ceph_lock_abandon(struct ceph_mds_client *mdsc,
+			     struct ceph_mds_request *req, int err)
+{
+	lockdep_assert_held(&mdsc->mutex);
+
+	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags))
+		return 0;
+
+	req->r_args.filelock_change.wait = 0;
+	req->r_callback = ceph_lock_orphan_cb;
+	req->r_err = err;
+	set_bit(CEPH_MDS_R_ABANDONED, &req->r_req_flags);
+	return err;
+}
+
 static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
                                          struct ceph_mds_request *req)
 {
@@ -191,12 +251,11 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 		err = 0;
 	} else if (!req->r_session) {
 		/*
-		 * haven't sent the request, so the MDS can't have granted
-		 * the lock: abort it.
-		 *
-		 * ensure we aren't running concurrently with
-		 * ceph_fill_trace or ceph_readdir_prepopulate, which
-		 * rely on locks (dir mutex) held by our caller.
+		 * Not sent, so the MDS cannot have granted the lock:
+		 * abort it. Take r_fill_mutex so this does not run
+		 * concurrently with ceph_fill_trace or
+		 * ceph_readdir_prepopulate, which rely on locks held
+		 * by our caller.
 		 */
 		mutex_lock(&req->r_fill_mutex);
 		req->r_err = err;
@@ -223,32 +282,38 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 
 	intr_req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETFILELOCK,
 					    USE_AUTH_MDS);
-	if (IS_ERR(intr_req))
-		return PTR_ERR(intr_req);
-
-	intr_req->r_inode = inode;
-	ihold(inode);
-	intr_req->r_num_caps = 1;
+	if (!IS_ERR(intr_req)) {
+		intr_req->r_inode = inode;
+		ihold(inode);
+		intr_req->r_num_caps = 1;
 
-	intr_req->r_args.filelock_change = req->r_args.filelock_change;
-	intr_req->r_args.filelock_change.rule = lock_type;
-	intr_req->r_args.filelock_change.type = CEPH_LOCK_UNLOCK;
+		intr_req->r_args.filelock_change = req->r_args.filelock_change;
+		intr_req->r_args.filelock_change.rule = lock_type;
+		intr_req->r_args.filelock_change.type = CEPH_LOCK_UNLOCK;
 
-	err = ceph_mdsc_do_request(mdsc, inode, intr_req);
-	ceph_mdsc_put_request(intr_req);
-
-	if (err && err != -ERESTARTSYS)
-		return err;
+		err = ceph_mdsc_do_request(mdsc, inode, intr_req);
+		ceph_mdsc_put_request(intr_req);
+	} else {
+		err = PTR_ERR(intr_req);
+	}
 
 	/*
-	 * Once it has handled the interrupt, the MDS replies to the
-	 * original request: 0 if the lock was granted first, -EINTR if
-	 * the wait was cancelled. Wait for that reply even with a fatal
-	 * signal pending, so that the caller records a granted lock and
-	 * the lock gets released when the file is closed.
+	 * The MDS replies to the original request after the interrupt:
+	 * 0 if the lock was granted first, -EINTR if the wait was
+	 * cancelled. A fatal signal must not turn this into an
+	 * uninterruptible sleep. If this wait is killed, or the
+	 * interrupt request never went out, leave the original request
+	 * registered. Its reply callback unlocks a late grant.
 	 */
-	wait_for_completion(&req->r_completion);
-	return 0;
+	if (!err)
+		err = wait_for_completion_killable(&req->r_completion);
+	if (!err)
+		return 0;
+
+	mutex_lock(&mdsc->mutex);
+	err = ceph_lock_abandon(mdsc, req, err);
+	mutex_unlock(&mdsc->mutex);
+	return err;
 }
 
 static int try_unlock_file(struct file *file, struct file_lock *fl)
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d4ef8a355a48..f485beb3584b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4076,8 +4076,15 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 	boutc(cl, "do_request waited, got %d\n", err);
 	mutex_lock(&mdsc->mutex);
 
-	/* only abort if we didn't race with a real reply */
-	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
+	/*
+	 * The caller was killed or the interrupt request failed after
+	 * this request was sent. Leave it registered. A late grant is
+	 * unlocked by r_callback; do not turn that grant into success
+	 * for a caller that has already given up.
+	 */
+	if (test_bit(CEPH_MDS_R_ABANDONED, &req->r_req_flags)) {
+		err = req->r_err;
+	} else if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = le32_to_cpu(req->r_reply_info.head->result);
 		if (err > 0 || err < -MAX_ERRNO) {
 			/*
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 863cdb8d588a..e198ede629fd 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -360,6 +360,7 @@ struct ceph_mds_request {
 #define CEPH_MDS_R_PARENT_LOCKED	(7) /* is r_parent->i_rwsem wlocked? */
 #define CEPH_MDS_R_ASYNC		(8) /* async request */
 #define CEPH_MDS_R_FSCRYPT_FILE		(9) /* must marshal fscrypt_file field */
+#define CEPH_MDS_R_ABANDONED		(10) /* caller left; reply unlocks a grant */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;

base-commit: 797fedea5c2bc44fc6d92526999fd4242052a4ee
-- 
2.34.1

