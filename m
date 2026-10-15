Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87E306767
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045787; cv=none; b=WVy5KyMzc8z3XWUNW2g2FUo8CaPK2UmTY4lsAjSeEpjWhFNfe4z38ZQJKqTt1T23ArC55i+u/a6J3jGhYumbPtSu8ogdz8sfcztoOQRE3+xc4CPBJS7YBkoFVAFd2pekFUuLAQGviZnsniRddrtfAjZkma7LyTDTz174B3bYok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045787; c=relaxed/simple;
	bh=vKtM+FomHodrd7Jjf3HxnqNwoL0VFUpwEfWow27ss1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooaFk9RYPVr+OmNAvqwX6oACZ8447UbsqFtrDyAMOOuEsEWBlai2ybw6f1lvrsU6VFVtna6LUvUlW9WRQT1eZeEqzUlArN0snDPvsZvE7sqUwaYgKy74DTq68Ig/3x3LXmrY9j1GPlE++kSVbpbB32QuX7X7HzbBjRrVCK0At2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxyBgyih; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTvRYNPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxyBgyih";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTvRYNPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792045785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90DLX6FGGiQg1AubES264McU+oT3sJ5XjN9SPrGyCcE=;
	b=MxyBgyihVezJqjnSSh86ge2RvuqDPMB0EJ3qmpeKvnQWwopq3+8x7eOfrmLcSooXAoSmH8
	TVz4LFYxq72u7i5XnX53/gI6qiXMlDJIGSCzynhj0gDBhsWzmxN0TAEEsAt2zuK4ATFdF0
	O6YbnrwdpRDuLoggpbKKg0qdafSGuv0=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-HK4tqdY5P5mvaGUxGNdesg-1; Thu, 15 Oct 2026 06:29:38 +0000
X-MC-Unique: HK4tqdY5P5mvaGUxGNdesg-1
X-Mimecast-MFC-AGG-ID: HK4tqdY5P5mvaGUxGNdesg_1792045777
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso7265315eec.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792045777; x=1792650577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90DLX6FGGiQg1AubES264McU+oT3sJ5XjN9SPrGyCcE=;
        b=MTvRYNPqXwQY91yB0DkcuLk9jgNlqfok+f8sB/Secjv4GVwqEr+3CCHIAkyBa5wvQ7
         4rrBAm0hDNIm2wPBG25Ky26fgXCf37dpaXXcGkwzdoUCv0Cz8Uq9Xbm66qUxqkl9hXst
         eWhXzbBo6W5YJq6+IXNzadg4Rt9fzLCMILcNsHcj7NFE8ScfQVOOfH+zyzx9Hv42CblA
         bxerKkJziuBIg9guF9T3gz180upiXFmZ9rSEGG2DQQks2vcFNQikmajzJVp43zHQRtld
         BkoCdP4PrGOdX4vc3w7KwSk7Htcnxkd2DjP+X7f8y8IG+Z6Pn0blwz9RxaiwhsKHcv6G
         xLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792045777; x=1792650577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=90DLX6FGGiQg1AubES264McU+oT3sJ5XjN9SPrGyCcE=;
        b=JqCdqfPN6U9z7r1t77t07w5EIo23Fcv99Ibzp/3xyOb441npc/P8mQcwDiYdXc0+NU
         8TqFgbK9iG99JOHoVbsHoin8jjhKkADor//tBSMOtymsiCT3ue+yl0CmB3Viw/Ar15Cc
         Mez4lUu4nvuFor3ZEZsT5tFGFp7rY/qvRKrAq7hOxWkOqL0GpVIReUKEf9ypSRekVHeU
         x5NIjI9hQ1iJ0szmRnQ2zmmGhRxDPEJy3QYgplNmwbaNOgp/TT00aZ3m6Ka5UqWgKeSJ
         5qo1t7uoy72KFD7EcQFUQdPmGFSNmgG2rtWjfmQTs46rwBBSwFYkB89aJmRxID8++Du4
         5ajA==
X-Forwarded-Encrypted: i=1; AKwUvBw3OqDPa94ZT1VzzsJmYTdINiZZrTmPn+dI384ST/AWoHJlg2CkgK6Czeyta8YUPAxDVNckZFRF5Dw/@vger.kernel.org
X-Gm-Message-State: AFq9FYIsgk9zNgl3CjWqzWWw/9XWi95Ha+dl97CPHfV7YSS/g/6NPs1u
	ypswZ2HIyrbFADEdbOLH4THWCMQwchcPwrZV8CHm559+oVXMy9e9cZGlvXVDwztTY8fPfsquaSO
	/EcGLH0UcTiAWT6/WYxSp8hwI2/QfsKzSKOGvzuI7iVma31C9/lP4NuXgyphZZrs=
X-Gm-Gg: AYBFou0HO9nZm1dAjd3SZWB4JBJ22PqTH8Y/TbxPz7N3MMSyV3jMnbojA4g67hUgEFP
	oJt1U8AchWH7AMCefTPxnkkClbnyzgjo7joK9W1s1Whycn26t6tBm9tY/TSo6Q/1RAZcKRwHVZx
	TX5fDOvtIQd4yP2lFW2yjSNc8GwnZpMLk67kYWzwwwqG6RVXSYPtvgkgOZFZtw3jwrs3qu0/BdZ
	m+dmPYbS06rlT8qOGgTGaZeW7ZbjDzKpKyzffdCLytj8zxVL7rxBmjpaJ0a9Sc8lHQgcvckp9LJ
	qtVg8NVU86m296nN+JuMg/q/d6NY6x/Q771cBsXG61duvWiGBjfSdM4UREwuFgN45/nogFLLXdW
	EJTvehe40UvZs2+TaQhHpUJIt7MqxgpuocwXLxGQb
X-Received: by 2002:a05:693c:87cd:20b0:356:9345:a07c with SMTP id 5a478bee46e88-3569345a944mr25187745eec.22.1792045777263;
        Wed, 14 Oct 2026 23:29:37 -0700 (PDT)
X-Received: by 2002:a05:693c:87cd:20b0:356:9345:a07c with SMTP id 5a478bee46e88-3569345a944mr25187711eec.22.1792045776646;
        Wed, 14 Oct 2026 23:29:36 -0700 (PDT)
Received: from octo-node-1 ([106.51.46.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm69422337eec.14.2026.10.14.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:29:36 -0700 (PDT)
From: Venky Shankar <vshankar@redhat.com>
To: Xiubo Li <xiubli@redhat.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>,
	ceph-devel@vger.kernel.org,
	Vaishnavi Deshpande <vadeshpa@redhat.com>
Subject: [PATCH 1/1] ceph: don't drop a lock grant that races with an interrupt
Date: Thu, 15 Oct 2026 11:59:06 +0530
Message-ID: <20261015062907.62038-2-vshankar@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261015062907.62038-1-vshankar@redhat.com>
References: <20261015062907.62038-1-vshankar@redhat.com>
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

