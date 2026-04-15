Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E3334C17
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272473; cv=none; b=Jrlyb3dIODFgd4LlSGyUNKFJq4Z0KKIR9wfwqT7Fc+pVMKEgg5nBIYt8/6AWgQtyIrJGrYj87yv37DZERqyk/nK5sIT6exRAoGkQRGJYZsWFHPi10tHWrD7iXT0Wz77tkRidn7q5cXwuaIEtH25iqlZD5A/ckbeHwjmK/2bes9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272473; c=relaxed/simple;
	bh=iPptitDCHY6iUmzXK5v2EJe1oBKCUy+jF+gFF6ntNCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRUfFajOwmKQvlN7O6EAXZTOt1HRFLxU9dzYUYDlg3lpyZMtyROV73n3y7vJoz9ChHiTbT79AST7hy9M9ukYYZhh9dJGzaN818BGoT3+jtz51eRttyEtAxSQk41jYMpQRY66CySv0WQ4+Z8MKiX7TTeXqnO6Ezp1HewpPaMDC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vx4HLXaS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l7cGgARA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vx4HLXaS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l7cGgARA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyX88k/jwVWT5oP8d21qPdRgBVXaGwKPazLNDD9Kmn0=;
	b=Vx4HLXaScOb5Q9+NqWw0wL8fb5xl56BdbAubEJpVwsGeVYnQrHyxRRRcJJzKvmXJHej0kX
	MryBtB53EeHFRgMXrq/GehJbxyDOVYUYuv8pBFnAXtQGvdDzkYzBhMbaO/OTCEWO3qbUaW
	mUd8VJcP0Eo0LsYVPRC91w5TEhEbsa4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-KI2JRztoM9GCviHaMj9MwA-1; Wed, 15 Apr 2026 13:01:04 -0400
X-MC-Unique: KI2JRztoM9GCviHaMj9MwA-1
X-Mimecast-MFC-AGG-ID: KI2JRztoM9GCviHaMj9MwA_1776272464
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-68b313c42e7so7748625eaf.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272463; x=1776877263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyX88k/jwVWT5oP8d21qPdRgBVXaGwKPazLNDD9Kmn0=;
        b=l7cGgARAD/vQwX4X9M3Fl4sAq9VI4qy8WPwgl3WR2wJNYe0+vxynIiws5ot5L3Kk/P
         gtnd1YUcqsXtmqWB0GjYIfdsUemhEUrvD1UqfX7zSybOnKXs7/GoeikDZR69QwVA2j15
         mmcd+pLRSjGyTZzTbcTTtP6zIN3nhMxE2TE1yTEAl9tb8v4kBYV+GOtJ5ooVKHlOQYrI
         nfU9WtKSFLHRgs/y0cpeU/AByE9cQImhUxYQGz5ZlA2zovV84GrhA/XomDrzTFc58mCA
         ukR8ehE614jbUpPZZRIwwxQlXwsFovE7RAXfAOXnOMaJsG8uHW6XN5MJwlJ3TtMhS2PR
         +NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272463; x=1776877263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jyX88k/jwVWT5oP8d21qPdRgBVXaGwKPazLNDD9Kmn0=;
        b=HpXHnk5Cqdw9E3JlKStJdMAxZYMrQY9Wd5FfBoLypD0iDnKNg1ZO1pWmBtNacj1Fw7
         MzjE00Gb10Nb0kHOuaofcxISYMfRcaeG0QGkVT+fegcprHexqSS1sVnAEq1BczY1N3gK
         RFD5ykgl2RMlJxMCADMFVtWLpZUw/+xq5MkGziKlNWP8zJkMet8KpdYOj/A88DdN+8AT
         c+QSaTQ1OpP/Yva9VOcdVT+Vsmq+5/lnclqZy1xS1iRcP7Y67/Rk1lWzuJj5PF1WJfYK
         pr6dKpEWbCEiCosS0/Hu5okiKLGSQjM73xw+3A5dEEU8tbkAL4Z6goPsbhrQ54mZ0xmt
         sqnQ==
X-Gm-Message-State: AOJu0Yz6JhEl6pG6qQspY8nQbGGH5UdPOUVOaE00QrmsW6hz2zFnQ5bv
	KqUwqtje4mA9D8azjuJ1voCIMrZutGLsk+Eh3FqAJ6bzUSVfm8lk/0Zbh8GmC1lmYmaqiHX77Xt
	gTh8sZ93Qu0ubyotoQww45Iqsp5ejU6yjwVX/rcRoVUVtmkc2IsJtmrBu9dAxGqN4Ntk0jlcRic
	+ZymIvA6hAg3txig/5CfEsqG/V/lV1AnRnD+a2M30HzzmKyvGDQw==
