Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07C34E74B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565979; cv=none; b=BplcTCtVHplDeOSwAwCbJnRpBuSNDLUWh/Wmu+GOY0d99cCsRmFwSLEHhpqWeEW4+PhbWqyWx4HoRKxAilwTpVPB1p0PI08gt2UYPrB4fA71YTnn6q8U+6JEsVx5XpXSTJS51fLGN7+eKtHgd8K9hm2DFoZmwxhxCtUNHRmJkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565979; c=relaxed/simple;
	bh=nmSMDrqTZ8h/iwCzyTsRyyD43KuC7bQC+O7Vt+e0pBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTxiBjgrtB1Gbxh8gjUOLtAbnRRwf94RtpcBxZjFq+l65nlup5QoSYpttzDFEEX1qzP4wU8KkcznsqFx/uDS3jneBdWX6MyU5FUX+Bn5u3aEWu0rVoBR+JPRtSOTkt1roI/zStB5pD957hjmhvLIfZY1xUHsFAs8l3Sw8hg13lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=J/WD9yNj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="J/WD9yNj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so8899985e9.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786565974; x=1787170774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/Y8gQ06TpeNkeikg3ga6WNbQ4HRSdTBd5g53ymy4CA=;
        b=J/WD9yNjN+nli/FKEtcKxASxmgZD/htIdx/hDl9uMh8A3EKH6srp4IRkvnu85SBo0n
         aGwsPF66ShlkehVOF5fuhwW+JIgthyKAdJbdPiA60PC+0mE6+6GuhjhYpgHcEPYSM5j9
         pXBbFMMtyXy9hDCSljHQQs1GKCbzeGxiLEZKo7Sw5yFdq8sNQxviWW7rGIT/hmNrCSNP
         dL5++mUeEX9qSvleABL5O7WdGhfozxabzlLWdvC0bd+iQ8aPJyL5ufQfWA6POyhfCdCs
         KngQRdNaEW+vK7MxH0jqksDPKAbEoR5hVj+YWkNz0o0I/zE5IV+lOKlml/qOjy020QFO
         1U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565974; x=1787170774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/Y8gQ06TpeNkeikg3ga6WNbQ4HRSdTBd5g53ymy4CA=;
        b=iX9IkOo0hN6JMjrStyFv+/63KFxCXeLNUo3zfZzkbHauZaOTNZxxCLuzZ/RZauFdPv
         Y+ijZgQVbKlMBrDkxQh0eVwovN89rj8ZZalIgv8foDahY601+aYq0hrVv79p5ADd2FSx
         EUrxP2ZH3eff2qoHBqiNb8LDvqiTtI3OpppJ2VglvchXuYa+f4RdgDuRdr0qEHA/QvEf
         tb3/M2Gl/e6FL87+2ypaiKg43huL6fF33hNe3GGpOrgO9FvMqtLqZXI64EG8ed7vh1xm
         tYQcUlYON+iGXaw7oOsF6cGUN1nV3xPQcDsU4O6IapBHyW+KbyLM1LhgBXh0ygYG5K2V
         gP7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp5lQkQQXibDDPe23LGxD0M3/zY0KhQEyu0epHU8oRaD/41LuM910f2yKWgAKpcIQaNdkweXf4e999b@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhzy6CJLZGe/tL2XQXAWgbMFchiA28sFaINOjW6kV4aJVbHwjo
	Rwxp+Mj0+8mVQbARAaGoZ+8qDcJ4Jd18GWfjM+P9CTxWDQM03HwHr5bQYBADlkdXKPOvit/utr2
	snfrqxEc=
X-Gm-Gg: AR+sD13BXdbate+7X+KaDOCu2H7p/8RGDx9DB4XgukzJRoHZjFh64YfL9eaYBhB7PXD
	apyVxuIRL7rIcpGxvb4VWusmappJZWP0g/jFClulyKWhLJt3j7JfEa4qJoKVRKUBQOqmYnd0uJH
	EXHD2CqoIDdTbTBOcgvobqdyMTH1YcfelHQIubEOkibPiHha7iTm1wJQkC2m7K3OyyPSLYP7cXa
	A/mjZzefAM0Zv9pbYzpK8sF66uS2eZeBe8XQ/2xbfeeRMKwkXMA3V+hRCcM5HnT5UEfBe4jNdaE
	Q52mM/A3wr4ga/fhupMJtotHdTMIJNvXgrHAuxzkAtWK2EEaYtiyEmNkEA5YlKsvAc6uSkWzKaT
	Dan6uqADjnkEBI0/soSmPeYX1Y+UA8HeBGku+/oMxQcncpkWNPtpiG/N/lKqXqtzkEPUp5ZkG+O
	FczI/aLkwcFtTrM6wRJvriPWfWaOfQhLHn4DQ4VD31lWpudKDUZXen9gVS4Ole/mDiZrtA9/fMc
	36ba+KL5E2nxtGJFQcEQ00KSR5aJMmQp9c8qpY3g49vFqwvXMBS2X6O6utHlYTz
X-Received: by 2002:a05:600c:37cc:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-499821f9047mr2328825e9.13.1786565973814;
        Wed, 12 Aug 2026 13:19:33 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2308sm190856f8f.33.2026.08.12.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:19:33 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Wed, 12 Aug 2026 22:19:15 +0200
Message-ID: <20260812201915.1783578-1-max.kellermann@ionos.com>
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
---
 fs/ceph/caps.c  | 40 +++++++++++++++++++++++++++++++++-------
 fs/ceph/super.h |  5 +++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d7283fb54cec..8ad17787b172 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1410,6 +1410,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
 	clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
+	clear_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
 
 	cap->issued &= retain;  /* drop bits we don't want */
 	/*
@@ -2038,6 +2039,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
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
@@ -3757,13 +3766,30 @@ static void handle_cap_grant(struct inode *inode,
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
+			ci->i_ceph_flags |= CEPH_I_FLUSH_FORCE;
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

