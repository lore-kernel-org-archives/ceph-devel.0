Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FB3FB075
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467147; cv=none; b=gDnLgfe4dDb9ppDiseywg6l6h9KMc1R+NoRphzXesmqIKY42EH4+9TKW5urpVpykQTgp89c5rSa2ozeMumPRhn8PoyKsjxMVj1b0Kzw/0NYWPFCKAZyAbwXTsHGp0Lm6LfwMCJ3qhKPWTtj2k38xE+z5tdNhiQi0n1nHQtWD1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467147; c=relaxed/simple;
	bh=bQZvJHvY7h8CiLeg0LuJ3PDTucKruNwf0pSG4a0QHAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScrPpoS/iPlWbKMCc9/u4AuLY4bdBHi12+vzGGGufMEEilK6CdfDNgYE+o2QXRLCFhTy1snHUb+gImZtgsFttK7T5jzFLk7sjZVTluq4INm6s3ZnyTZbML9j7Q9btGvwJm33tQYb0ho+fXSKDva/5pciIaXKwjzvccsgzpyXNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkcaPgfU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s8bmW+dP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkcaPgfU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s8bmW+dP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXLUrx6pg+td5LUoEiI8ndSrVAlCTiqcgH/61RABzys=;
	b=OkcaPgfUcEsazHGSD8iEdYROywCZKmLc4toF9BSpwmPjGdH2WgfQowJD6ZKU/ELzV/nVUi
	2ZwYAgAyE9LMj8hFOoGBunYXiaN0yyKdGg02gM/Vo7dPe13o8s0lgptfuA+YTRmC3ayrTw
	OZP0feNYdIkJxzUuS2gacoD3yoSRuBM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-IYAySkq7Ogi4FFlRkb1Ffw-1; Wed, 29 Apr 2026 08:52:18 -0400
X-MC-Unique: IYAySkq7Ogi4FFlRkb1Ffw-1
X-Mimecast-MFC-AGG-ID: IYAySkq7Ogi4FFlRkb1Ffw_1777467137
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-678aad8ed0fso5426650a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467137; x=1778071937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXLUrx6pg+td5LUoEiI8ndSrVAlCTiqcgH/61RABzys=;
        b=s8bmW+dPb8EacpZJIUK1JpOTxQDH9LhDM5lJdxOQ6eZKTlJFtiPixrJsARCnf0PoMv
         YgURvuqgKJIGi3laDTUkm/lFgObg1r4HGoDEqpJdr6nC3tYnaqMWpmwBFW6mkllNKv8P
         AZgnlBIld95n9M2NWgA6dL/Bxoi9vpAb/UCcuiyrxk5WLHn0n1cwr+181MMew8R6PUxx
         m2x5+VXDxAOqHEGkZSh7eXazAiVFA0u/Wk0QV5MKBJD0xqoNGddzxrB0GSf08KlMhEuD
         nqTpV4INs0gvMyRV5W9rzMu1FUwnReapF9e8TNPdpniDUNhz00C0VvkBfG+79nOEijQt
         ppGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467137; x=1778071937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wXLUrx6pg+td5LUoEiI8ndSrVAlCTiqcgH/61RABzys=;
        b=NzDujI0Dhokyu0rrXGa2Tu9bK3RnElijIVEyyr+1gKWMb+3Q//cZisiyfo91o38twz
         AIAqaGwDDDHniA8RbGmanSnELnii2+Ds8invf3NBgJ8d6OLJF9IyUqtqBvdsGk5oH6mI
         69wwHiHruQ0VYkO4trCXQeYRPB9u33/6Fp+qwFyRoEwAUomq/H1ioDK1gq4Yqv3wt3C/
         7peprjhGVfoEiy+g6JU0jRQv6VE5yy+mIcSsAllXxMLzytI61ErrKJBRUZdm0AUZyPb3
         V79KE47KE365if6NY4xLp8rXCpft6egA83ip4ucJMcmitvKMuRODz7ZgHtrX+k7LHplP
         /y+w==
X-Gm-Message-State: AOJu0YxZGyWnf0XlbK2H6fwDezA63e1K2nDGqsshUmgunaPJgBGL53iT
	b1hlBhdfuRIekoYBWDEwUJ0m74zEHj5uopAXzkPIu7oaizkXMJpdm8l6rTDQFNptTgFIhbHosen
	iFduBwfCwZAFTkjXEUGxEtUtGAJFJTOI97gSoxL4BuVaiqDFKV26zaTv+mgkGuroBGpD2TqWkME
	tQnYohU3KBSCEKtJTojlnqxwknMGYP7hbhVlllR+qSOk0cFP5znA==
