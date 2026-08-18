Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1603D5648
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078416; cv=none; b=pqhdmDOsEk5tCECh/3iX8ICgx2depxbqAFvs0zLfg/xUM+gi9ueIRRNxyHnGnOS6UIxFLso/Hd5LA+rTedhx6jrZcuFsK1Enj4wLfYdxz6K04skd6rbWQJjYzP90bZljMYE28tNFuW6o2eheuOUWy+azHwIUyVZv5rVrDmMsFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078416; c=relaxed/simple;
	bh=ED77pKgwMIRUAxihtEcQdW9Wo0Fjx6z50kLd5iX4TWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccH1Rk06Tl9oBF9BfJYqeDX0IrgEbaJ9+M+uCVeUaxMHjUb598AIaoJ+XBk9RczRqlCu8oxOGQdyFEdbhBDlptgbWeHEE+D6P2a8HyTEUsNFZYXudSCBiUbRjdoJWJPDkob4KJKkn86xTq5NqrGZSUpQKqHnu2081F5fi5aWyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AA29rSln; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AA29rSln"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so1957155e9.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787078412; x=1787683212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGmscf9XzeR8J+zojLSWMcHzNXJKxt1jiVVJ44gqLmQ=;
        b=AA29rSlnMNTYCwFsciRperEm4zziJlzQ8spnaGwsAJJzUihTEylkejEcpOr+6SREjR
         EJRfYBITiPBOz6jGxUz0y+6vc7vOnCHsBtGzBKg4s4qHRpvYRekA9MAkRegWUePP6CMz
         9y2BzQI8QjkMqI4kJ44I8IcWvQHcMQOY8wNm0++kZkC+SNJK0+qlocEr1ja4Bxybi4r7
         b5z5NE5MED1Jah+5DmSay779tzzXG45Fv5TULFEHuIV8/yA7bLoj6k749aq/ouMY9LXp
         KM0zqc7zuzcxAiGYPEbgBRwd99SygvxucvxylZHhcOxmvIRkY/lrXjZu+rPPfN4+Qq/R
         X+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078412; x=1787683212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGmscf9XzeR8J+zojLSWMcHzNXJKxt1jiVVJ44gqLmQ=;
        b=Xla0ZJiuFX+xlwH/cGBXdqHmTHF7zWwlRRctnKVLh31gohTkaxX8WYKNvHKB2m/EQc
         /2RfNcgwWd464nPknLMmlKJpk+hRD6oL72EsE/cATlYMV6UM+fXowX4cPLl4o2NfLCHK
         jUrwtP7FRQ7gKZIDObyAhVVhTss6UGoEUgMuVdFNS7tlxkZWw2UWissVDKXnvP+slGiJ
         +ENldANrxb39kd2N/nwGQKTpzZGCP2/NTNzTR7toVqK46lewK5tdf+YsJY7fFu07tLex
         vCQBKT0kxb4CGoDfun9tqS6kInTGY0CGUdWTtI9s2KxqyicEO++46E209o2QG8533MbS
         O9rQ==
X-Forwarded-Encrypted: i=1; AHgh+RrffC+DCVwxrK/pTvZUpqsPMRT6sXrnmD4rUdECIRByYLRfJA5jOYdlx220CvwNDrwEU3ZTObSrowPW@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsJoM4UO2OaoxZMyoUMADTWsWoVpRSDgiix1FGpRNcMyYIkyc
	L2YtDCI2G9tCxWtVeoX5c9jzLpUX+JkK96DFTbrLzRLoVWKJEumTNvn+eXiRTGtz+mvXO/iVpGR
	OEsPHIlc=
