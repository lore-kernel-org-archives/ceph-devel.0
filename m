Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF14346FC4
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305503; cv=none; b=IoKmRnVL+tII8WZ+c3jCjo+URgfMVMda5Veknz89d3aiDPfw6uoER2Fj5Bmpwz938ZYwarDJegQ71flN0Wu047YEmUxu5y6ZWWJIeYxYCABGT5Thnp0DkaUUZCFDVuS7zVoBPoocoYtk17oEJU+JJXY0qy/xjTlSEdXZ/qfZbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305503; c=relaxed/simple;
	bh=pCv+FMmg4bDM0R8r1ysnaVHdTxdZ42LE4SRbeeP6ITQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJ6SAH3a0HSyxzEKdMqa7ADMCrO5XeDw5VY+nXWKo0iDmfBIgvNmTTnj0GFRpjBP8UJHj19LA69h9f1cYXn+TGbyTa0mIkrOvAw/ppOnvS2UUUSAes9mp0Qp7QFWjTSmcWqMPyY7Hf7vvbm4O3yLKZWaNrXIzDfdUrGB8PwD9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fbNIrjaB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fbNIrjaB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso96793055e9.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777305500; x=1777910300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtFAIK+j/XCoVY73JQb1aVbAbSFTEbUxClYYOwgSKnk=;
        b=fbNIrjaB4jrHKlgbHOe70KwF5nrIrFX7CNKpuEmympdHMrtAffOcGDj0hc29kpbCtI
         BofB6mkX2ERMJc27HO/ELDJzmCot0SxBhbXdsYKhlVFeq+0ZBT8kIQZWCVBlIkFE/AQI
         3ElTEcCMBpgcLC3QcjlsPCCNKUvLMKiy19v75cFBNPym4brcckjW7pC0jfbXDTJcBCXf
         h1BuBC5XWjpduH1W3+h7luVpCo3EHDhQ8uJEANdKiQRGyTYOFKy/h5HvebOMIwDVWVKD
         xzwE5BC5gpg30y1A0UTDbFcBPkbFLamPEe/zzJ09hdWa38V4X2zUQVubE6G9e1fM/4oO
         fJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777305500; x=1777910300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtFAIK+j/XCoVY73JQb1aVbAbSFTEbUxClYYOwgSKnk=;
        b=R6X2ScgNYqWkiSgviPLWD4MF8+0pb3dGjURt8Bo7aYF0wkce+mjootJJCDlFb+YssU
         MItlLZGW8EmS0OfxL7fDSoxhkp46Az11fO9dFcptL0LAiOZxcUlGX9qmya/EFY2BUSC9
         j1dH1Ajr+eQi9wL2mcosHXN51UuilE6uySG9q2LJO4St10w+G77Pc/DdI/H+qt+aMfqh
         oIezuHwMlYibGabc3y1caZ1/RRHjBSdAcSiavyiRafI7EgR5P4NqineA4nHRPqkC+IyA
         SnYPXH9fww9RUvIdlQ7MxImyKBqMTaVbkIVHcqtWWL195KJtBqxXHEcfYmg8rYrIBNH9
         3jDw==
X-Forwarded-Encrypted: i=1; AFNElJ8O2DFp1UHhI1Bfnc9kV3a/I5rmltEtk1E/yhaqRrnBunReTlg91W+tBJV6MdzEIV20wXEPQqiajPE+@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMulRHg8TH9AcIUlf4Drv6DcZppBdFvO9q6e79a1XBH7sGRv8
	ZfdX21f/9VzQ/25RMXsdA3UH86nX4H6aCi26PybsH+SIhCXvwFZ5MXctVw+dIR9f+g0=
X-Gm-Gg: AeBDiesOzzxCrIdhAfMTTLhZv0N1qZj0gO23FqaNSJvamx3e4XQ+a+1rlBSlhU2m/CL
	8H8+ubVyR8azAN0wOH8i5qUpui8S1K6iEgzUPjMKBvgSm/q7nFrojsyOQcyvSV+2BajJ8IejOQd
	XjiWKm6rh/nshC6mgWmrbSdSG0VeQ/0DZnE+XO3gw4jUnFh3AuNbfua5346iXsZf8EKWE2sTuIm
	KquIwQHaaC1PWF+bk7l58jxX/jct0vqRsLAuCm9u04TRnifwLaNCFJie+48LOM7FNysEpfzd58F
	Qx6caGG8dPPYPxu9TiA94FeKodxgKQ19cdUUBL6D0lEnGp7mqszYl/tLJf12UHv4lJkGROApo3D
	FaBQBie81LqMojk8H1RlmBwohBl4NU2gQhSLWTIgiIyDGiSO7V3EKmmmqbvfLr6kzx/rbgzQMGh
	1lCdXY2ninoMesMWGbti/Agzv4Xk9D56gFPo4kYRraWv29Mw+pxDrwaN+OFNIHsgtMaBEIb08H5
	u6tk0r52ryYcZn8x/MnfVRr4Yw3Ulcu8sgJfQ==
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-488fb750a2bmr438385685e9.10.1777305499942;
        Mon, 27 Apr 2026 08:58:19 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f029600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:9600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5c4b9e8dsm121183915e9.7.2026.04.27.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:58:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
