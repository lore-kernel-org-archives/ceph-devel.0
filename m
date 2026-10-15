Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BC34041B
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046540; cv=none; b=WDCRfRcU7mRgpYZePcnviy4S/1jjxxkPN8vmKhWnlhwUIJ//928doKfg+xEhnN9yoJyLBFQ9MDiuIHrHUz1gCcXdIJ03BTFx25DZLauMRLjm2wbhy4iFw1FJnsOSWYycUCg5adhKVx2McjqtWzDbWY5Z9DqK7Ov9gz0yfrnMr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046540; c=relaxed/simple;
	bh=2xjJGQkiHfRtHPF48TryMfZ8XpQagBKrv/7Qch6YEuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjxjQo35Sl1xPBKQ1aRajOQg9ulmp/tgISemjTUtjp/mVvGtByUqYOxuj3pIyij0lHjscD1IjFGDSt+tdYFh7FAK17a5gvbDpOBic4TEfyYj0XgcvTOwk6tY6e0PFDRUyh63KERl1RF10cDWeT9hIoOOAwXi+etc3ARzU/vBa1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2lpWTXU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2LDoCNk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2lpWTXU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2LDoCNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792046537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vno8z2Ip0K61fnJDlrlqHtCl+IgSZZhbkcyiX3uGhFM=;
	b=S2lpWTXUAtsUzduag2t0M9PcdmYkv6l41osno1/DS7f8WYZIA3RgqUwNxJtcViLBTcBQtB
	ib2tI9CHkicxN+dZydDTHnUwueOmUw/uT7uu15cKbcWGiNbj0zjZ2A6WAvIqAnFoBSAuOD
	hoDiI5rofgBMk8QESzNK3n9UH30qsjM=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-9nBjwZShNX6-5ZWCvfqQQQ-1; Thu, 15 Oct 2026 06:42:15 +0000
X-MC-Unique: 9nBjwZShNX6-5ZWCvfqQQQ-1
X-Mimecast-MFC-AGG-ID: 9nBjwZShNX6-5ZWCvfqQQQ_1792046535
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so2224610eec.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792046535; x=1792651335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vno8z2Ip0K61fnJDlrlqHtCl+IgSZZhbkcyiX3uGhFM=;
        b=D2LDoCNk+3j0zrZiqsTs6bKGh2BMvz/47Zn8hewSOOYkljkNGkA9ZL0Av1pRxFsXVP
         rjSzaMpnNg5PDMAd2qxr/Eyqme5hxE3SLVgHrhcwPdr0c6Ai6X2eWlRH+a9CTbpDpj6J
         4kDXIk0idxgBIfJLK3RA0jwxL0qPI87Tx9GLVfFNbZbBA29E3tga++UhXS2lQAPbGgGF
         LoEdDsfUwLSbaCiCfEVqAar8DouZLWBfsUnmirGB4ypt0rQfJ2ix7nkjIPd9856fBUnw
         QYSWZ0kIos/wKT45mqAJOWhY1G3YHlJwQllWr4qi21Vn8O2lDhLWP6GqjiM0uZwEusIQ
         Efvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046535; x=1792651335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vno8z2Ip0K61fnJDlrlqHtCl+IgSZZhbkcyiX3uGhFM=;
        b=f8tDFHz/SLh/jCw3m4DmDGml14OI7+RHTOgaS7KPa0vaCbfO/3ZOz3gjUcUGOzRbb3
         Cj3N+a1B6zWeyyNkPcMKqqzZGQbAeaqjdg7psDDEFQsYt9zYf9f+Lq4QPj48xOPvyZH0
         mJrSS86eimtTbzZYvR0iO4X7TuB4g5maphAeqZNdZhQwDHSEyBjVbcCJcQLJDdxTbBJ2
         vvUS7usn8xLhHKDf1GaqFhsWnzVNx78e10zjBAQ4850twpxpK/nNKdm8ql8shAEAqOUc
         ZNCl/gCM4JnSPZ8gyy1mJPhSSZydt297W3IptraGy5UCdG8TzNvLmJmQLzvjxavTTgsH
         wicQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkgiRFUal71uAjMd8mas+RUN/oyU6mogoQtz63pvL3cSpba1igXnkZIJC0vPHP1nVOToz1eGojnSeM@vger.kernel.org
X-Gm-Message-State: AFq9FYJkQGb3WRkFf3At/PTcuG+f4lFRsYYBF31u9H7rWHtcBA0FJrqK
	/+5nE3dvkYHaddqqk/zeC09QNj5s26+OuF8VJQF7uSMVTb3A7pqmMNBCRMXK6nRDwEoNwIPGI1z
	pLiUp3yqEgsy8bZvisCifEtdk/ASb3xGpT0IPXHUXF1QFgNL7WaBN7zLZg0dpEeKLDuLCkIU=
X-Gm-Gg: AYBFou1ZSUX8DtsvMvoDCI3/C87fJ5A69gtulqfXtEcr7i51LohVKt4buLHnbArSuuL
	GDsdscuZC0asg06WZSDe0ad79rhR0s/uURXO6SNVeq/7qKTUc71N9DCadDnDKvnT3eJX6ezy1mX
	G7P3z2vjq1SrOfe3QCxlB3DFmUDqz474twvBPQA8GQUK8gI4M15myPXIiDORHcdHRaioVMr7CYr
	VipVOo+QED6DayzO+f+kPmELuBIYaaEyhAJzR6ojfVtjhC1BwfR9Sv0k2taNQAaFCLljxXVbVwd
	KDK1ehgUqVpJ7PP2n/8NjfnZc4lrTORa7Htfk0OXnHy258GDbTnx7CB4imjQ4AYtajGy8O2CuWG
	CBMnaL2HJ8pFeUMtAzE0T5W+zKzX500KYTgVgPT7V
