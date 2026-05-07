Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0B13BE16E
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156872; cv=none; b=LSTOWLvCCLq10zzrhphQY2bP/EegHDcN7bW7UAfMRo+THyhXJZlHNaEIsgbRI5TZbdurjNX+9t6YWQCuom9nEUWRTYR1wezL1xc7BuZ1IIMc0AjmwTuJPR9TVdWLIWzVVy18N8cKJRV+bsuumvTc/IZzKBgH8qxP8mzYXoO5anA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156872; c=relaxed/simple;
	bh=BkwvWfSeKDQBzYewgCSDOX7+DXJwYrncWZ0nVxvGRoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gkz/lR3I95n6ZMJH5I/K41fIgyprnPjg1r3cjLP9G7AJNN+nu+A8FdF9SFQ2IIU1kNom6LatItonO94Wj09bUm1hOdV697wllWFdpd2dFXXlYePvYPd+8ccbpR5E0gHq+McPrpotn+JpwnRizvCxkDHagc89H7DCjjx5pkq8fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDI3WzVo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgDHkcSx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDI3WzVo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgDHkcSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzE1ZZ9iLT8Ua7YvTuaaF3p2dABvmzNW3xB0CEXdZLE=;
	b=CDI3WzVoHAxKkpTFD+NboIGseuXKwiHzZZr0kOFjzh2hqiRxGqyKikIU+SQdbWFeS1LeXD
	jFQ/wtFrtYAveCWtj+cr+Jry7o6VkcIsYDm29uAAWY5z5pEiZn3H3rSmPkF3WAwG59Pnb5
	ThNGHgGt2GyDrSNXHiBn8r5qZFOLy/k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-1QOwlzHoODKM368Yy2GuQA-1; Thu, 07 May 2026 08:27:47 -0400
X-MC-Unique: 1QOwlzHoODKM368Yy2GuQA-1
X-Mimecast-MFC-AGG-ID: 1QOwlzHoODKM368Yy2GuQA_1778156866
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b934e96af9dso91010966b.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156866; x=1778761666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzE1ZZ9iLT8Ua7YvTuaaF3p2dABvmzNW3xB0CEXdZLE=;
        b=NgDHkcSxUCnOBOLkfYLXfQit1A/eb0L2fXMEn5K2g30hcUSmURyzuK+HduAlS0/qQh
         xyfzb6zsCB7j05+poxVAOLir3XNFFDX+5/SKZf7ZTeRj3bYtw9ZLG4NOI8plOaFjoDW/
         G7WBEQrrhLk8WUNh/5h9SK3sA1GGS5Gp9yO9tHckjESZ2KqXp9FOUTT008G0fsnRng1E
         ZR14LvvABPqaFHGdqiMO3+uchoh7WWYl4Hkwrk5B8P+sVZKVAM3iFY7UlATZNF1HRWsP
         C7G8zOZcLl4wLSmK+kuBHLfG/oDMmQRmpoW+PFTejHq0S7LjGB3BAInoJAd47wqmykPN
         z3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156866; x=1778761666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mzE1ZZ9iLT8Ua7YvTuaaF3p2dABvmzNW3xB0CEXdZLE=;
        b=QYOQlHPEtN5myQC/D5lpt6xIQs+bLzvrzP6IbMEFOqIn6UeAM5Pf5gMK7tKW+MtcbH
         0vg1WJte56W2Ik7TCn2uyVREm24aASZNeq14VZERrxzsbFQnz19b+ij8yPvwXf5hyUP7
         TM//qG3cH0BeMOhJxT+lWMLlxKS5Ao+vGojqvm6MWud9ZGSvFks6cKwISFa2vLbCzGj9
         VswRzajOvFWM3XEantjpUB4j66HEeJwQedqiBMzMlpjfq176aqV2FZDHd75D7aFtzCux
         QLddir7UxzIjM1FO3t3x8QJI380u7DwmKNIj0BYdzZiIGSG3Z0fGltgCItBveA+OYE0z
         1DRA==
