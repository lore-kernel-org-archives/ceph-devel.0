Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36B328B7B
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323507; cv=none; b=nmGkyKkgs9DFjZBaQiaCzZgDs9G6/YKwkMB0GvEMDBAyLwaQlxBJwVYmdXiaNIFKFHX4EKqjEyBGt/h61i0n5ZPtcv7zJls0EdTxIV9LVYuAf+LZR2dVKADftFSpd1dhVt7aZBHyd0+zvge8Qe9CLiKd1uxhR23peWVuX+Kq+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323507; c=relaxed/simple;
	bh=yxN3n0uBBoB2PeQfjEmRc4+n8vulLTGWas8pBgZoFJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmL70+xn23tU6RGCQZtgiXvnh+B5gUOMgnLk99RnWu74S4V1nfnYtayNQvpQjpM6wVaqork9F/Jk2MbhK3pPuPP9XTQ9yAbs6vZ6feylBABr7Jib0+HCEPccmAddqOUt89IBWSPwU5HsEytGVfukiDYxudYAmxJjDFsOM7nNw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WR/29PNw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WR/29PNw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1816313f8f.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783323498; x=1783928298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh8gDU6QfX3j0JIY2KVF2WbaCqIvK2bLILJNkOnE3p4=;
        b=WR/29PNwMyRJOHI7yncWzFDYd1rXCBHuiQormxhegKGm63mMFr4m83/2cgtPIy8dwS
         iUKe85WPJey31Y1irBlpwkzUzgqWKe1/jqdDnrRbdzbRPL5dFcdpg5qyExufqWZg1MXL
         Aa0cY7BVoWyolBwoXwdOxZUdB5s9wCmSQaEA8lrj/MsuPorulxln5TnelkfbhgTtu3Xu
         /Qzj8TwJVXWAz+4CRUvCfrJ0enbUoCnNFd62CGIcvi7vRYdiquwDsE6wrELItYZMoFBT
         1Zstc2Y3hMGM6klD1gvG8JVf+xKG1jQdML7UZt2cwb4Y2AeOhKq8gnRI5Bnq8yxOX+5n
         ctyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783323498; x=1783928298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gh8gDU6QfX3j0JIY2KVF2WbaCqIvK2bLILJNkOnE3p4=;
        b=II/SL0CTuvb2opkz5eRSj71LjzHy7dJDQ9dxzOxWYXwsg2K+nR3ntguJxuDNa0Gaj+
         MCMzXdotEw+7tndOvK28rA08leAEJLTuci1ozs3J4XQYVLMhWHwmXuNReAeyHbqch6X9
         cqG0Oo46obWFMQA0vzEE7zERyVfvq3SNP4D652hnIrdgnLZ71WguwfIeVk+AKek/7CMq
         KpEZvqXLtCIL6+0IUgrWKkunp/61DxJZ0YUky9txWhNU5NF1VgvYqzvpC6WWOWLbqxZK
         B7Aa1ggkw9OipcFQf+dg4UuS7m2GcwRDnRA0sK9ynCQJRoltTg+2ygniRibeocIeVTxl
         gnzg==
X-Forwarded-Encrypted: i=1; AHgh+Rplh5WYr88w3RcasRugnOgjiP8HAv71cX1XY4AVHCwDSLFUtqzAYtIrklXQzdLw5bCNqBpYteiDl2at@vger.kernel.org
X-Gm-Message-State: AOJu0YywQ1ffcrcuhkE0ndzS4Ip8To1BjVoceByLjyehmCozJtcTenIH
	qKVkvpii6SZGkVi6vcBBSv0jBf/utWZbBNFz23xO2NPn7MjLk2zBJjvS6pnQH2nnfV4=
X-Gm-Gg: AfdE7cneKgFwODJ1nW3xHlvlXmOXSLZyS+db0TsKvJLVUFWls3GmMkesGe4HLBkdwFb
	woaKHUH3bdMmffAb27BC/Kwfq2xL4Nma3UEdYrwpyHJLRmzNzHXyM34Fa0JKvlIFNX47lL+9hdP
	iddiGfXCyQBpaHF12E/L0QQtEZLDPa/n7eBHeWsuHYRRfzmJYNbt+JYpXrI1NeQrNuO88IqOvN2
	tdsAWrHDcn9Y9ZY8l+K9AeF7zYC+DW0ANGxVuHg9I+Scmvf8EGsBRCXZl8gZI3z8n7/68pRHF9A
	EoVJbpd13U9fBSRdNLTTXzqqKoQUqGzq92g3JWHf/DoqS9rTmaMHP6CeHyYbAdATwrv75eGPPeI
	haC9cbkxm1agbYOUq+YOD1sfBRFm2KUNdjrVt/npjpOpsMtahUx9+e/lBzuKhVpG171Ym5Yjowi
	miIXJHfK2dW6hg6Jfj+0RoztFlo7t0ahJlu+MdWkOQOKWpTm8P1II03YbAL+uyhRd4+DVC66rdE
	mf7BBQpyM739t+y
X-Received: by 2002:a5d:64c8:0:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-4793685fb5amr16402118f8f.16.1783323498066;
        Mon, 06 Jul 2026 00:38:18 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm22248585f8f.3.2026.07.06.00.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:38:17 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 2/4] fs/ceph: add helper function ceph_cap_is_removed()
Date: Mon,  6 Jul 2026 09:38:10 +0200
Message-ID: <20260706073812.3922732-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706073812.3922732-1-max.kellermann@ionos.com>
References: <20260706073812.3922732-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having it as a wrapper allows replacing the implementation, which the
next patch will do.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c       |  6 ++----
 fs/ceph/mds_client.c |  2 +-
 fs/ceph/super.h      | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index c1213d72645e..f6f3e817b712 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1128,8 +1128,7 @@ static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	struct ceph_mds_client *mdsc;
 	int removed = 0;
 
-	/* 'ci' being NULL means the remove have already occurred */
-	if (!ci) {
+	if (ceph_cap_is_removed(cap)) {
 		doutc(cl, "inode is NULL\n");
 		return;
 	}
@@ -1201,8 +1200,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_fs_client *fsc;
 
-	/* 'ci' being NULL means the remove have already occurred */
-	if (!ci) {
+	if (ceph_cap_is_removed(cap)) {
 		doutc(mdsc->fsc->client, "inode is NULL\n");
 		return;
 	}
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 853bf698b356..019f5e60ff82 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1902,7 +1902,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 
 		spin_lock(&session->s_cap_lock);
 		p = p->next;
-		if (!cap->ci) {
+		if (ceph_cap_is_removed(cap)) {
 			doutc(cl, "finishing cap %p removal\n", cap);
 			BUG_ON(cap->session != session);
 			cap->session = NULL;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b878f14ca959..628d153601a5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1269,6 +1269,20 @@ extern void ceph_add_cap(struct inode *inode,
 			 unsigned issued, unsigned wanted,
 			 unsigned cap, unsigned seq, u64 realmino, int flags,
 			 struct ceph_cap **new_cap);
+
+/**
+ * Determine whether __ceph_remove_cap() has been called on this #cap
+ * (but the object has not yet been freed because it is protected by
+ * `ceph_mds_session.s_cap_iterator`).
+ *
+ * Caller must lock either `ceph_inode_info.i_ceph_lock` or
+ * `ceph_mds_session.s_cap_lock`.
+ */
+static inline bool ceph_cap_is_removed(const struct ceph_cap *cap)
+{
+	return !cap->ci;
+}
+
 extern void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 			    bool queue_release);
 extern void __ceph_remove_caps(struct ceph_inode_info *ci);
-- 
2.47.3