X-Gm-Gg: AeBDieusSktMI4ZHMP1a88A4p9PLe0PdzVWRPMlsaLB+rJw+UqtC0ZSrgUQoMUo10dI
	yAZeqZSN7IWPjPNoGvSXEqkZ//0PiDOpwRLHBWFwgzljR0ax8qjVXLiw6yMNbbXPcfwGE8vi0k1
	FMXMsJTEXbtXOwPwChFVeoEIhE7DPYF6+n4sjm6nt1rJEVJB35Xk61ZlkXIy9/Qn0HUXMVfuE1g
	SachvolSODDNqCKFjUauWylBquRu43DnRQAXUdb9/beWJ9AtQy03TTSb7xzDBrXYi5plevFJX6T
	QwCYgQKVPZc+Ihk3JYeTn5V3RFh3pYrxfXtwlHG8TYahjFOt092PZMydE5yzpZfkoqhsxopP1qP
	59FTcaeH2jXAKQYTHwSWQDbsXQ8Leph0Xd8DvUPgnSza/VvjXp7rz1xBZdIkOCNkmeA==
X-Received: by 2002:a05:6402:358a:b0:670:ef2a:217e with SMTP id 4fb4d7f45d1cf-679bafde393mr3845049a12.0.1777467136374;
        Wed, 29 Apr 2026 05:52:16 -0700 (PDT)
X-Received: by 2002:a05:6402:358a:b0:670:ef2a:217e with SMTP id 4fb4d7f45d1cf-679bafde393mr3845020a12.0.1777467135610;
        Wed, 29 Apr 2026 05:52:15 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:15 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 01/11] ceph: convert inode flags to named bit positions and atomic bitops
Date: Wed, 29 Apr 2026 12:51:56 +0000
Message-Id: <20260429125206.1512203-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429125206.1512203-1-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
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

Flag reads under i_ceph_lock continue to use bitmask tests where
the tested flag is only modified under the same lock; this is safe
because the lock serialises both the read and the write.  The
remaining flags continue to use non-atomic bitmask operations under
i_ceph_lock, which is correct and unchanged.

The lockless reader ceph_inode_is_shutdown() retains the READ_ONCE()
snapshot plus bitmask test pattern -- the single atomic load into a
local variable is correct and avoids a second memory access that
test_bit() would require.  It now uses the named CEPH_I_SHUTDOWN
mask constant instead of an inline BIT().

The direct assignment in ceph_finish_async_create() is converted
from i_ceph_flags = CEPH_I_ASYNC_CREATE to set_bit().  This
inode is I_NEW at this point -- still invisible to other threads
and guaranteed to have zero flags from alloc_inode -- so either
form is safe, but set_bit() keeps the conversion uniform.

The only remaining direct assignment (alloc_inode zeroing) operates
on an inode that is not yet visible to other threads, so it is safe
without atomic ops.

The dead precomputed flags variable in ceph_pool_perm_check() is
removed; the check: loop re-reads flags from i_ceph_flags after
the set_bit() calls, keeping a single source of truth.

Co-developed-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
Signed-off-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/addr.c       | 17 ++++++------
 fs/ceph/caps.c       | 24 ++++++++---------
 fs/ceph/file.c       | 13 ++++-----
 fs/ceph/inode.c      |  4 +--
 fs/ceph/locks.c      | 22 ++++-----------
 fs/ceph/mds_client.c |  3 ++-
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/snap.c       |  2 +-
 fs/ceph/super.h      | 64 +++++++++++++++++++++++---------------------
 fs/ceph/xattr.c      |  2 +-
 10 files changed, 72 insertions(+), 81 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2090fc78529c..35c5fdb5a448 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2583,20 +2583,19 @@ int ceph_pool_perm_check(struct inode *inode, int need)
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
index 5e7c73a29aa3..e2622f1cfbff 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -579,12 +579,12 @@ static void wake_async_create_waiters(struct inode *inode,
 
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
@@ -747,7 +747,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			 * that point and don't worry about setting
 			 * CEPH_I_ASYNC_CREATE.
 			 */
-			ceph_inode(inode)->i_ceph_flags = CEPH_I_ASYNC_CREATE;
+			set_bit(CEPH_I_ASYNC_CREATE_BIT,
+				&ceph_inode(inode)->i_ceph_flags);
 			unlock_new_inode(inode);
 		}
 		if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
@@ -2422,7 +2423,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
 	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
-	    (ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
+	    test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		struct ceph_snap_context *snapc;
 		struct iov_iter data;
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d99e12d1100b..f75d66760d54 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1142,7 +1142,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		rcu_assign_pointer(ci->i_layout.pool_ns, pool_ns);
 
 		if (ci->i_layout.pool_id != old_pool || pool_ns != old_ns)
-			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
+			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
 
 		pool_ns = old_ns;
 
@@ -3199,7 +3199,7 @@ void ceph_inode_shutdown(struct inode *inode)
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
index b1746273f186..ccf0d53dde2b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3613,7 +3613,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
-		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds != cap->mds) {
+		if (test_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
+		    mds != cap->mds) {
 			doutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0428a5eaf28c..e91a199d56fd 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -658,7 +658,7 @@ static inline int ceph_wait_on_async_create(struct inode *inode)
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
index 29a980e22dc2..66b047606d65 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -655,23 +655,34 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
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
+#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
+#define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
+#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
+#define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
 
 /*
  * Masks of ceph inode work.
@@ -684,27 +695,18 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 
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
index 5f87f62091a1..7cf9e908c2fe 100644
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