X-Gm-Gg: AR+sD116N8TBtKd0WyYOYoP9eaWVXvxOuKcVPjXKrWpftFxdPpw13m0MbQRfEFEXC8Y
	u2LqoKCvDxyEi4ZC2MHWGJ+yTdQa2gU8HeGO7gLrIdiJ8pnlEdD80OfVmQtqqOfLXgBlPVmXGzp
	o04QUCyZ2FgpYcxVKarXOvQPgtz/14rN+5JSqdIAFMccpQikVHNTpY1Rea41FA4RcOdm+woRbvi
	PRrc0EbTqaKdpf+q2OfEPQji6aMwBqXiWfvIH1KGN03B8YZ9Mpc7pihGvdrjdulLbJAgFC+gWV8
	KdFQOmaPqujeFLv5/eCCuhsq6R4KU+rt2hwLqxAHU1xvyUAqrdN/ygB1KnTjbrBrKRFE9QoegUW
	cBxf3Hze5V/DckikQ+jcMOXk9JtMx0B3YQ7zYYbVM3Z3yzRil9LTKONE6T7i65LFEsTbar+mpuP
	IBM0I8CFm3sHntVCgmYOqKr6iZtXomwshF0DU4qypZTUb9H6NVjlgIoY7Z/6XK1E6A12MwN9RwG
	ExVdPZeLxKfNWtOivh+TkR86DsQ+VECMLCkVBmLgvLOGsYV9+g4jBaJgW1upV0oHe25uX0coSw=
X-Received: by 2002:a05:600c:1f91:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-499a8fce460mr1137635e9.9.1787078411896;
        Tue, 18 Aug 2026 11:40:11 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm609662595e9.13.2026.08.18.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:40:11 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Tue, 18 Aug 2026 20:40:05 +0200
