Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D389403156
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283145; cv=none; b=BZrdLzh6YtHFlz1Srgtxmfqe1QT3GhUFgWp3uymJeEwf+yz6chRsLz35hEl9znA7PYjzlNR6ymeG13/mEUBjfhqiB1pKQXU0xC4iWF8M/NDghZb4E56w6U0v3M3Wrej0RpnwMSPqmXqssI2Vj4aO9BY9+ox46fNrJ6JPFZWCaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283145; c=relaxed/simple;
	bh=WCvi62p0s3fHIXlZeoHs62WhMVUZhZim6gnCWmADCUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4YomoUWMWuNku6s3YZ0toz6UIPYWToI6r8blx4UMgKMNEdymhJ2BWm/615AMYiZHR8YIWzLyky7PttzcoyP8lQPI+KzSvrFkKtFS/wBFL2suYd7hi3agJWJ2cXCMQST6uH2LpK4EL1opAGkfS2a60Q+EnvFqLFsG5fQOWCbTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=id2czieD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="id2czieD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4600cbb06deso756057f8f.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283142; x=1781887942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCqt7oyGsVjspDM/y18Kry2A1s2sB2XfzOaWQj6iyLI=;
        b=id2czieDwORZpDEv4nN7S2Du2lQXtqfC2AaF6a8RD3y5tP2PnaD3sZc9G4EbahlaSj
         EjlzX2zCXkWNdZSupqvkeo7BOP7fz+Lz1apIaoxdhmzF3Ewf7opU6SRDUl+OAPRdBcEu
         Uq+RbkcoFGGi0xujMYBh9eGKpvj3Iu6E9ASpSXcT6bNLC49LvT/i1UojTe0V17Uq65N+
         QTYTILb0YSgWb8OmPXbbFU4X34gOUNTqLyRb4iUAUiyufkSes6bxj6fh8QfA4uo7qHDP
         R6JP0mZGo3yCsWx0NsahC6CHherDA+RRlcgaiPACnCNdhu2A0DkdldBxRmUShRgquiIX
         zgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283142; x=1781887942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCqt7oyGsVjspDM/y18Kry2A1s2sB2XfzOaWQj6iyLI=;
        b=CFwL1FCCZKGlB6BNd2YCI5uyRjk3Prey9nz1dFs6tTwKw3Ay3O/nDi77RTRqTveqFr
         A2hQz9bPdosdIua3T+z+p7Pr4IVzefmeJLrO0deTV1Huk87cQ5FIIuxhFjUI/RI6OnGn
         OV3HRvpDQ4ES51KDkwhvzLNiWRUYHxdERYTGSqEk5jx0E1rwvMdmPxb2zBN0jtg55155
         Ssk3JYHWyEEdeaRKU3fH87GsksQjy55axjezxnlOfWS6QyuAYMFSje60C0xHy5t4fU7i
         x2u0HaWk70vd+z19u5zmaVbd/R/LBwR2CGqvDUoKFTWj6mxiuU6BnDQcQ8ccTZy5u5Mn
         U7yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CmsPwoXYmp6KNPsJnvCAiYUfMwe0Cg4L/hM2qrl1G43g1fqTO3bBwOGZLuylT3pRlBV2sod4WuIYa@vger.kernel.org
X-Gm-Message-State: AOJu0YxY85X6ZY2mQsajNUFKJw3JP9K20h5GV+p8/W12uWr9Cxkc0aVb
	AAkRTFzR0fKamRbRGPTZ7c/G2CAnLXZn2oBLUzfobKo/Cc8Cbhb53rsV26nxWe70Gqg=
X-Gm-Gg: Acq92OF3PiRQLRoSAFzwzdReH4QpEYHCXjUX3qswaQrmvz2DGA+WKUY+KcKMa2LtNS/
	0Coq/Yr1cbu4G6xCaH5XRBj5HDfmpfhsVHyYkint12JbAVK7fYQY1Uv/QKCw8ZQNBrarC1s4iPr
	0bozt1TWRJpl2BiWnXEMAm0D+6wAIw+JTmZvBTjl29bzXagDZ7ma6lmxQ/h+s7Zq2cjGqMylE7A
	jptaw479I+5y5SYDJhgwXCeTTUWvYldBd/IKwPiRar/oGe/Bhy6nWIJ+2sripQugUMsPZG7ofzV
	fr2RlO3nQ79Ch0iOX02sZWWyN2gJ3KaOD2Lc6bUWcFasu9Z0Pvk5dc/YuvWO9HhAMEiYe/QDOv2
	NU4S4yqDn3bpwy3ANr8pNX5SwhbVeMOJJ9VLEPFVINjQm4af1ltvAyPFH3XESBxdlJ3BjVkCmoZ
	T6JT7bw3mcFGB4noNuRVkqcztPsvPwg5F1wmbIfCFdkHpdGQdW5ICW1mUxck5X5OXs3OMNgHaGm
	8rH+3QciqiMfwT9Q9vzPHAzQls=
X-Received: by 2002:a05:6000:290b:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-4606f21805amr4604484f8f.5.1781283142042;
        Fri, 12 Jun 2026 09:52:22 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:21 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 08/12] fs/ceph: remove i_truncate_mutex, use i_fragtree_mutex for both
Date: Fri, 12 Jun 2026 18:52:00 +0200
Message-ID: <20260612165204.86137-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`i_fragtree_mutex` is only used for directories and `i_truncate_mutex`
is only used for regular files.  Since these two fields will never be
both be used on any given object, let's merge them into one.

(This is a minimal diff that defines a preprocessor macro, to avoid
refactoring all code lines using these two mutexes.)

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/inode.c | 1 -
 fs/ceph/super.h | 6 +++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 17df694fe978..c0d88cf1f6e3 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -676,7 +676,6 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	for (i = 0; i < CEPH_FILE_MODE_BITS; i++)
 		ci->i_nr_by_mode[i] = 0;
 
-	mutex_init(&ci->i_truncate_mutex);
 	ci->i_truncate_seq = 0;
 	ci->i_truncate_size = 0;
 	ci->i_truncate_pending = 0;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 646ebc03d263..19f26724b285 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -459,7 +459,11 @@ struct ceph_inode_info {
 	unsigned long i_last_wr;
 	int i_nr_by_mode[CEPH_FILE_MODE_BITS];  /* open file counts */
 
-	struct mutex i_truncate_mutex;
+/* since i_fragtree_mutex is only used for directories and
+   i_truncate_mutex is only used for regular files, we use the same
+   field for both */
+#define i_truncate_mutex i_fragtree_mutex
+
 	u64 i_truncate_size;       /*  and the size we last truncated down to */
 	u32 i_truncate_seq;        /* last truncate to smaller size */
 	int i_truncate_pending;    /*  still need to call vmtruncate */
-- 
2.47.3

