Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72A3C4175
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499702; cv=none; b=gu67pi9L5uQ/P8WxRwm0n8R0NlkOnht4rUF6Hs9x5vXhMsUj/KDOWzBzO1CzTpKwp1cljbmoT/J8Eer1+vxD3ivs0AiIuYWYyEMogIZnbcvnKF3oP1vkz/fcT49caCBYB3ZxwNZ0IsZGZtTF7xEcq+uFC/Ey5V2ODu5wArXUUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499702; c=relaxed/simple;
	bh=dLmmIlj9N1NiA7Ot724T1FgAL7l92e+3nlMDgR8eGcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKR25yVKAhoXtTHyf32DSzBRCjWBLXGwYfSloXytULFDoFQc7FPuMzej3t1jycojA6ZQ5qbaW9tOhqjTb7XeLR5lwv/ZACTJ1lM0N1OilzHgKij0mEcxzEITUJ21QFxFMVY5sOlJ/Ab5XGKITowq61+FFOa9SmrXD/NvPiBkTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WFwtQ9cV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WFwtQ9cV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4728c12ba97so231719f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jul 2026 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783499697; x=1784104497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJVaNu/kRhXEiG33uhV6T2P8pqMXFDgQie3+CcB+PTI=;
        b=WFwtQ9cV/91dae4WZ/R9QmFQvKSNtStR3YOhJDzjSCNzD4B3CeFZfZpE7Uj878zNpH
         X2E2bxbUT6Mfo9/LuV93U7gsOFDJHDH6b2GWkYhIa9L8Sh/8aUxUQh3Hrer2fZmlGrp2
         BJxkGiya1iWj5GEToZJ0Rg3CTD02mkBw+X36ZaFvMME62wF4YPHec6PFQbV6OhnAS2CG
         kDbTfP/YczjIQPfnqso0SoXgfrkdHwF+fCD/fzaEif/UJnofqIRC97qMwvPqmSxWgxAl
         4Lh63wrCNwoY5qAQUsS9AmLv5LEN/XqH2ZPL14CC5sOVgNJSwiVOevLn8W8QultDXIqe
         YlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499697; x=1784104497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJVaNu/kRhXEiG33uhV6T2P8pqMXFDgQie3+CcB+PTI=;
        b=nzI0I7KgZTS+E5ugHYHPZ1SwRLwElnvMBFqrE0LktdrjJ7DhVH+r3GvFjKEwGonq1H
         YHQKbVjSxMNlVVa2l8y9MdF8JVGi+X5biAa+ibinPVUGHhli/SsAuqJF/bRQDN4dQK4+
         2RikGB2JIZo/5W02BIMblWV1JwgaNGrVcY4EApr8CFy4lnM4Vm1MNFEWZtUZW7Ay1X5m
         oSaq9+lev2wH9An5/9sMVyVOA+/FAOdKy2LOzM883l8ffKaiXVY9miYfHOGP1/41+sRY
         jwyD8GLAUtjWWOiqCMbJh2AD4pqIijQWGlQHOICYxIU6ZBFFnTnOMtygTMOnB1FHwAdn
         Zmlg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ccHLZG4ABzsW82ba1Wgi7umxLxIBziI+2Fro6I7qNRzxo0hiKhW4cUtW5br1d1NVgCnNXU9yMETj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wztCcuJZCGduOSA/Fk8okBGnGyMVqWCFKwAz1hG4ywjCdaPi
	bo+vFR+1l/0J4A0mICMMDa/gO1Lr51NGlx7RgOkBndaTO7KDJ+NTXMOJu1WYTWfCShc=
X-Gm-Gg: AfdE7cleBhWZrtDSRbGoYbn9ANoL8Eo/aPPckd2vRJEqUogRpSBS0cEHiTu2vFnwYLu
	6n1zhNce5nNjP0RK4kXCffcyzlRNaCPW6TitxPAoSx8Y1zQg5oSrIhoZPErXNdWxBpEwe52oZol
	WTgNIWC7cBpPtnAQuoq9Zm159rH6dhRO3p+NkuW9xwAPG+q5V2tvF0pRcr8wmDXwReg85m2HCJJ
	Vb83HKKrt/ioe9tHDZQMUfdmXrvXhzPNW3w+id+k+54mWg0q1o06sBAZzjdN+pCOINbgXY5l+Zv
	K2w7a7EWRMrt5KaXBOIArIaghfVa1/bfiyg5fuol6bv22W4t6wjjrrxF1bThg6YAAKOywuoPeaK
	tFJmJYUO0/YuV4gddt62y/uyoTt7AhWqhhFGVCTq4Y5RMuvhWwGQVZNeGLifXEdYcqYYVhwgnWM
	Eo+ezDNRU6CjWFTqcmrQQF2he+eoj7DbapZ/7jsmaoSfOJMr0hgNh5Ken+qYSo1STRqIN3eIq/r
	l0GMUeTGocZqLOO
X-Received: by 2002:a5d:59c9:0:b0:479:190:5873 with SMTP id ffacd0b85a97d-47df0787185mr1481796f8f.49.1783499697385;
        Wed, 08 Jul 2026 01:34:57 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae4fsm42019951f8f.18.2026.07.08.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:34:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/super: document struct ceph_dentry_info and its flags
Date: Wed,  8 Jul 2026 10:34:55 +0200
Message-ID: <20260708083455.78487-1-max.kellermann@ionos.com>
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
 fs/ceph/super.h | 122 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..82d81b35a2eb 100644
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
+	 * in lease RENEW/REVOKE messages.
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
+ * when a dentry already queued on the shrink list is touched again, so
+ * the shrinker spares it for another round instead of disposing of it
+ * (a clock/LRU-style approximation).
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

