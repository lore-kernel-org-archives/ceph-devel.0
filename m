Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82827AC4C
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772453; cv=none; b=Xp77x/Umsa0DR/g6XOBxIHWqFAc2VFItiUjkTmKUJTTAdCgSeJ/9zIsmEmZASROSDXXvGBGXOixuNmAt+6dZldnGliWXqZQlxv2vA6QUy/gQyzFaszwbPhnVM9kPT01EEjeI95J2j217RveBRHEYMmiaiqUS/H397KSFFOSjDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772453; c=relaxed/simple;
	bh=4sMY40AkLnXatMC0Anyvm+jDAzp0G51q8wrYyo7vcHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ccb1OxAOgRQ24BkebuVemlrqtFNlCKFbz63AiUeeGsl/lGDPuQ7UwSyAYweibDg+6nEmsAhhrKuOwSIJy1WscbJ7kq8dpxlGEYWf7Khen3ZfuDkX3IlRbiqRYvb3ERgz6spI894zlofhvVRnPl230JrvscM2Q351mXPkaiV+FGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qp9PmiSN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp9PmiSN"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177ad0cc67so24392971cf.0
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2026 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780772450; x=1781377250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DjmgW1mXPm4joNioJYRGWEnxoZsgWtSa55pt1fPZlM=;
        b=qp9PmiSN33E8ymQU1zszyol5vcLqz/Stn8ztrEFenT5B+0p8P+XaG3twMdestXTvrN
         YinhRVNfz65+z+Itrx5273x8uO51F5BCHTOADDTf7VE0QAtwpIG1tGaDsMCa97NQw4LJ
         6+gcj1BoPu8SrJln0Hp8ejGiRMoZS79xvL0aHp4pij0QcSqPiWybCkRlg4nt1mxHl1fr
         f0cMzI6Vu+czQ/Ro/U9vJJiqC6fxme/b9b2rBBcLdVrPq6LoodOzyzdLeUGiUjq/6Xi3
         LjrzxhinGUjlViSvMoYTg5TRg/01E+t+LlmzOualF4da+6z5Dq+33QtMXB5rmfvYgHPD
         TK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780772450; x=1781377250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DjmgW1mXPm4joNioJYRGWEnxoZsgWtSa55pt1fPZlM=;
        b=h0bFTh+wecd5NDSV+Mbmlol7xP54/woWOSYUKPCNjL/2HGqcAdRjpbVuiaRusxzT6i
         lLINjonUstWwXCVVF5DsP+IY/AZ2Y75br6acCHx3vBUWYc1LEGHk614iqw5qn/Xf+5cU
         3ZJ5NhDTN9kmCbRo3x204qsnXxohgkTRJsXzF75cdzJ88lIwDS4YBL3I3t0g9NzrM09/
         Cw0xyybQYhYhSKHOerOI63Uo2eHn46D/rmYc9NKDPbdUlBpQhb2DHc9NOwhL0H+/inHU
         mNnQYEo9B32KYzJPUhzoThQpXEQzBufRPkpx1TfPQQkJXpA1BG8I6OB/zRez9+9xn5+0
         U8uQ==
X-Gm-Message-State: AOJu0Yw3GHgl47P4xpnbnwbb2BPjIdK6/oldhvebqsLoIrreAHZKdpNp
	JJAfTp2BNLrDUxivya9uojAQJlonYWPRkaP7ZpRzl95IBGwGFYd1R5VN
X-Gm-Gg: Acq92OHhnjBLk+oOzaRCWmSHNZ2dG5u7wsVqUz57njugNHFvRHfAmNA1WFQ1SVY7WN1
	3A22bbFr5AqorxVxzsQbYJgqi6/n0ghf98YJog4FVL93MU1QJXO80Nz7YvAqCRirQFL59Ler3H5
	JyTCp0SPwT4QlYlb2S6nzV7egIWymUQig1Ehecm0lIEqtOPutG1zkyxOWD22GUHWw0j6aqaLAW3
	e6CXfdBCmltLpJO4uEPifiMJ9bhcEnLc1iJZdo8ifeS7sDKTfbY3z/M37bbZj3zxHF4DkYlHrgw
	LS0kJYFq5XMwSDFZVyR9qFZsxHfcEXl2LFjdjwaSvtRmz2xKCaTfxzg8UUkfXwx9cWfcwWIeBdm
	AeZJpJOIjE/KUCCcmL+GT6RHOwWIZ3HU1UxQV3X4H/fs58SaPJlmS9zoUGlxNtOZHomPA1UkGv9
	AA0j+T8Kp9094aLGK6qA2T4zsiHMcWu/xjlAWZGRJ0iDKHkcZzJVHkaP8OUas9Ds8EOF8SnctUI
	bhIs00KuROKs0cmsnzQuCvBJsuDZWQ=
