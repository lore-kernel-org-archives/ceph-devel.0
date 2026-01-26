Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4929A33E
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394670; cv=none; b=RcgiVgjxj2mfDKor4aLLnDwxgACX96uA30MJECrufFmiiMTraNhxm0VJFiXuQMlmHbHUtsdZpGK4PjJBcnQaf+0lH9oCCFj2WnYsc1uWKSpYRU4Y9woSGJS/GRQaEinbBl4bPsDMw83AmRkVqaJlLJYUd9Qfmbfhv+qLT1X15IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394670; c=relaxed/simple;
	bh=xreigetpjHdKa6OZ71uh6zOcPjuDFrwATx0og6exOHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKhPCp3XVskoAY7c1GBmt2WkwLc25VvG+JGkcIdoqaALuB8StikEYRAfIyInwmLm1nnxZ/bzyR5iV0hAaWWq9gita5xw4Yv3IhnpFwNW+VInkHoj+lLq1sR3J7xuHxfU9DOrG8afTrZp7GnrMpMRv6kkSwie4yKyCsQDiIAyLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5sQpun3; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5sQpun3"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233b172f02so5691860c88.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394668; x=1769999468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OeqEToDWh87NKXAJBkWa10HlZtuXDj/TYqt7IVavaQ=;
        b=a5sQpun34domUif7GnfgZYl25NskFflCpMYZekv2FE2b3UNFQ4ca3mDL5YQP2bydJn
         kLFIsU5x7RKY0qNA7WxGTaZTfCmihrhBOdW2uAVR4ZlHZfMrZDqhDi5gRZ0EOjw7N9Ub
         kKD4UbMTvpzdVMFMlWwVD7zAbxnCjQrhSAAVQKjJPyPAHxtqTTjaNgUWaAOzYAUBd6p0
         h2VgjQbGGjmZgjYh4zKp1zbohqaB32CrsMMJC0MT6E3ebMiMybed73hcnyshhvFdsHeB
         vuHk7m9RFow6+pWpimROCROmWP9k7Jw/Rfhb4SEHmx1g691eb3P7Wi26tRBoVmrmpkS/
         DpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394668; x=1769999468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OeqEToDWh87NKXAJBkWa10HlZtuXDj/TYqt7IVavaQ=;
        b=Vc1qNMbRZmfk1yAV0K2GxqqD8XTIRRI252eGNEidKmRhLFQrOTMUUGxDa93+PAUCOS
         ff5XxDMn4TDYVOd5U7c2gNOxS41+YxQqHDR5NFm5thWooOYmvH01gROEjrsLj5B+I+qI
         LTmHZrYFj5FNZu+Hy03Czz052c8Pj6itV3rbUKBnEkLfZ7sbZ1WgtBr3GiwZftlgGZzl
         dxaTmRSPl78AWaGkukB0pqJAPRnp5odnZlEnCak9GcPjpaHAo4D47o/dd5Hx9gKfnXjE
         CkVy2Gl1Ku6f7syy0VDQiIopinRZQoBUFoREWRDlk/2hZrmbRwawFvx3urvtumGNSNU/
         sFKw==
X-Forwarded-Encrypted: i=1; AJvYcCVg7HgtEU813/GFgz49J9yiGRcWiJehUERHZgnwjh/9rW9yqrQgsSQhet4yAUbBUMtbO5mOQjzHrOcA@vger.kernel.org
X-Gm-Message-State: AOJu0YztluCROTgbOxT12Y3LGP4LvxDY/ZBdmx/etg2Sg9rPFsKnRB0n
	24W6J4JLogL1FjqmlSTAmRCyb/ISPRE/2xO803szA61apK/BrC4urQISqHZ4HduN
X-Gm-Gg: AZuq6aI6zUnOukww8b7AHtbwlhjyKRHhZtDjh9H+STnCgwWDTkwyrA+kTEUrGl1ajL+
	oiEB9HXOeVYCsH5X/o4ykQe5HGqwofqe2hrvt5mPm1OB+tcG3qOSJk6BGlSwvYB03uRCHEEOhJl
	tiLPigq/6jTBOxfB4TnY0tLQbb0PbvyHWj0xa6W8cCqoOvl/XoywwZXP88z3wZga4L/D4tRYxS2
	jWkCcuG3Cw7hQ6pC4LHvKSF65Hux78kezWR6c7134KQ+DLO56WKqrE79lg8u2yhwrn92qB9F06q
	K9i9oSaRpA3qJzovSti5A2PE9KRlIWaixCmFWkDNjUocXfEq+D2ioP2IK86bsbVzDYr+tIFB6qd
	DXkHv87ud6uaEoQb77WLaU05UkR9P9NNW6emcd2N1iepDV1b4ol2nLQNCZicuuRd7DdXUx2d9Ga
	aXAE104m5cyEv/4Jpj7y0R+iy5KRnjAxysXEexAATQjWQJkqPo8DjE
X-Received: by 2002:a05:7022:238d:b0:119:e56b:98a1 with SMTP id a92af1059eb24-1248ebe99acmr1414133c88.8.1769394668050;
        Sun, 25 Jan 2026 18:31:08 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm17212277c88.6.2026.01.25.18.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:31:07 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] ceph: fix write storm on fscrypted files
Date: Sun, 25 Jan 2026 18:30:53 -0800
Message-ID: <20260126023055.405401-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126023055.405401-1-CFSworks@gmail.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS stores file data across multiple RADOS objects. An object is the
atomic unit of storage, so the writeback code must clean only folios
that belong to the same object with each OSD request.

CephFS also supports RAID0-style striping of file contents: if enabled,
each object stores multiple unbroken "stripe units" covering different
portions of the file; if disabled, a "stripe unit" is simply the whole
object. The stripe unit is (usually) reported as the inode's block size.

Though the writeback logic could, in principle, lock all dirty folios
belonging to the same object, its current design is to lock only a
single stripe unit at a time. Ever since this code was first written,
it has determined this size by checking the inode's block size.
However, the relatively-new fscrypt support needed to reduce the block
size for encrypted inodes to the crypto block size (see 'fixes' commit),
which causes an unnecessarily high number of write operations (~1024x as
many, with 4MiB objects) and correspondingly degraded performance.

Fix this (and clarify intent) by using i_layout.stripe_unit directly in
ceph_define_write_size() so that encrypted inodes are written back with
the same number of operations as if they were unencrypted.

This patch depends on the preceding commit ("ceph: do not propagate page
array emplacement errors as batch errors") for correctness. While it
applies cleanly on its own, applying it alone will introduce a
regression. This dependency is only relevant for kernels where
ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method") has
been applied; stable kernels without that commit are unaffected.

Fixes: 94af0470924c ("ceph: add some fscrypt guardrails")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3462df35d245..39064893f35b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1000,7 +1000,8 @@ unsigned int ceph_define_write_size(struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	unsigned int wsize = i_blocksize(inode);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	unsigned int wsize = ci->i_layout.stripe_unit;
 
 	if (fsc->mount_options->wsize < wsize)
 		wsize = fsc->mount_options->wsize;
-- 
2.52.0