X-Gm-Message-State: AOJu0Yx1em35jSer+o4NPL3xCyO3Ka5stNmGXKCiwrEcWivIgg5yk75r
	/5A0iMVpdHSJ1LbJ17KjA+zqJQ4scTgc5xBDe4Q48jjiJtQxpFKOhMIp134l+JrECdlp2CrJz5D
	vDUrYIdPLzuPOeP0jwB9ic7uN1DXTsNTjKxlDVrkOhS4UeqQeb4q4J8aVdVhqlR/6qa72hA2lPY
	LLjMHNI4LdrNDxJMw/4CjrpoNrOK4kXfDOc6gBl7IqeFpYYBsWew==
X-Gm-Gg: AeBDietcx86Ad2X4I3qyhlqdC//aXwKwqKPFZUyZHD4lX3e0ij7+NefrMU85vGevpfa
	5M8kX34VIZMqG47KRK+nv/UTM8sxKTVsqEyu/1B+F8wVPes57bZ//K66HWjcpLMRkiZQTXpwH0d
	vrBtk5rqAiAcgYioIbAQggnr6CHtOYYD8nUPkcJ75sSVrqD+Hg1wkrOURrxO+ilDAklptccPzCi
	3SL44fA7qJkp8CwNMNEKCLHzn4w8oUm71N+zO71oef88vueR5SxMGYmZd7+wUuSZ5EC6TT0g0OR
	XtfGVOubUxoukcigx4BTu2b1ZXwg3Pv+v3gVDVONLpCYJEgFaZUxwrAqEkl5oasCdCizxHKcRqR
	LZvLyyop0trsODHYleEiEAhyGjxy7CcWDUdcXAyYmGuKB5CPRKZhPHx1xH/wTcmwX7w==
X-Received: by 2002:a17:907:3f24:b0:bc6:2bd3:8176 with SMTP id a640c23a62f3a-bc62bd388e2mr341828566b.35.1778156865760;
        Thu, 07 May 2026 05:27:45 -0700 (PDT)
X-Received: by 2002:a17:907:3f24:b0:bc6:2bd3:8176 with SMTP id a640c23a62f3a-bc62bd388e2mr341823066b.35.1778156864692;
        Thu, 07 May 2026 05:27:44 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:44 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 01/11] ceph: convert inode flags to named bit positions and atomic bitops
Date: Thu,  7 May 2026 12:27:27 +0000
Message-Id: <20260507122737.2804094-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507122737.2804094-1-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define named bit-position constants for all CEPH_I_* inode flags and
derive the bitmask values from them.  This gives every flag a named
_BIT constant usable with the test_bit/set_bit/clear_bit family.
The intentionally unused bit position 1 is documented inline.

Convert all flag modifications to use atomic bitops (set_bit,
clear_bit, test_and_clear_bit).  The previous code mixed lockless
atomic ops on some flags (ERROR_WRITE, ODIRECT) with non-atomic
read-modify-write (|= / &= ~) on other flags sharing the same
unsigned long.  A concurrent non-atomic RMW can clobber an
adjacent lockless atomic update -- for example, a lockless
clear_bit(ERROR_WRITE) could be silently resurrected by a
concurrent ci->i_ceph_flags |= CEPH_I_FLUSH under the spinlock.
Using atomic bitops for all modifications eliminates this class
of race entirely.

Flags whose only users are now the _BIT form (ERROR_WRITE,
ASYNC_CHECK_CAPS) have their old mask defines removed to document
that callers must use the _BIT constant with the set_bit/test_bit
family.  ERROR_FILELOCK and SHUTDOWN retain their mask defines
because they are still used via bitmask tests in lockless readers
(ceph_inode_is_shutdown, reconnect_caps_cb).