Date: Mon, 27 Apr 2026 17:58:13 +0200
Message-ID: <20260427155813.2561935-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A reader can hang forever in __ceph_get_caps() when the client no
longer holds `FILE_RD`, but local cap state still says that the
capability is already wanted (via `mds_wanted`).

One way to trigger this is through MDS cap revocation.  If another
client performs a conflicting operation, the MDS can revoke `FILE_RD`
from the reader; the next read then has to reacquire `FILE_RD`.  If
the cap update that should request `FILE_RD` never reaches the MDS
after `cap->mds_wanted` was raised, the reader is left holding only
non-file caps while local `mds_wanted` still includes the file read
caps.

In that state, try_get_cap_refs() sees `need <= mds_wanted` and
returns 0, so __ceph_get_caps() just waits on `i_cap_wq`.  If the cap
update that was supposed to request `FILE_RD never reaches the MDS
after `cap->mds_wanted was` raised, no further request is sent and the
waiter can sleep indefinitely until unrelated cap traffic happens to
wake it up.

The ordering issue is that `cap->mds_wanted` is updated in
__prep_cap() before the `CEPH_MSG_CLIENT_CAPS message` is actually
queued for send.  That makes one field serve two different meanings at
once: what this client wants, and what the client believes the MDS
already knows it wants.

A proper fix would be to split those states and track whether a cap
update is actually in flight or has been observed by the MDS.
However, simply moving the `cap->mds_wanted assignment` later would
not be sufficient: queueing the message in the messenger does not
guarantee that the MDS processed that specific wanted set, and
reconnect or message loss can still invalidate that assumption.
Fixing that properly would require a larger rework of the cap state
machine.

To allow simpler backports to stable kernels, this patch implements a
simpler workaround:

- stop waiting forever in __ceph_get_caps(); after a bounded wait,
  fall back to the renew path

- make ceph_renew_caps() issue a synchronous `OPEN` request whenever
  the inode still does not actually hold the wanted caps, instead of
  only calling ceph_check_caps()

The extra issued-vs-wanted check in ceph_renew_caps() is necessary
because the previous test only checked whether the inode still had any
real caps at all.  That is not enough after revocation: the client can
still hold something like `pLs` and yet be missing `FILE_RD`
completely.  In that case, falling back to ceph_check_caps() is not
sufficient, because it still trusts `cap->mds_wanted` and may resend
nothing.  By requiring `(issued & wanted) == wanted` before taking the
asynchronous path, the code only uses ceph_check_caps() when the
`wanted caps` are already actually issued.  Otherwise, it sends the
synchronous `OPEN` renew.

This preserves the existing asynchronous fast path when the wanted
caps are already issued, avoids changing cap-state semantics, and
fixes the hang by guaranteeing that a stalled waiter eventually
retries through a path that does not rely on the stale `mds_wanted`
state.

Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c | 20 +++++++++++++++++---
 fs/ceph/file.c |  9 +++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..dd11611f250b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3087,11 +3087,24 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 			flags |= NON_BLOCKING;
 			while (!(ret = try_get_cap_refs(inode, need, want,
 							endoff, flags, &_got))) {
+				static const unsigned long wait_timeout = 5 * HZ;
+
 				if (signal_pending(current)) {
 					ret = -ERESTARTSYS;
 					break;
 				}
-				wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+
+				/*
+				 * If a cap update is lost after
+				 * mds_wanted was raised, waiting
+				 * forever will never make progress.
+				 * Retry the renew path periodically
+				 * so we can resend synchronously.
+				 */
+				if (!wait_woken(&wait, TASK_INTERRUPTIBLE, wait_timeout)) {
+					ret = -EUCLEAN;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -3125,8 +3138,9 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 				continue;
 			}
 			if (ret == -EUCLEAN) {
-				/* session was killed, try renew caps */
-				ret = ceph_renew_caps(inode, flags);
+				/* session was killed or a waited cap
+				 * request needs a retry */
+				ret = ceph_renew_caps(inode, flags & CEPH_FILE_MODE_MASK);
 				if (ret == 0)
 					continue;
 			}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d54d71669176..47c7d4a5ffed 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -314,7 +314,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
@@ -322,14 +322,15 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
-	int err, flags, wanted;
+	int err, flags, wanted, issued;
 
 	spin_lock(&ci->i_ceph_lock);
 	__ceph_touch_fmode(ci, mdsc, fmode);
 	wanted = __ceph_caps_file_wanted(ci);
+	issued = __ceph_caps_issued(ci, NULL);
 	if (__ceph_is_any_real_caps(ci) &&
-	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
-		int issued = __ceph_caps_issued(ci, NULL);
+	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap) &&
+	    (issued & wanted) == wanted) {
 		spin_unlock(&ci->i_ceph_lock);
 		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
 		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
-- 
2.47.3

