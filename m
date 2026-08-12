Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC484370D7B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567768; cv=none; b=dex/sKRvhjg9P/0HovJgLZO8OGPDY5KPAQ378ftxLxQstsq6/ZAhmCVJ/RKokh3B9k0AHALS52jnpu55c+G2WGpgTq5rc7yr7RNgHylPvX9wSov+PjXwWf/7FD58TUOdyNtLJ/IgUDjzQI4BJ7YFmTQ03ZAKc7Fg4wuNjgUOfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567768; c=relaxed/simple;
	bh=S2/IKQBe3BZ2BJZDm8nE1WDqx5CW6h0/h3hRPhM6Tnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeyOPVJkjR43Ts1Ctj/stg9j3VMBIXMb0U4rfjp/b4Kvj7J44I1D/GYcVFwnEhildj56DITr1Y4jBQBE0KiDXhZHJ/MubwovkzHGmb8JCfQWDB+qlRasnNZEaQeg0s1PpeW4+YhBVNptdmc+S8T0PpuFfLuMsw8psMK4kn8+V4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZI9KpFbj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZI9KpFbj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956242332dso12634055e9.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786567764; x=1787172564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Bl0riAnOz4MDPzNl0/YTiH6hc1BXf4s2D9tpakXXVs=;
        b=ZI9KpFbjd54rjBp4TDVw1bS55FJhsjNLS/4OHPzDswqT/uW4/knmamWFB4OfyXqRIw
         hrhzqWNKdDScgW7SG6Sm2Cx+FGRGk7oM/+zoU8fCwrYqR/g+kMt4cE/skME9rQ+mhDxl
         tiiN+7AFffqUcBFsjQ5Xa935vIx4NgUC/sfEI7iNMdSOM84XaNRP4x+BEV7uHIm3pIwo
         D7aLZpklT1g8XNs8Oq2TwshfBFbal2k5VDpMqPwagrvXMwTyVd9JGfU7hT3h6tCN6OyM
         ekEfVvTeOpeLA7sq3kY7bNqOrfM4UCQjdpoj+WCLScSND4Whf8X/+DxdVuyfWdlfWTJ5
         geCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567764; x=1787172564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Bl0riAnOz4MDPzNl0/YTiH6hc1BXf4s2D9tpakXXVs=;
        b=aGX0kaDcCEQzpGrA5uICGa/q8pFhLED4VKdxHkLEhe1RQVs73m3oSB/2Gm6YTtZ9je
         3gy7rX/lRI8MRUZsUeXPYYU9GOYIJ+QzNgWGlpJt/gdx3tJ+lpqQZT+5lF1r581wtm0a
         VfZOj+9dvMtcNcFsJly6eTq1+Ao9Dt1NltxmIx3hcpGTYT7bBKKUt7miPSnp+W4oViIC
         RmfM9jOQaGu6c1dukmRZB7mDMFlXWre4Cv3kLweVBLjWFyN04aHSedoYZkqnKiN681Gv
         eRSuQKoYm7xLvlhTjhEkWr4GX2vU8y2I91rvwwJUm2eY2o9oIBWZmdcnBL78tWW/woMk
         qlXg==
X-Forwarded-Encrypted: i=1; AHgh+RoqXPlx0fhRV2mukg3HkRD5iBP7Kzzdkt644oLs1jzAyJxgcNm92auPPIq2BU0rdkbIf2FFc0OX2wBv@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXcsREUdLoKOze7BAVn9CMWJHRxn+DthQecmnG62LFjcN+NgT
	d1at2E2jw8uk3kefCXDjvmrCFKqPWbbFroVaKgt69Li/ekeAKL/AHR8pvi7d5m/IU9w=
X-Gm-Gg: AR+sD113fRpd3QFNMc8hmT2m6nZASQzCHmRHDjQLg2QaQbWzn2YsRifm9YFdfpEOOVa
	iL8SAJS4DwhDNpsV6cGbWGNjAgY72SyC+Ge9naYXte8lL9AToUYYghIJfMi8HaU8W4/OOxQejvL
	yxqXSD2xzzD0OwjOf8LMv2XjrpsWcK6/B2GDi5ZVzdu4+v88lOSM0uO8XmsJXo9mWg6Cm5Gbb3f
	amOBPsulgTTz6+EgcydMge+J9Msby6nJhOSwqSrAQPjATsvq9jtOc03Si2UNTpGnzH+JeHvzJap
	3yKeUtddguOaTRoVy87bdSo8QvKTWLjsgpl8+4mmMGEGDCmEf7lSRks4m8GCHd/vHETB2a1fCol
	RrSF9k1JdMWYspcbdyEMkYhkMvkgDc1VYzsuAnckwqcXvOYMWYV1ogbaR606sKnJ4hz5bm+hNMd
	cIeVjqkCz57ojBYw1FdtXEitS0j1mpQQcnxNQwx65bIEE6vxJ0MkiFzyepx91/ARGoIt5eek5cL
	KpqWNNraLCwzh2lb1mz7zIAIgf3QnUYoNRyeJLx9EicCnZhO+nPnGsBVOfelfmtnSFGwcl3rfs=
X-Received: by 2002:a05:600c:8010:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-499821d2047mr3066305e9.14.1786567763997;
        Wed, 12 Aug 2026 13:49:23 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981d85953sm7766555e9.0.2026.08.12.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:49:23 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] fs/ceph/super: document struct ceph_dentry_info and its flags
Date: Wed, 12 Aug 2026 22:49:20 +0200
Message-ID: <20260812204920.1805545-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: two corrections
---
 fs/ceph/super.h | 122 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..169a440e984f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -326,29 +326,145 @@ struct ceph_inode_xattr {
 	int should_free_val;
 };
 
