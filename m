Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D53AE70E
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024358; cv=none; b=XXUoorFVqtj0ZfsRGXtZdS/p1w03Xv4mwl52Qg3OZ+auY+9790HG8HOVlsBAfWJ+LM0FPFvoJ9qapowk59z1CUGaXfoWYGPgmlbLXcFO9zMfWul3KepRyFEAtRe+7/fQxDmjWMSo52tog0G02PJ0C7jVPwR0Ow+RbbYJOebDRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024358; c=relaxed/simple;
	bh=TNbFd2qyNk9Pt0ydHglMYbusemEGazuAFqUDQyoUgeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrXKbPA81xXqLtMh/HsSudqylRGYqgTJ4LQw7wmbzhx14mNGbrN3ljSqyjkUgwnrZq4d4RAhgZuAl+EWUQg1dQlF+zU6ZFbIXhnRyuguvfzvJzPrNPmupDiCKbgf+Q1EyN6hIKGFgBT8cphJ7Ly+7FsJCRZ7uxnjayz0L1FU27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgYqMpxe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOZ5ETNM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgYqMpxe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOZ5ETNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fimZdB21rJ1E1Fgh+/XpYitrzlTwFolfvXrZOvlZ89s=;
	b=HgYqMpxeWS3qkp1I2jhfrSiNbnWLREgfQ8d1jHhG/H5ic1G+omD1AN+MJfSuPnU/6aemsy
	XY2+e4MaUAlYeIUlRhOClVPkAUB+8ngpZ/E59MGvdX1KkNCRQgw9etfWXG89oP5Hq2+RK6
	M0IOQKXP6lToIrxSZ3e2AG1wVunZV28=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-vbg1NGpKMwq0pWpE-xqkeA-1; Wed, 25 Feb 2026 07:59:14 -0500
X-MC-Unique: vbg1NGpKMwq0pWpE-xqkeA-1
X-Mimecast-MFC-AGG-ID: vbg1NGpKMwq0pWpE-xqkeA_1772024354
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb37db8b79so3915482385a.3
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024354; x=1772629154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fimZdB21rJ1E1Fgh+/XpYitrzlTwFolfvXrZOvlZ89s=;
        b=BOZ5ETNMTkAztJXWAqYftcWjTJjevSqB2XGr9JgsODT9g29ZUMH10mlF+AHla/Ymn7
         ffwsi1wbiR0NTE7AVNOKUZD0WWTrGrMTxsGtBEdDDExWFoBSGNY58fnEUN9eBuja4m4t
         40mKWqXwH82GFsOB0bYhcW/p4I6cm0Yo8ems9d6/ivtEnElURjZ9G6BW35QP+F/oCuld
         A7oI76OiE7kj56ffe7LhnAunKwnu8cDbTIEXl0bUNQp9e9J7Vb6wx4LnQky+K2/q0IuF
         Y02LBO3gKFJ30j2VQotlHv55o3TFg3uljlQCa6zFMJB+f4J9FRQ4dnOnmjtccjoLVcL2
         V4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024354; x=1772629154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fimZdB21rJ1E1Fgh+/XpYitrzlTwFolfvXrZOvlZ89s=;
        b=ANfP9BKbysLjepjUegwC30HH7mWXH2Bzch85dVHEeIeFfUJGHNbfcG8wUeK4Xo5Ijp
         G4nt6lDojBx7X3ofB1a63ryzByF6DNv7/bXJtHPCs+C5D1MaclGCaZ9RQDFJNQtteNuS
         K1L/8554KgIC/03x32u0ODjGkSMlhruSrXRQUFy3ItYuurjHYA+MODV8IgR+gf1DPY4h
         spojIxFNrrs1ZBfc493H0u8jZx4Vekt7IQ2Rs9oh35bGbBbw0VYoPX0InbcqStDVk+DB
         OzjrFxxkSxQB3y3sJSo0pEZjlPOBgccVZ8kCAISG1Hi5PHjquBP54IahWu5H2Yjh9mp9
         7fHw==
X-Gm-Message-State: AOJu0YxKZCZrNIF3aWy35XTIY1cHd1zNxSkBekg7wP5N29LYSLNEcSKJ
	qYVGkVchUE8Rxi5ixowf+L9GHK8qu4irxRa0JOV7LPcA/E+VxFp5oQTG/ppf6jlykrrbappaV3T
	f7i1Xc/L3t2ci8JokYXuqr9MtSFUF+j1K/SEyrCljQYzgy5AWNX3MxpF5bCSB2GvLFjHk88/Ll0
	4oDaeh7Hr1DbPKnPVWxGTtyNB3hjuarnLUfGigJ78o2aEfvYSGwE3l