X-Received: by 2002:a05:622a:2488:b0:517:9544:163c with SMTP id d75a77b69052e-51795a08a3amr137404321cf.9.1780772450457;
        Sat, 06 Jun 2026 12:00:50 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5179dd9d908sm40084581cf.15.2026.06.06.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:00:49 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ceph: cap delegated inode count in ceph_parse_deleg_inos()
Date: Sat,  6 Jun 2026 15:00:25 -0400
Message-ID: <f1ae6f5a1b5ca0857f31b7b2cffcf899174f12ad.1780766417.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766417.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com> <cover.1780766417.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ceph_parse_deleg_inos() decodes interval sets of delegated inode numbers
from an MDS create-with-delegation reply. For each set it reads a 64-bit
start and a 64-bit len with ceph_decode_64_safe(), which only validates
that the eight bytes are present in the message, not the value, and then
loops over len while inserting entries into s_delegated_inos.

len is fully attacker controlled. A malicious or compromised MDS can send
one huge interval, many intervals in one reply, duplicate intervals, or
repeated replies that accumulate delegated inodes on the same session.
The v1 fix bounded only one interval and still allowed aggregate CPU and
memory pressure.

Bound both dimensions. Track the number of delegated inodes currently
held by each MDS session, reject replies that would exceed that
population cap, and also cap the total interval length accepted from one
reply so duplicate ranges cannot spin through an attacker-controlled len
while making no successful xarray inserts. The counter is decremented
when async create consumes a delegated inode, incremented when a
delegated inode is restored, initialized with the session xarray, and
reset when reconnect destroys the xarray contents.

The cap is a fixed, client-chosen constant rather than a value derived
from the MDS. mds_client_prealloc_inos is a userspace MDS configuration
option; it is never sent to the kernel client on the wire, and a
server-supplied bound could not be trusted for a defensive limit in any
case. The constant is set well above that option's documented default of
1000 (a generous multiple), so legitimate refill behavior is unaffected
while the CPU and xarray memory a malformed delegation stream can consume
stays bounded.

Impact: a malicious or compromised Ceph MDS can no longer make a client
spin through an unbounded delegated-inode interval or grow one session's
delegated-inode xarray without limit.

Fixes: d48464878708 ("ceph: decode interval_sets for delegated inos")
Cc: stable@vger.kernel.org
Suggested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Replace the per-interval cap with a per-session delegated-inode
  population counter.
- Add a per-reply interval budget so duplicate ranges cannot run the
  insertion loop without increasing the population counter.
- Reset the counter when reconnect destroys the delegated-inode xarray.
- Document why the cap is a fixed client-side constant (the kernel client
  cannot read the userspace mds_client_prealloc_inos option).

 fs/ceph/mds_client.c | 51 ++++++++++++++++++++++++++++++++++++++------
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.h      |  9 ++++++++
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4f36ac73305dc..ec5a80c9f86a7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -612,16 +612,34 @@ static int parse_reply_info_filelock(void **p, void *end,
 
 #define DELEGATED_INO_AVAILABLE		xa_mk_value(1)
 
+static int ceph_insert_deleg_ino(struct ceph_mds_session *s, u64 ino)
+{
+	int err;
+
+	if (atomic_inc_return(&s->s_num_deleg_inos) > CEPH_MAX_DELEG_INOS) {
+		atomic_dec(&s->s_num_deleg_inos);
+		return -EOVERFLOW;
+	}
+
+	err = xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
+			GFP_KERNEL);
+	if (err)
+		atomic_dec(&s->s_num_deleg_inos);
+	return err;
+}
+
 static int ceph_parse_deleg_inos(void **p, void *end,
 				 struct ceph_mds_session *s)
 {
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
+	u64 msg_deleg_inos = 0;
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
 	doutc(cl, "got %u sets of delegated inodes\n", sets);
 	while (sets--) {
 		u64 start, len;
+		int session_deleg_inos;
 
 		ceph_decode_64_safe(p, end, start, bad);
 		ceph_decode_64_safe(p, end, len, bad);
@@ -633,16 +651,34 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 				start, len);
 			continue;
 		}