The direct assignment in ceph_finish_async_create() is converted
from i_ceph_flags = CEPH_I_ASYNC_CREATE to set_bit().  This
inode is I_NEW at this point -- still invisible to other threads
and guaranteed to have zero flags from alloc_inode -- so either
form is safe, but set_bit() keeps the conversion uniform.

Co-developed-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
Signed-off-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/addr.c       | 20 +++++++-------
 fs/ceph/caps.c       | 24 ++++++++---------
 fs/ceph/file.c       | 13 ++++-----
 fs/ceph/inode.c      |  4 +--
 fs/ceph/locks.c      | 22 ++++-----------
 fs/ceph/mds_client.c |  3 ++-
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/snap.c       |  2 +-
 fs/ceph/super.h      | 64 +++++++++++++++++++++++---------------------
 fs/ceph/xattr.c      |  2 +-
 10 files changed, 74 insertions(+), 82 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 94ffa127b1d3..1859a0c92d66 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2563,7 +2563,8 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_string *pool_ns;
 	s64 pool;
-	int ret, flags;
+	int ret;
+	unsigned long flags;
 
 	/* Only need to do this for regular files */
 	if (!S_ISREG(inode->i_mode))
@@ -2605,20 +2606,19 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 	if (ret < 0)
 		return ret;
 
-	flags = CEPH_I_POOL_PERM;
-	if (ret & POOL_READ)
-		flags |= CEPH_I_POOL_RD;
-	if (ret & POOL_WRITE)
-		flags |= CEPH_I_POOL_WR;
-
 	spin_lock(&ci->i_ceph_lock);
 	if (pool == ci->i_layout.pool_id &&
 	    pool_ns == rcu_dereference_raw(ci->i_layout.pool_ns)) {
-		ci->i_ceph_flags |= flags;
-        } else {
+		set_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
+		if (ret & POOL_READ)
+			set_bit(CEPH_I_POOL_RD_BIT, &ci->i_ceph_flags);
+		if (ret & POOL_WRITE)
+			set_bit(CEPH_I_POOL_WR_BIT, &ci->i_ceph_flags);
+	} else {
 		pool = ci->i_layout.pool_id;
-		flags = ci->i_ceph_flags;
 	}
+	/* Re-read flags under the lock so check: sees the updated bits. */
+	flags = ci->i_ceph_flags;
 	spin_unlock(&ci->i_ceph_lock);
 	goto check;
 }
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..cb9e78b713d9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -549,7 +549,7 @@ static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 
 	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	spin_lock(&mdsc->cap_delay_lock);
-	ci->i_ceph_flags |= CEPH_I_FLUSH;
+	set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
 	if (!list_empty(&ci->i_cap_delay_list))
 		list_del_init(&ci->i_cap_delay_list);
 	list_add(&ci->i_cap_delay_list, &mdsc->cap_delay_list);
@@ -1409,7 +1409,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	      ceph_cap_string(revoking));
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
-	ci->i_ceph_flags &= ~CEPH_I_FLUSH;
+	clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
 
 	cap->issued &= retain;  /* drop bits we don't want */
 	/*
@@ -1666,7 +1666,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		last_tid = capsnap->cap_flush.tid;
 	}
 
-	ci->i_ceph_flags &= ~CEPH_I_FLUSH_SNAPS;
+	clear_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
 
 	while (first_tid <= last_tid) {
 		struct ceph_cap *cap = ci->i_auth_cap;
@@ -2026,7 +2026,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
-		ci->i_ceph_flags |= CEPH_I_ASYNC_CHECK_CAPS;
+		set_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT, &ci->i_ceph_flags);
 
 		/* Don't send messages until we get async create reply */
 		spin_unlock(&ci->i_ceph_lock);
@@ -2577,7 +2577,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE)
 		return;
 