X-Gm-Gg: ATEYQzyvmu/3Noge3M/tXMat308eQd5rmWxj7sMcANKpOE702QTSMoTzHWynx5I9snT
	9L0Y0irbzV7ha+/ko2OG2E9O6sKQmbAnjsNMXW3ukA4E2367nwMS3ihlJXRaIDlvvmX+vgrtXJx
	OMcSe9tg1horVxFa0/SDbpk68cWb2g/n4lJuCFmLdFASpInXCQr7Dzke6kppgCtmTy568g2k1ba
	y79jsTpLd92wOPKbZL28gDmcYWKEv8/JgLCTTy8qpgb8nJytqYmntQCwXkhvzgYWh88m358XTtA
	Zv/Fpob8Tnii2jieL8q9RlrE7UkfWpxFhBuePC6qNmzfH5452tHsdfVL9+RCw0w4Yi5qIQh3/hn
	E4GUmUBXob+Pxfu822GvCCFDBZ3qSshmPP4vEGyXwWj9z641ixFEGqUU=
X-Received: by 2002:a05:620a:4110:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8cbbcf811a0mr42606885a.33.1772024353940;
        Wed, 25 Feb 2026 04:59:13 -0800 (PST)
X-Received: by 2002:a05:620a:4110:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8cbbcf811a0mr42604385a.33.1772024353421;
        Wed, 25 Feb 2026 04:59:13 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:13 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 1/4] ceph: convert inode flags to named bit positions
Date: Wed, 25 Feb 2026 12:59:04 +0000
Message-Id: <20260225125907.53851-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225125907.53851-1-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define all CEPH_I_* flags as named bit positions with derived
bitmask values, making them usable with test_bit/set_bit/clear_bit.
Previously only CEPH_I_ODIRECT_BIT and CEPH_ASYNC_CREATE_BIT had
named bit positions; the rest were bare bitmask constants.

Convert CEPH_I_ERROR_WRITE and CEPH_I_ERROR_FILELOCK usage sites
to use atomic bit operations (test_bit, set_bit, clear_bit) via
the new _BIT constants.

This is preparation for the client reset feature which needs
test_bit() on CEPH_I_ERROR_FILELOCK_BIT in reconnect paths.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/locks.c      |  8 +++----
 fs/ceph/mds_client.c |  3 ++-
 fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index dd764f9c64b9..2f21574dfb99 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -58,7 +58,7 @@ static void ceph_fl_release_lock(struct file_lock *fl)
 	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
 		/* clear error when all locks are released */
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_FILELOCK;
+		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 	fl->fl_u.ceph.inode = NULL;
@@ -272,9 +272,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		wait = 1;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
@@ -332,9 +331,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (lock_is_unlock(fl))
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 23b6d00643c9..28bb27b09b40 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
-		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds != cap->mds) {
+		if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
+		    mds != cap->mds) {
 			doutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 29a980e22dc2..69a71848240f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -655,23 +655,35 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
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
+#define CEPH_I_FLUSH_BIT		(2)  /* do not delay flush of dirty metadata */
+#define CEPH_I_POOL_PERM_BIT		(3)  /* pool rd/wr bits are valid */
+#define CEPH_I_POOL_RD_BIT		(4)  /* can read from pool */
+#define CEPH_I_POOL_WR_BIT		(5)  /* can write to pool */
+#define CEPH_I_SEC_INITED_BIT		(6)  /* security initialized */
+#define CEPH_I_KICK_FLUSH_BIT		(7)  /* kick flushing caps */
+#define CEPH_I_FLUSH_SNAPS_BIT		(8)  /* need flush snapss */
+#define CEPH_I_ERROR_WRITE_BIT		(9)  /* have seen write errors */
+#define CEPH_I_ERROR_FILELOCK_BIT	(10) /* have seen file lock errors */
+#define CEPH_I_ODIRECT_BIT		(11) /* inode in direct I/O mode */
+#define CEPH_ASYNC_CREATE_BIT		(12) /* async create in flight for this */
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
+#define CEPH_I_ERROR_WRITE		(1 << CEPH_I_ERROR_WRITE_BIT)
+#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
+#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
+#define CEPH_I_ASYNC_CREATE		(1 << CEPH_ASYNC_CREATE_BIT)
+#define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
+#define CEPH_I_ASYNC_CHECK_CAPS		(1 << CEPH_I_ASYNC_CHECK_CAPS_BIT)
 
 /*
  * Masks of ceph inode work.
@@ -691,18 +703,18 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
  */
 static inline void ceph_set_error_write(struct ceph_inode_info *ci)
 {
-	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
+	if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags |= CEPH_I_ERROR_WRITE;
+		set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 }
 
 static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
 {
-	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
+	if (test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_WRITE;
+		clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 }
-- 
2.34.1