X-Received: by 2002:a05:7300:8420:b0:351:7f5c:dbe1 with SMTP id 5a478bee46e88-3537e02318amr27472325eec.28.1792046534527;
        Wed, 14 Oct 2026 23:42:14 -0700 (PDT)
X-Received: by 2002:a05:7300:8420:b0:351:7f5c:dbe1 with SMTP id 5a478bee46e88-3537e02318amr27472277eec.28.1792046533852;
        Wed, 14 Oct 2026 23:42:13 -0700 (PDT)
Received: from octo-node-1 ([106.51.46.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm59352811eec.16.2026.10.14.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:42:13 -0700 (PDT)
From: Venky Shankar <vshankar@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>,
	ceph-devel@vger.kernel.org,
	Vaishnavi Deshpande <vadeshpa@redhat.com>
Subject: [PATCH v2 1/1] ceph: don't drop a lock grant that races with an interrupt
Date: Thu, 15 Oct 2026 12:12:01 +0530
Message-ID: <20261015064202.62886-2-vshankar@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261015064202.62886-1-vshankar@redhat.com>
References: <20261015064202.62886-1-vshankar@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a blocked F_SETLKW or LOCK_EX request is interrupted,
ceph_lock_wait_for_completion() marks the request aborted and sends a
FCNTL_INTR/FLOCK_INTR request to the MDS. The MDS only cancels a
waiting lock on an interrupt request; it leaves a granted lock alone,
since it cannot tell a newly granted lock apart from locks the owner
already held. If the MDS granted the lock before the interrupt reached
it, the grant reply arrives for an aborted request and handle_reply()
drops it. The caller returns an error, never records the lock locally,
and so never unlocks it: the lock stays held on the MDS, under an
owner that no longer exists, until the client releases its caps on
the inode or the MDS restarts. Other clients block on it meanwhile.

This is easy to hit with a waiter that gets SIGKILLed (e.g. a
container being killed) just as the lock holder unlocks. With a
fatal signal pending, the wait for the original request after the
interrupt returns at once as well.

Don't abort a request that has been sent. Send the interrupt request
and wait, uninterruptibly, for the MDS to reply to the original
request: it replies 0 if the lock was granted first and -EINTR if the
wait was cancelled. Return 0 so that the caller records a granted
lock, and turn -EINTR back into -ERESTARTSYS. Clear the request's wait
flag so that, if the request is resent to another MDS, it gets an
immediate answer instead of waiting behind a conflicting lock; -EAGAIN
from such a resend also becomes -ERESTARTSYS.

Reported-by: Vaishnavi Deshpande <vadeshpa@redhat.com>
Link: https://tracker.ceph.com/issues/81697
Signed-off-by: Venky Shankar <vshankar@redhat.com>
---
v2:
 - Use Xiubo's correct email address.

 fs/ceph/locks.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 677221b..1aac400 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -128,6 +128,15 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	if (!err)
 		err = ceph_mdsc_wait_request(mdsc, req, wait ?
 					ceph_lock_wait_for_completion : NULL);
+	/*
+	 * ceph_lock_wait_for_completion() clears the wait flag when the
+	 * wait is interrupted. The MDS then cancels the wait (-EINTR) or,
+	 * if the request was resent, refuses a conflicting lock (-EAGAIN).
+	 * Either way the lock was not granted because of the interrupt.
+	 */
+	if (wait && !req->r_args.filelock_change.wait &&
+	    (err == -EINTR || err == -EAGAIN))
+		err = -ERESTARTSYS;
 	if (!err && operation == CEPH_MDS_OP_GETFILELOCK) {
 		fl->c.flc_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
 		if (CEPH_LOCK_SHARED == req->r_reply_info.filelock_reply->type)
@@ -180,8 +189,11 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	mutex_lock(&mdsc->mutex);
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = 0;
-	} else {
+	} else if (!req->r_session) {
 		/*
+		 * haven't sent the request, so the MDS can't have granted
+		 * the lock: abort it.
+		 *
 		 * ensure we aren't running concurrently with
 		 * ceph_fill_trace or ceph_readdir_prepopulate, which
 		 * rely on locks (dir mutex) held by our caller.
@@ -190,11 +202,20 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 		req->r_err = err;
 		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
 		mutex_unlock(&req->r_fill_mutex);
-
-		if (!req->r_session) {
-			// haven't sent the request
-			err = 0;
-		}
+		err = 0;
+	} else {
+		/*
+		 * The MDS may have granted the lock already, and the
+		 * interrupt request below only cancels a waiting lock, it
+		 * does not undo a grant. So don't abort the request: if
+		 * its reply were dropped, a granted lock would never be
+		 * recorded locally and nothing would ever unlock it.
+		 *
+		 * Don't let the request wait on the MDS again if it has to
+		 * be resent (e.g. to a new MDS), so that its reply is not
+		 * held up behind a conflicting lock.
+		 */
+		req->r_args.filelock_change.wait = 0;
 	}
 	mutex_unlock(&mdsc->mutex);
 	if (!err)
@@ -219,10 +240,14 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	if (err && err != -ERESTARTSYS)
 		return err;
 
-	err = wait_for_completion_killable(&req->r_safe_completion);
-	if (err)
-		return err;
-
+	/*
+	 * Once it has handled the interrupt, the MDS replies to the
+	 * original request: 0 if the lock was granted first, -EINTR if
+	 * the wait was cancelled. Wait for that reply even with a fatal
+	 * signal pending, so that the caller records a granted lock and
+	 * the lock gets released when the file is closed.
+	 */
+	wait_for_completion(&req->r_completion);
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)