+
+		if (len > CEPH_MAX_DELEG_INOS ||
+		    msg_deleg_inos > CEPH_MAX_DELEG_INOS - len) {
+			pr_warn_ratelimited_client(cl, "too many delegated inodes in reply\n");
+			return -EIO;
+		}
+
+		session_deleg_inos = atomic_read(&s->s_num_deleg_inos);
+		if (session_deleg_inos > CEPH_MAX_DELEG_INOS ||
+		    len > CEPH_MAX_DELEG_INOS - session_deleg_inos) {
+			pr_warn_ratelimited_client(cl, "too many delegated inodes for session\n");
+			return -EIO;
+		}
+
+		msg_deleg_inos += len;
+
 		while (len--) {
-			int err = xa_insert(&s->s_delegated_inos, start++,
-					    DELEGATED_INO_AVAILABLE,
-					    GFP_KERNEL);
+			int err = ceph_insert_deleg_ino(s, start++);
+
 			if (!err) {
 				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
 				pr_warn_client(cl,
 					"MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
+			} else if (err == -EOVERFLOW) {
+				pr_warn_ratelimited_client(cl, "too many delegated inodes\n");
+				return -EIO;
 			} else {
 				return err;
 			}
@@ -660,16 +696,17 @@ u64 ceph_get_deleg_ino(struct ceph_mds_session *s)
 
 	xa_for_each(&s->s_delegated_inos, ino, val) {
 		val = xa_erase(&s->s_delegated_inos, ino);
-		if (val == DELEGATED_INO_AVAILABLE)
+		if (val == DELEGATED_INO_AVAILABLE) {
+			atomic_dec(&s->s_num_deleg_inos);
 			return ino;
+		}
 	}
 	return 0;
 }
 
 int ceph_restore_deleg_ino(struct ceph_mds_session *s, u64 ino)
 {
-	return xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
-			 GFP_KERNEL);
+	return ceph_insert_deleg_ino(s, ino);
 }
 #else /* BITS_PER_LONG == 64 */
 /*
@@ -1056,6 +1093,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	INIT_LIST_HEAD(&s->s_waiting);
 	INIT_LIST_HEAD(&s->s_unsafe);
 	xa_init(&s->s_delegated_inos);
+	atomic_set(&s->s_num_deleg_inos, 0);
 	INIT_LIST_HEAD(&s->s_cap_releases);
 	INIT_WORK(&s->s_cap_release_work, ceph_cap_release_work);
 
@@ -4971,6 +5009,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 		goto fail_nomsg;
 
 	xa_destroy(&session->s_delegated_inos);
+	atomic_set(&session->s_num_deleg_inos, 0);
 
 	mutex_lock(&session->s_mutex);
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4e6c87f8414cc..3810b51ece2e6 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -255,6 +255,7 @@ struct ceph_mds_session {
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
+	atomic_t	  s_num_deleg_inos;
 };
 
 /*
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index afc89ce91804e..bfc26e4d83bb4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -634,6 +634,15 @@ static inline int ceph_ino_compare(struct inode *inode, void *data)
 #define CEPH_MDS_INO_LOG_OFFSET		(2 * CEPH_MAX_MDS)
 #define CEPH_INO_SYSTEM_BASE		((6*CEPH_MAX_MDS) + (CEPH_MAX_MDS * CEPH_NUM_STRAY))
 
+/*
+ * Upper bound on the number of delegated inodes a single MDS session may
+ * hold. The MDS normally hands out a small preallocation window (the
+ * userspace mds_client_prealloc_inos option defaults to 1000) and refills
+ * it as the client consumes entries. This leaves generous headroom while
+ * bounding the CPU and memory a malformed delegation interval can consume.
+ */
+#define CEPH_MAX_DELEG_INOS		8192
+
 static inline bool ceph_vino_is_reserved(const struct ceph_vino vino)
 {
 	if (vino.ino >= CEPH_INO_SYSTEM_BASE ||
-- 
2.53.0