X-Gm-Gg: AeBDiesdfGOii2/yVh4T9rJAuju/FjT/Qyn0zZaZu7JrmdzWTAw0d4NEA17zMtPvQhq
	IbT3B+xmaS6SwfVqNDn0AH7+uNcNwPiD336MrCtIjE8tSytNYynsCsY72GLW6QiAZWP/AV7jlrX
	VhwDIIhTpzcia87dj+okQCOsiaMYya2zGXOmUDCoGoAI+muTOsmPxMmIFFIokreEUBdXaUdxZ7D
	LdJqCKu2mKv+WJuE9VI8510fT+4rE4X5FfuhUPSVruaxA5yqQ1ho59dEtvivWZ7K1mTmXMQTIu2
	J1zkcbBEppwabg1hpg+W7vI57BHZw34ZvJHDnccgLsWSjerDu5UgOvkW4VREyELZc+9+1iKeCfG
	tTsMknBk+bGL6YTi/0N2KGIX2B3HCpaqQVnhebUD88Bw0FTX0sxepb5YunGdsuern0Q==
X-Received: by 2002:a05:6820:330d:b0:67f:c06c:a5e6 with SMTP id 006d021491bc7-68be7ee6967mr7305609eaf.37.1776272463106;
        Wed, 15 Apr 2026 10:01:03 -0700 (PDT)
X-Received: by 2002:a05:6820:330d:b0:67f:c06c:a5e6 with SMTP id 006d021491bc7-68be7ee6967mr7305554eaf.37.1776272462033;
        Wed, 15 Apr 2026 10:01:02 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:01:01 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 1/7] ceph: convert inode flags to named bit positions and atomic bitops
Date: Wed, 15 Apr 2026 17:00:37 +0000
Message-Id: <20260415170043.3882912-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170043.3882912-1-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
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
ERROR_FILELOCK, SHUTDOWN, ASYNC_CHECK_CAPS) have their old mask
defines removed to document that callers must use the _BIT
constant with the set_bit/test_bit family.

Flag reads under i_ceph_lock continue to use bitmask tests where
the tested flag is only modified under the same lock; this is safe
because the lock serialises both the read and the write.  The
remaining flags continue to use non-atomic bitmask operations under
i_ceph_lock, which is correct and unchanged.

The lockless reader ceph_inode_is_shutdown() retains the READ_ONCE()
snapshot plus bitmask test pattern -- the single atomic load into a
local variable is correct and avoids a second memory access that
test_bit() would require.

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
 fs/ceph/addr.c       | 16 +++++------
 fs/ceph/caps.c       | 24 ++++++++---------
 fs/ceph/file.c       | 12 ++++-----
 fs/ceph/inode.c      |  4 +--
 fs/ceph/locks.c      | 22 ++++-----------
 fs/ceph/mds_client.c |  3 ++-
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/snap.c       |  2 +-
 fs/ceph/super.h      | 64 ++++++++++++++++++++++----------------------
 fs/ceph/xattr.c      |  2 +-
 10 files changed, 69 insertions(+), 82 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2090fc78529c..bde9efffa228 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2583,20 +2583,18 @@ int ceph_pool_perm_check(struct inode *inode, int need)
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
index 5e7c73a29aa3..2b457dab0837 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -579,12 +579,11 @@ static void wake_async_create_waiters(struct inode *inode,
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
-		clear_and_wake_up_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
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
@@ -747,7 +746,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			 * that point and don't worry about setting
 			 * CEPH_I_ASYNC_CREATE.
 			 */
-			ceph_inode(inode)->i_ceph_flags = CEPH_I_ASYNC_CREATE;
+			set_bit(CEPH_I_ASYNC_CREATE_BIT,
+				&ceph_inode(inode)->i_ceph_flags);
 			unlock_new_inode(inode);
 		}
 		if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
@@ -2422,7 +2422,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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
index 29a980e22dc2..c89ad8dcc969 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -655,23 +655,32 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
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
 
 /*
  * Masks of ceph inode work.
@@ -684,27 +693,18 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 
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
@@ -1142,7 +1142,7 @@ static inline bool ceph_inode_is_shutdown(struct inode *inode)
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int state = READ_ONCE(fsc->mount_state);
 
-	return (flags & CEPH_I_SHUTDOWN) || state >= CEPH_MOUNT_SHUTDOWN;
+	return (flags & BIT(CEPH_I_SHUTDOWN_BIT)) || state >= CEPH_MOUNT_SHUTDOWN;
 }
 
 /* xattr.c */
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

