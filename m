Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA13223DD4
	for <ceph-devel@vger.kernel.org>; Sat,  7 Mar 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892523; cv=none; b=mA9M0dnF567hbqqjgfnXsIekn290qm89aDreDuxDHsIBYvAUO5bXV3PWuxAtR2lFfdElO3MN6lcTthP7cSHMGw7ptxSulkl2b8hVxuh8JzXraA5OQevkKjj1YVYN8d/g18Niv3ZL+tS6ZI4FrLW6Ra3UFyARJAM5zxa+goVGDug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892523; c=relaxed/simple;
	bh=Q9dm8LTnk+DFIEJAAB7tpFWixf8EizWYmak8EK7I1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFcnKNGX5JWFW1Lf+n0+k0eh+cBFVYKGqJi0TQIVJY0IgUX4i7XCjTul1arVem5dPHA3OO78EmHBGya2vPFqjG4IGQdsoaXC8EIQ69A/ONxstR2i5mYNW55CW73TBAQkMQGq/o8eTD5PbApPRefxmHiQ3v4CPgXO4OXpp14EBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyUET1vB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyUET1vB"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a9c03780so1344170b3a.1
        for <ceph-devel@vger.kernel.org>; Sat, 07 Mar 2026 06:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892522; x=1773497322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=WyUET1vBFRbcwnM6O+g4qVx+Y3X8hs8yEO8XLxOATCDMFPD3E7aqYRG7yPmMI/DhRm
         wXC8k4D0hx6sE1gEAB3Ke9quwbR1R8885wbx+1sNGdE/RyaUR4VivxPegnACoMBt2L6J
         Ooupbr5SvS7eBZDnwcmf37bgCke0RSZt6yWeWX5d22CUjrv9EMDPxqho8ngBAhOwQox9
         QjdtoPCN9MMrPufX1Cf64q81Tz4uT6O5R7L+eBvC5MFN3ySxr0MVu79Hc89nhN91tia+
         UkH0cLlVvBgDFBfB2TZ3MrWhxbCdrPuQOabPsUtNnO5o05Jg10U5kqlHGEl00Z+p6Ila
         78jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892522; x=1773497322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=cQ23ktiW6oQtde3ALHhX+9Bdx9meojKwD9pjVMxP9Z6E5IhDivomi1+EwRYkXIVUYs
         i2G0QDr3/Z6yw9KLTRzd3peyZLMR9jhcu599mt9TAi2DmfgkBIwUX24Xjx0V+n/bqxhd
         Ax/IT/kSBoMWyvkhBmFn/y2mzMnkEj/E6R9R1+rnJqvShSvb5HIKkIZbG5fW5K6QYtUX
         RnHTcmwTaogjOot8VYka7obOcoPo9AffcnpSycosjrYN02kcdO0LQi5GvpybOxALr1FZ
         8xGNh//vKwLO32N784T6I99nYsyngc/Q9GNd3Hxpg3gP/PdS8Z4DyL/1/3JQvQ//LOIg
         uduQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa1QgHJQC9XD5oeZh965/Ci8FyUlsHaY0HiJ97ggP24V+rkztHvCaqrpp+QvwTCy2nz9EDzi+VUS1I@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPJyMfPuYLJ0+iVD3ddcrCpsYGnCSwcZ6Urk9O88ky0wCTmmD
	y8vzRzy5FrQpXh9dS4MQ9+YCgfFGPCYL7Xdwt4XmjpusDyVbx2Q9exoT
X-Gm-Gg: ATEYQzxLoP4f6045mwUIH2aLJJ0QlNmE2Z1ebGtcT/aI0dyjpxwfnlZQCj5b4RZVdjJ
	DVsqQ8tDodNHJ3rvSK4UdTUCTYF/Fkndg0pSEtgCUGL3TfkO2txrjoaBP6bo/BJpwxKDn1BAT6u
	Ph23tD1/a4kXJ12LyeANilSp0vrINOFQd99oSvvSIvwDGXzHBY/aoHJKOVrIDHcWPpiyPaaywjL
	mib6YRO5AhmFDuZhi4ckjy0Vqw6wXQuGixVOHwys4PxEZISa0pe3sPiyMZup7Oq98TpeNRK3Jpj
	RYYbNnfpbz45chV7HLRPSln5pKuLfYgF0fuvcBC4DQyGFobsIpzBMuG0sZojAzscqxa2u4vY8RP
	URfWPbvUZOBksD1ipDUT1k6Q/uvfi+RKf2xH6EwvPHFSyyYLP/9iATkibP01/PpUNpN5ORTTB4z
	SDzIdiPLmhkuv63KOObwDtVq8qJTWLDbOI8pt5pe02BX+BP5e4n12WpxQ=
X-Received: by 2002:a05:6a00:7586:b0:827:2a07:231d with SMTP id d2e1a72fcca58-829a2dbaa39mr4250553b3a.17.1772892522295;
        Sat, 07 Mar 2026 06:08:42 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:42 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v5 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat,  7 Mar 2026 20:06:45 +0600
Message-ID: <20260307140726.70219-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/sparc/include/uapi/asm/fcntl.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index bb6e9fa94bc9..33ce58ec57f6 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _SPARC_FCNTL_H
 #define _SPARC_FCNTL_H
 
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_DSYNC		0x2000	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x4000
+#define O_APPEND	0000000010
+#define FASYNC		0000000100	/* fcntl, for BSD compatibility */
+#define O_CREAT		0000001000	/* not fcntl */
+#define O_TRUNC		0000002000	/* not fcntl */
+#define O_EXCL		0000004000	/* not fcntl */
+#define O_DSYNC		0000020000	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000040000
 #if defined(__sparc__) && defined(__arch64__)
-#define O_NDELAY	0x0004
+#define O_NDELAY	0000000004
 #else
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
+#define O_NDELAY	(0000000004 | O_NONBLOCK)
 #endif
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
+#define O_NOCTTY	0000100000	/* not fcntl */
+#define O_LARGEFILE	0001000000
+#define O_DIRECT        0004000000 /* direct disk access hint */
+#define O_NOATIME	0010000000
+#define O_CLOEXEC	0020000000
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -32,12 +32,12 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x800000
+#define __O_SYNC	0040000000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		0x1000000
-#define __O_TMPFILE	0x2000000
-#define OPENAT2_REGULAR	0x4000000
+#define O_PATH		0100000000
+#define __O_TMPFILE	0200000000
+#define OPENAT2_REGULAR	0400000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
-- 
2.53.0

