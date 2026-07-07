Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96842E8E9
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460227; cv=none; b=Sq+AYuMY7R/UHBtaRy8G1oJh/Ur2iOU11vfkt0xiHJ11As5fcp9jW/lRtO6ixTL//Hf8e7DLx0+4/wzeJoeYXRja7yjJGYV74HE40dacBtKHZY3vPXjmF6P94R2Jw8zjyx6II0Kf3lGYtSYukUkxJ0RrCsKqr5Z0n1zGlDlWyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460227; c=relaxed/simple;
	bh=JFsLmEKyfdTdtXMq6EUaN5UhDjHQN2cuAZLED+NvvyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+df3bMJjbSpI9aCe1DAHmzII0STW5H1cQxxZFEMbRCugWMepw2SGY0JMbJ9vBbdpag6JdE/m/XjSv3gsZC+QxjOitr5CNo2byjNExgoL+TljQbUJr+z5bcHEZWNWdzys03hsDde18n9U58bD1DmlW4G7nqju1QsjUldcNHJXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GjZLvBLn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GjZLvBLn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45fd464d51fso9665f8f.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783460223; x=1784065023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fo0QDLa6YknvhmREei5gKWi0JYOHdfUxXGn44oX0+dY=;
        b=GjZLvBLnvqBF3VF403lFd3a41A/IQXFRCGBY7fEfl7YUjFuIfsR2Jf53Vg3IKD7XjD
         YKQz2MszKIaaxgsWACMTVMqfuY9C4a6Ic/4kRpljMpKDxhT+bHm3C/7xHy6e32OtvGZj
         TcVNn/IkvWNKNz2atz2asq2IhfC05cHoE2H39ghScCajzh6YDWB+ftx2u4+vTZhOsAwD
         PWOLs8MYS3qfjMYALAmIMeO7PbZFrtRIe9MzWLYcGtTCbzsI6WmFvJe2Mhy+R/o47j/y
         /CtaVM7EwC90jIi2Y/TPC2PdSst+dNgua2VW0V1M/pivEqu65/lfsckuMSyUV6CJlpp+
         ofqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783460223; x=1784065023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fo0QDLa6YknvhmREei5gKWi0JYOHdfUxXGn44oX0+dY=;
        b=PMN8lnDKyHCSK7okLsaQJJws1iB99aGtHEfcqeMplNGG2ofQfh7opMMPmLEtC549El
         BqQY5s0HHyATBTNsBaeMVXkMdzrKTs65OO6EhJGUesWQtzQes5Lq8kLnhJfqthUJTz8N
         LaojqkFZksjHthp5NvHvd8ww4g8yGdlqAx9E7gCxfRdTPinK4uYd2790/9Wr24D06SYK
         WExt5WZ3Lt3AzxrKy7k2nKHj7lQSZGcYh/RLWpu8v0O6n74x4Xb1O1qlhO0XZ8DFQzeU
         q30g7hTzOxGUOtj1Dd10VPgWkGU5DRGay3/ccAJkLL+c2WD38XeXR7w1N9j9rrc3aRnA
         L2fw==
X-Forwarded-Encrypted: i=1; AHgh+RqU1vONyRqwxVGyHPD+aYj8gKIM8CrWdehy1T+qj1pTkJ3mwGOEeZg6akynXaCyrQWF2vo+aUuVSjdG@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAGFtDySw56z4dEQ8x0k5Yq1NKmwWy7TKC1gU4k54A0Rc3hb5
	wif2xuBKY2N9VfC5poDpz8kZvCIv00XaWnxUnTC8EzI6x8KFeJG15tnmGSKjDW//sLQ=
X-Gm-Gg: AfdE7ckbZFjHfYRREX6icClmM+cC0S+hCgRc8cHXPsw+Gj0dfyAHn7+dhc1Ktmv3cUU
	hjvmUxVMitVq29T0PB6UCHdKsAUEpQ8AecHfkbp9RgqRtyVmnaZHXIXhIc7IBK6phvd/AhPY8AO
	DkUq97MuG0ZtPno84j19XX+0CZmnwgsGAOS51rshzrQ8ci6KUDLMDpxWzbBNgudECy/Ti7HNDMZ
	eE26+T7tlWiqridtOZ1YmJMhgzAkKmjl7E3ooFjp6QPRR4vClJd7ZnO+Jpa64EDUEmHet830tG+
	PlLb8nwubO8qO35IDod+lCoHcj/rRSVA+pp3IZY8EdwVENNl0lFYAQfzkaU5b5TCV3b53y1VX0e
	/TJriOajztUI4LB4WXc8Rv/KcxG/CuI0SlSpx3sx2zcpUAknz1Ud/50AyHPQDiAmP6mR/83+GOY
	oYJEK/9JAb84AvyYti8WpsxnfopXoebniTA9+xFAajzXX3XVFj2Mm3ZB3hY4prAyijsrNQtz+Wi
	mGNyGpV4ZV1Ogk/
X-Received: by 2002:adf:fa08:0:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47de66503aemr5637948f8f.2.1783460223350;
        Tue, 07 Jul 2026 14:37:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm33829106f8f.30.2026.07.07.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:37:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Tue,  7 Jul 2026 23:36:59 +0200
Message-ID: <20260707213659.8939-1-max.kellermann@ionos.com>
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
 fs/ceph/caps.c  | 40 +++++++++++++++++++++++++++++++++-------
 fs/ceph/super.h |  5 +++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..132936eb6b91 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1410,6 +1410,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
 	clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
+	clear_bit(CEPH_I_FLUSH_FORCE, &ci->i_ceph_flags);
 
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
@@ -3744,13 +3753,30 @@ static void handle_cap_grant(struct inode *inode,
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

