Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47C2BEC27
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350426; cv=none; b=ScHgiXAqQN8aNOnZFN5ZUe6JXKIWSwllwty0FGQf0B0oIPfwr/4aW62Ibhd4EWIy9uuXbaxZj6f/2xEhivT5qCXulQTO5oWJw0bVEu5f7kfupIhkEjJW6RGYRphUd6oxzXwivbtPpNZWV9IOO76tYtmw10b72z9ZTm+FoBzhojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350426; c=relaxed/simple;
	bh=qhMAi5KmiohwSCCqT2HrcIJcCDFqUKinbe4/58G4JwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aa7njHax6veWHbZNWQsInvKnSHtQ86ke2s71aTpuTZfIvCM2eh1Aiug694Xdv+/Ylcy0sPR1d75aIBUOJzS9ihhfm9jwz5+lrsNOx5CyiNgRDe+2n5XbTnEV5JbQhwmL0a7spSbfGgg/BApqh8OGx3lB+zhqx24bCcV5m0vi1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NVn6zA9/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NVn6zA9/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4720d22c94aso3106956f8f.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783350422; x=1783955222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZhkuZBeVv8WpMV3dUfcpoEc5Qq3IQLo93rDLEp2ApNU=;
        b=NVn6zA9/rZXB6MulSnAs+flmWsJ3Wg5j3lhjgZWkxcQ7hYv4ivKpNBJxEFhLGOkKjL
         z+41z5k9SezQBGNZMIUyzioGjyZNQ8Lf+Q8vQ+SSDP8Lqnfi3omDAbE3H7VySbw+hMJK
         +RwQRChStBXC49V0Aldez8GBBCjgmCPQSl/l3hUJ6t+EOmSPYPOCdsAEn1+MCYb0R4cz
         4E0dRhYC8jPMHYnvGWp4/FmsHbyAW50YSxyluTcVqm+VcfCoVHewKAC84wBmahZhmVnc
         ceJuJr5jk/VFQuTwpHMjksBHJRVDXoa8X4VMGgZ2VHo617hqgxKpPlwjfYL/mBmmeVcp
         GTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350422; x=1783955222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZhkuZBeVv8WpMV3dUfcpoEc5Qq3IQLo93rDLEp2ApNU=;
        b=H8wLWU4RAfRiV+YUK3ZhRj4Z9BOs0pdb/tVt14nzIi7s4mb8J2D/FvkWuHwxm3i8Cd
         m0sLyRUcZvPaVU7bhT4afMnSOPcJHoQl31CxkMzA2umbSePHlcZc29LvZCu06DYZ4lLE
         //xMWck3nlrspRGivNhDbckB00nI4oHIfJMiseIfQQe0tlN6HAFLlbCKIYks5XCbFFf8
         0PC1q4sXIvuZZPtNK/FsLnc8QtoCqXuEAIu+8k+92VOJDx8ONcjChXjeW77GdfYvFoPh
         K6PXgZzlJcRnxcp1CREfFn6Irc7Pmy64jEG/r5Z1nSWXI1gEGpkjaIE27e0suiLlFFy5
         Bkbg==
X-Forwarded-Encrypted: i=1; AHgh+RqL9p7LBQ0lbaXtIrYz49jkKlsn7z6gxZd7yF9wDthF3GAlLwifW9AKlkZvgMjcZbI9N/Mm4/8JvlCg@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3fScS+tC5Kk5EjPc7Hmn6v/hvf6O2LEkpL1frapmWbUCT0hC
	IGSlKkoFHeL0qynWk/vIrb7oUXWWLclPTXGfY802BWJMGR4adjTIN9vp6QPitL+RtMg=
X-Gm-Gg: AfdE7cmWbosfXtNDKLc27uLtLUloUUow6LHf4gPtjJXTWPvo48jFjXxedYWwbKeRA5k
	F++2iSEq12fqiFWnXZ7dw2dgg346wnqBpuXq2vLBCEDcZJlNQ4TWm6kFC5J69/6mzTl5/DF7bq/
	JqT9t6gQ5SLQX4TP8E1wND7XjY9u40/4rldldMiAje+/riyJgSUGHurtrbLH1uQYe7Y4qGpwg1b
	2r0wYfEe1aZIeqk4pNAbCoEKgv+3bKMims7ttFwY/tfZFIF/LfFXe24OiyEKrieaziCaUF/7Zbu
	OOgKueFtFdfaJf5HEHDkQnrhJ0mJvgrj98/SBemItT3hyL5KGLNLEItm50DECJOloMw6neeWfkp
	zBnmp7Uc0Es1PJxK3ujZ7ugN+eDrOs4iHIiRyv3dw5CiK1UfzaXnjQtY3dJ8LLG9IzHJ+3RxxLY
	4rzmGuHONm2PK6AkMaeTKeLQviu/cXIQLt+ZlgDN+XdF1rQAyhB2R6rAt2kYSySPK5eNudH37xn
	jgmQnE9OHJ2oiXh
X-Received: by 2002:a05:6000:1a87:b0:472:c96c:eeb with SMTP id ffacd0b85a97d-47de6609b1amr911302f8f.0.1783350421874;
        Mon, 06 Jul 2026 08:07:01 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm24921043f8f.36.2026.07.06.08.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:07:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
Date: Mon,  6 Jul 2026 17:06:59 +0200
Message-ID: <20260706150659.3993925-1-max.kellermann@ionos.com>
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

Fixes: 0a454bdd501a ("ceph: reorganize __send_cap for less spinlock abuse")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2:
- add "Fixes" tag
- remove unrelated CEPH_FILE_MODE_MASK hunk
- convert const variable `wait_timeout` to global macro in libceph.h
---
 fs/ceph/caps.c               | 16 ++++++++++++++--
 fs/ceph/file.c               |  9 +++++----
 include/linux/ceph/libceph.h |  1 +
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..5907059592d3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3094,7 +3094,18 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
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
+				if (!wait_woken(&wait, TASK_INTERRUPTIBLE, CEPH_GET_CAPS_WAIT_TIMEOUT)) {
+					ret = -EUCLEAN;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -3128,7 +3139,8 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 				continue;
 			}
 			if (ret == -EUCLEAN) {
-				/* session was killed, try renew caps */
+				/* session was killed or a waited cap
+				 * request needs a retry */
 				ret = ceph_renew_caps(inode, flags);
 				if (ret == 0)
 					continue;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 71161f2b2151..a4a2a4b6a027 100644
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
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 63e0e2aa1ce9..d831a9b97c60 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -72,6 +72,7 @@ struct ceph_options {
 /*
  * defaults
  */
+#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)
 #define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
 #define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
 #define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
-- 
2.47.3