Message-ID: <20260818184005.3549924-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the MDS revokes capabilities, handle_cap_grant() normally
guarantees a response by setting `CHECK_CAPS_FLUSH_FORCE` (see
commit 31634d7597d8 ("ceph: force sending a cap update msg back to MDS
for revoke op")), so ceph_check_caps() sends a cap message even if the
client would otherwise decide it has nothing to do.  That guarantee is
skipped whenever the revoke has to be deferred (via revoke_wait):
revoking Fb while dirty data is still buffered (writeback is queued
first) or revoking Fc while pages are cached (async invalidation is
queued first).

In those cases, the ack is left to the deferred completion
(ceph_put_wrbuffer_cap_refs() after writeback, or the invalidate
worker after invalidation); both of which call ceph_check_caps(ci,0)
i.e.  without `CHECK_CAPS_FLUSH_FORCE`.  Nothing gets sent under one
of the following conditions:

- the inode is retaining caps because the file was used recently
  (file_wanted != 0; retain |= CEPH_CAP_ANY)

- the revoked cap is still used because the page was re-cached (e.g. a
  file being re-read)

- the MDS has meanwhile re-granted, so `issued==implemented` and the
  client sees nothing being revoked

The client then never emits the cap message which the MDS is waiting
for.  The MDS blocks on the revoke indefinitely and logs, for minutes
or hours:

  client.NNN isn't responding to mclientcaps(revoke), ino 0x... pending
  pAsxLsXsxFsxcrwb issued pAsxLsXsxFsxcrwb, sent 964.899182 seconds ago

The client-side state at that point shows the full cap set still
issued, nothing in the revoking/flushing sets.  Thus nothing gets
sent.

This patch fixes it by remembering that a forced response is expected.
When a revoke is deferred, set `CEPH_I_FLUSH_FORCE` on the inode.
ceph_check_caps() replays it as `CHECK_CAPS_FLUSH_FORCE`, so whichever
path re-checks the inode next (the writeback/invalidate completion,
the delayed worker, or any other caller) is guaranteed to send a cap
message to the MDS.  __prep_cap() clears the flag once a message is
actually built.

This is the deferred-path counterpart of the existing
`CHECK_CAPS_FLUSH_FORCE` handling; a normal (non-deferred) revoke
still forces the response inline as before.

Cc: stable@vger.kernel.org
Fixes: 31634d7597d8 ("ceph: force sending a cap update msg back to MDS for revoke op")
Fixes: 257e6172ab36 ("ceph: don't let check_caps skip sending responses for revoke msgs")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: fix CEPH_I_FLUSH_FORCE/CEPH_I_FLUSH_FORCE_BIT mixup
v2->v3:
  - set CEPH_I_FLUSH_FORCE atomically with set_bit()
  - clear CEPH_I_FLUSH_FORCE only when deferred-revoke is handled
---
 fs/ceph/caps.c  | 63 +++++++++++++++++++++++++++++++++++++++++++------
 fs/ceph/super.h |  5 ++++
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d7283fb54cec..6f973703b87b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -979,6 +979,27 @@ int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
 	return 0;
 }
 
+/*
+ * Return true if any cap of this inode holds caps which the MDS has
+ * revoked, but which we have not released yet.
+ */
+static bool __ceph_is_any_revoking(const struct ceph_inode_info *ci)
+{
+	const struct rb_node *p;
+
+	lockdep_assert_held(&ci->i_ceph_lock);
+
+	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
+		const struct ceph_cap *cap =
+			rb_entry(p, struct ceph_cap, ci_node);
+
+		if (cap->implemented & ~cap->issued)
+			return true;
+	}
+
+	return false;
+}
+
 int __ceph_caps_used(struct ceph_inode_info *ci)
 {
 	int used = 0;
@@ -1421,6 +1442,9 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	cap->implemented &= cap->issued | used;
 	cap->mds_wanted = want;
 
+	if ((ci->i_ceph_flags & CEPH_I_FLUSH_FORCE) != 0 && !__ceph_is_any_revoking(ci))
+		clear_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
+
 	arg->session = cap->session;
 	arg->ino = ceph_vino(inode).ino;
 	arg->cid = cap->cap_id;
@@ -2038,6 +2062,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
 	if (ci->i_ceph_flags & CEPH_I_FLUSH)
 		flags |= CHECK_CAPS_FLUSH;
+	/*
+	 * A revoke whose response was deferred (see handle_cap_grant()) must
+	 * still be acknowledged.  Replay the forced flush here so that even a
+	 * check triggered by writeback/invalidation completion sends a cap
+	 * message to the MDS.
+	 */
+	if (ci->i_ceph_flags & CEPH_I_FLUSH_FORCE)
+		flags |= CHECK_CAPS_FLUSH_FORCE;
 retry:
 	/* Caps wanted by virtue of active open files. */
 	file_wanted = __ceph_caps_file_wanted(ci);
@@ -3757,13 +3789,30 @@ static void handle_cap_grant(struct inode *inode,
 	BUG_ON(cap->issued & ~cap->implemented);
 
 	/* don't let check_caps skip sending a response to MDS for revoke msgs */
-	if (!revoke_wait && le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
-		cap->mds_wanted = 0;
-		flags |= CHECK_CAPS_FLUSH_FORCE;
-		if (cap == ci->i_auth_cap)
-			check_caps = 1; /* check auth cap only */
-		else
-			check_caps = 2; /* check all caps */
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
+		if (revoke_wait) {
+			/*
+			 * We can't ack the revoke yet: the response is deferred
+			 * until the writeback or cache invalidation queued above
+			 * completes.  Set the CEPH_I_FLUSH_FORCE flag to remember
+			 * that a forced cap message is owed so that deferred
+			 * completion (ceph_put_wrbuffer_cap_refs() or the
+			 * invalidate worker, both of which call ceph_check_caps())
+			 * actually sends one, even if by then the revoked caps look
+			 * unused, the inode is retaining caps, or the MDS has
+			 * re-granted them.  Without this, the cap message is never
+			 * sent and the MDS hangs ("isn't responding to
+			 * mclientcaps(revoke)").
+			 */
+			set_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
+		} else {
+			cap->mds_wanted = 0;
+			flags |= CHECK_CAPS_FLUSH_FORCE;
+			if (cap == ci->i_auth_cap)
+				check_caps = 1; /* check auth cap only */
+			else
+				check_caps = 2; /* check all caps */
+		}
 	}
 
 	if (extra_info->inline_version > 0 &&
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..878440a2eb3b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -687,6 +687,10 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_ASYNC_CREATE_BIT		(12) /* async create in flight for this */
 #define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
 #define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creating finishes */
+#define CEPH_I_FLUSH_FORCE_BIT		(15) /* a revoke's response was deferred;
+					      * force a cap message to the MDS once
+					      * the deferred work completes
+					      */
 
 #define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
 #define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
@@ -699,6 +703,7 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
 #define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
 #define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
+#define CEPH_I_FLUSH_FORCE		(1 << CEPH_I_FLUSH_FORCE_BIT)
 
 /*
  * Masks of ceph inode work.
-- 
2.47.3