-	ci->i_ceph_flags &= ~CEPH_I_KICK_FLUSH;
+	clear_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
 
 	list_for_each_entry_reverse(cf, &ci->i_cap_flush_list, i_list) {
 		if (cf->is_capsnap) {
@@ -2686,7 +2686,7 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_client *mdsc,
 			__kick_flushing_caps(mdsc, session, ci,
 					     oldest_flush_tid);
 		} else {
-			ci->i_ceph_flags |= CEPH_I_KICK_FLUSH;
+			set_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
 		}
 
 		spin_unlock(&ci->i_ceph_lock);
@@ -2829,7 +2829,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	spin_lock(&ci->i_ceph_lock);
 
 	if ((flags & CHECK_FILELOCK) &&
-	    (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK)) {
+	    test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
 		doutc(cl, "%p %llx.%llx error filelock\n", inode,
 		      ceph_vinop(inode));
 		ret = -EIO;
@@ -3207,7 +3207,7 @@ static int ceph_try_drop_cap_snap(struct ceph_inode_info *ci,
 		BUG_ON(capsnap->cap_flush.tid > 0);
 		ceph_put_snap_context(capsnap->context);
 		if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
-			ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
+			set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
 
 		list_del(&capsnap->ci_item);
 		ceph_put_cap_snap(capsnap);
@@ -3396,7 +3396,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				if (ceph_try_drop_cap_snap(ci, capsnap)) {
 					put++;
 				} else {
-					ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
+					set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
 					flush_snaps = true;
 				}
 			}
@@ -3648,7 +3648,7 @@ static void handle_cap_grant(struct inode *inode,
 
 		if (ci->i_layout.pool_id != old_pool ||
 		    extra_info->pool_ns != old_ns)
-			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
+			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
 
 		extra_info->pool_ns = old_ns;
 
@@ -4815,7 +4815,7 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
 			doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			spin_lock(&mdsc->cap_delay_lock);
-			ci->i_ceph_flags |= CEPH_I_FLUSH;
+			set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
 			if (!list_empty(&ci->i_cap_delay_list))
 				list_del_init(&ci->i_cap_delay_list);
 			list_add_tail(&ci->i_cap_delay_list,
@@ -5080,7 +5080,7 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 
 		if (atomic_read(&ci->i_filelock_ref) > 0) {
 			/* make further file lock syscall return -EIO */
-			ci->i_ceph_flags |= CEPH_I_ERROR_FILELOCK;
+			set_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
 			pr_warn_ratelimited_client(cl,
 				" dropping file locks for %p %llx.%llx\n",
 				inode, ceph_vinop(inode));
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d54d71669176..7ca9f60fb0e5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -598,12 +598,12 @@ static void wake_async_create_waiters(struct inode *inode,
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
-		clear_and_wake_up_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
+		/* Serialized by i_ceph_lock; the two ops touch different bits. */
+		clear_and_wake_up_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
 
-		if (ci->i_ceph_flags & CEPH_I_ASYNC_CHECK_CAPS) {
-			ci->i_ceph_flags &= ~CEPH_I_ASYNC_CHECK_CAPS;
+		if (test_and_clear_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT,
+				      &ci->i_ceph_flags))
 			check_cap = true;
-		}
 	}
 	ceph_kick_flushing_inode_caps(session, ci);
 	spin_unlock(&ci->i_ceph_lock);
@@ -766,7 +766,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			 * that point and don't worry about setting
 			 * CEPH_I_ASYNC_CREATE.
 			 */
-			ceph_inode(inode)->i_ceph_flags = CEPH_I_ASYNC_CREATE;
+			set_bit(CEPH_I_ASYNC_CREATE_BIT,
+				&ceph_inode(inode)->i_ceph_flags);
 			unlock_new_inode(inode);
 		}
 		if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
@@ -2482,7 +2483,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
 	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
-	    (ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
+	    test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		struct ceph_snap_context *snapc;
 		struct iov_iter data;
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 22c7da1ea61c..4871d7ab2730 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1180,7 +1180,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		rcu_assign_pointer(ci->i_layout.pool_ns, pool_ns);
 
 		if (ci->i_layout.pool_id != old_pool || pool_ns != old_ns)
-			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
+			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
 
 		pool_ns = old_ns;
 
@@ -3240,7 +3240,7 @@ void ceph_inode_shutdown(struct inode *inode)
 	bool invalidate = false;
 
 	spin_lock(&ci->i_ceph_lock);
-	ci->i_ceph_flags |= CEPH_I_SHUTDOWN;
+	set_bit(CEPH_I_SHUTDOWN_BIT, &ci->i_ceph_flags);
 	p = rb_first(&ci->i_caps);
 	while (p) {
 		struct ceph_cap *cap = rb_entry(p, struct ceph_cap, ci_node);
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index dd764f9c64b9..c4ff2266bb94 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -57,9 +57,7 @@ static void ceph_fl_release_lock(struct file_lock *fl)
 	ci = ceph_inode(inode);
 	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
 		/* clear error when all locks are released */
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_FILELOCK;
-		spin_unlock(&ci->i_ceph_lock);
+		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
 	}
 	fl->fl_u.ceph.inode = NULL;
 	iput(inode);
@@ -271,15 +269,10 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	else if (IS_SETLKW(cmd))
 		wait = 1;
 
-	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
-		err = -EIO;
-	}
-	spin_unlock(&ci->i_ceph_lock);
-	if (err < 0) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
 			posix_lock_file(file, fl, NULL);
-		return err;
+		return -EIO;
 	}
 
 	if (lock_is_read(fl))
@@ -331,15 +324,10 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
 
-	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
-		err = -EIO;
-	}
-	spin_unlock(&ci->i_ceph_lock);
-	if (err < 0) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
 		if (lock_is_unlock(fl))
 			locks_lock_file_wait(file, fl);
-		return err;
+		return -EIO;
 	}
 
 	if (IS_SETLKW(cmd))
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705..53f1012a9e7d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3657,7 +3657,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
-		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds != cap->mds) {
+		if (test_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
+		    mds != cap->mds) {
 			doutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4e6c87f8414c..d873e784b025 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -670,7 +670,7 @@ static inline int ceph_wait_on_async_create(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
-	return wait_on_bit(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT,
+	return wait_on_bit(&ci->i_ceph_flags, CEPH_I_ASYNC_CREATE_BIT,
 			   TASK_KILLABLE);
 }
 
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 52b4c2684f92..9b79a5eaca93 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -700,7 +700,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 		return 0;
 	}
 
-	ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
+	set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
 	doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu\n",
 	      inode, ceph_vinop(inode), capsnap, capsnap->context,
 	      capsnap->context->seq, ceph_cap_string(capsnap->dirty),
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index afc89ce91804..cb45a59dbb19 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -665,23 +665,34 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 /*
  * Ceph inode.
  */
-#define CEPH_I_DIR_ORDERED	(1 << 0)  /* dentries in dir are ordered */
-#define CEPH_I_FLUSH		(1 << 2)  /* do not delay flush of dirty metadata */
-#define CEPH_I_POOL_PERM	(1 << 3)  /* pool rd/wr bits are valid */
-#define CEPH_I_POOL_RD		(1 << 4)  /* can read from pool */
-#define CEPH_I_POOL_WR		(1 << 5)  /* can write to pool */
-#define CEPH_I_SEC_INITED	(1 << 6)  /* security initialized */
-#define CEPH_I_KICK_FLUSH	(1 << 7)  /* kick flushing caps */
-#define CEPH_I_FLUSH_SNAPS	(1 << 8)  /* need flush snapss */
-#define CEPH_I_ERROR_WRITE	(1 << 9) /* have seen write errors */
-#define CEPH_I_ERROR_FILELOCK	(1 << 10) /* have seen file lock errors */
-#define CEPH_I_ODIRECT_BIT	(11) /* inode in direct I/O mode */
-#define CEPH_I_ODIRECT		(1 << CEPH_I_ODIRECT_BIT)
-#define CEPH_ASYNC_CREATE_BIT	(12)	  /* async create in flight for this */
-#define CEPH_I_ASYNC_CREATE	(1 << CEPH_ASYNC_CREATE_BIT)
-#define CEPH_I_SHUTDOWN		(1 << 13) /* inode is no longer usable */
-#define CEPH_I_ASYNC_CHECK_CAPS	(1 << 14) /* check caps immediately after async
-					     creating finishes */
+#define CEPH_I_DIR_ORDERED_BIT		(0)  /* dentries in dir are ordered */
+					     /* bit 1 historically unused */
+#define CEPH_I_FLUSH_BIT		(2)  /* do not delay flush of dirty metadata */
+#define CEPH_I_POOL_PERM_BIT		(3)  /* pool rd/wr bits are valid */
+#define CEPH_I_POOL_RD_BIT		(4)  /* can read from pool */
+#define CEPH_I_POOL_WR_BIT		(5)  /* can write to pool */
+#define CEPH_I_SEC_INITED_BIT		(6)  /* security initialized */
+#define CEPH_I_KICK_FLUSH_BIT		(7)  /* kick flushing caps */
+#define CEPH_I_FLUSH_SNAPS_BIT		(8)  /* need flush snaps */
+#define CEPH_I_ERROR_WRITE_BIT		(9)  /* have seen write errors */
+#define CEPH_I_ERROR_FILELOCK_BIT	(10) /* have seen file lock errors */
+#define CEPH_I_ODIRECT_BIT		(11) /* inode in direct I/O mode */
+#define CEPH_I_ASYNC_CREATE_BIT		(12) /* async create in flight for this */
+#define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
+#define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creating finishes */
+
+#define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
+#define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
+#define CEPH_I_POOL_PERM		(1 << CEPH_I_POOL_PERM_BIT)
+#define CEPH_I_POOL_RD			(1 << CEPH_I_POOL_RD_BIT)
+#define CEPH_I_POOL_WR			(1 << CEPH_I_POOL_WR_BIT)
+#define CEPH_I_SEC_INITED		(1 << CEPH_I_SEC_INITED_BIT)
+#define CEPH_I_KICK_FLUSH		(1 << CEPH_I_KICK_FLUSH_BIT)
+#define CEPH_I_FLUSH_SNAPS		(1 << CEPH_I_FLUSH_SNAPS_BIT)
+#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
+#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
+#define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
+#define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
 
 /*
  * Masks of ceph inode work.
@@ -694,27 +705,18 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 
 /*
  * We set the ERROR_WRITE bit when we start seeing write errors on an inode
- * and then clear it when they start succeeding. Note that we do a lockless
- * check first, and only take the lock if it looks like it needs to be changed.
- * The write submission code just takes this as a hint, so we're not too
- * worried if a few slip through in either direction.
+ * and then clear it when they start succeeding. The write submission code
+ * just takes this as a hint, so we're not too worried if a few slip through
+ * in either direction.
  */
 static inline void ceph_set_error_write(struct ceph_inode_info *ci)
 {
-	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags |= CEPH_I_ERROR_WRITE;
-		spin_unlock(&ci->i_ceph_lock);
-	}
+	set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 }
 
 static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
 {
-	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_WRITE;
-		spin_unlock(&ci->i_ceph_lock);
-	}
+	clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 }
 
 static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index e773be07f767..860fc8e1867d 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1054,7 +1054,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	if (current->journal_info &&
 	    !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN) &&
 	    security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN))
-		ci->i_ceph_flags |= CEPH_I_SEC_INITED;
+		set_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags);
 out:
 	spin_unlock(&ci->i_ceph_lock);
 	return err;
-- 
2.34.1