-/*
- * Ceph dentry state
+/**
+ * Ceph-specific dentry data (for `dentry.d_fsdata`).  Call
+ * ceph_dentry() to obtain the #ceph_dentry_info pointer from a
+ * #dentry.
  */
 struct ceph_dentry_info {
+	/**
+	 * A pointer back to the #dentry owning this object.
+	 */
 	struct dentry *dentry;
+
+	/**
+	 * The #ceph_mds_session that issued the lease; holds a
+	 * reference that must be freed with ceph_put_mds_session().
+	 * May be NULL.
+	 */
 	struct ceph_mds_session *lease_session;
+
+	/**
+	 * List hook; depending on the flags, it may be in
+	 * ceph_mds_client.dentry_leases,
+	 * ceph_mds_client.dentry_dir_leases or in
+	 * __dentry_leases_walk().dispose (or in no list at all if
+	 * this #list_head is empty).
+	 */
 	struct list_head lease_list;
+
+	/**
+	 * Hook for `ceph_fs_client.async_unlink_conflict`, protected
+	 * by `ceph_fs_client.async_unlink_conflict_lock`.
+	 */
 	struct hlist_node hnode;
+
+	/**
+	 * Bit mask of CEPH_DENTRY_*
+	 */
 	unsigned long flags;
+
+	/**
+	 * Snapshot of the parent directory's
+	 * `ceph_inode_info.i_shared_gen` taken when this dentry was
+	 * last validated against the directory lease.  When the
+	 * directory's `i_shared_gen` moves on, all cached dentries
+	 * below it (including this one's #offset) are stale.
+	 */
 	int lease_shared_gen;
+
+	/**
+	 * Snapshot of the issuing `ceph_mds_session.s_cap_gen` taken
+	 * when the (single-dentry) lease was granted.  The lease is
+	 * only valid while this matches the session's current
+	 * generation; a session reconnect bumps `s_cap_gen` and thus
+	 * invalidates all of its leases.  Zero means "no valid
+	 * lease".
+	 */
 	u32 lease_gen;
+
+	/**
+	 * The lease sequence number as received from the MDS
+	 * (`ceph_mds_reply_lease.seq`).  It is echoed back to the MDS
+	 * in lease RENEW/REVOKE_ACK messages.
+	 */
 	u32 lease_seq;
-	unsigned long lease_renew_after, lease_renew_from;
+
+	/**
+	 * Jiffies timestamp: the earliest time at which a proactive
+	 * lease renewal should be initiated (roughly half the lease
+	 * TTL).  Zero while a renewal is already in flight (see
+	 * #lease_renew_from).
+	 */
+	unsigned long lease_renew_after;
+
+	/**
+	 * Jiffies timestamp recorded when a lease renewal request was
+	 * sent; the new TTL and #lease_renew_after are computed
+	 * relative to it once the reply arrives.  Zero when no
+	 * renewal is pending.
+	 */
+	unsigned long lease_renew_from;
+
+	/**
+	 * Jiffies timestamp whose meaning depends on which lease this
+	 * dentry holds: for a single-dentry lease it is the expiry
+	 * time (TTL); for a directory lease it is when the dir lease
+	 * was last touched (compared against
+	 * `ceph_lease_walk_control.dir_lease_ttl`).
+	 */
 	unsigned long time;
+
+	/**
+	 * This dentry's position (an encoded file position; see
+	 * ceph_make_fpos()) within its parent directory's readdir
+	 * stream, used to preserve readdir ordering when serving
+	 * entries from cached dentries.  Zero if unknown/invalid.
+	 */
 	u64 offset;
 };
 
+/**
+ * Second-chance ("referenced") bit for the dentry-lease shrinker: set
+ * when an already-listed dentry is touched again, so the walker
+ * spares it for another round instead of disposing of it (a
+ * clock/LRU-style approximation).
+ */
 #define CEPH_DENTRY_REFERENCED		(1 << 0)
+
+/**
+ * `ceph_dentry_info.lease_list` is on the
+ * `ceph_mds_client.dentry_leases` list.
+ */
 #define CEPH_DENTRY_LEASE_LIST		(1 << 1)
+
+/**
+ * `ceph_dentry_info.lease_list` is on the
+ * __dentry_leases_walk().dispose list.
+ */
 #define CEPH_DENTRY_SHRINK_LIST		(1 << 2)
+
+/**
+ * This dentry is the primary link to its inode (as opposed to a
+ * remote/hard link).  Reflected from #CEPH_LEASE_PRIMARY_LINK in the
+ * MDS lease mask.
+ */
 #define CEPH_DENTRY_PRIMARY_LINK	(1 << 3)
+
+/**
+ * An asynchronous unlink is in flight for this dentry.  While set,
+ * the dentry is on the `ceph_fs_client.async_unlink_conflict` hash
+ * (via `ceph_dentry_info.hnode`); other operations on a conflicting
+ * name must wait for the bit to clear
+ * (ceph_wait_on_conflict_unlink()).
+ */
 #define CEPH_DENTRY_ASYNC_UNLINK_BIT	(4)
 #define CEPH_DENTRY_ASYNC_UNLINK	(1 << CEPH_DENTRY_ASYNC_UNLINK_BIT)
+
+/**
+ * An asynchronous create is in flight for this dentry; waiters block
+ * on the bit until the create completes.
+ */
 #define CEPH_DENTRY_ASYNC_CREATE_BIT	(5)
 #define CEPH_DENTRY_ASYNC_CREATE	(1 << CEPH_DENTRY_ASYNC_CREATE_BIT)
 
-- 
2.47.3

