Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF484854ED
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076721; cv=none; b=JtGb96ByQCG7b5T8kZAoeBYiHA9rJJZyX1cqTITGWGcsOYWK3/I52WUI5olraFc9jsPZd5z+RJ+bLmysXLdqAHDyE4UPtaBdEQjYYQKnkOJw5lzcz13gdij3dRVGbduIfVyaNMt4P3lpS40mYh2igpZ3GHBcibh1XJNZpXsdexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076721; c=relaxed/simple;
	bh=PNsEuMwh6x9U7wnGeQD0+2aN3K+WtwxzV9yJyPU6bqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+QrwPIi/bK4/idYpCGGwzITaLzgth3fFA7H4MZIpW5XSxvAf4K3JcOvleOJLFIoVFExe1zqyCKVp2gDPHJlFPI+tU487fVXak3rbwuNWPI3ogRNANI2QQJtH8NTQShfbs1De6n9Y/z/O/ZN5f/vzBbQiNusRnfoUndtlcaiQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Yw+OHGsF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Yw+OHGsF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fde295992so35837f8f.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076712; x=1787681512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Pp8eRbtdJC1ybFAuB0ihbgIaBXGaMzvJfeMNRLq26k=;
        b=Yw+OHGsFS4MvYl1/p1u3omxg+RbvGNb1w5baHbaX/BrXNTh+AAx3D4JAOD/aQEzuBN
         mueKn/CvOXg8h7HWi9xK7NwQRgIyRNtAmJM98HVeZa+3bW2LCqJjpDQE77QAiPf7Qznd
         DYWFBq/D313yIEDVKAdH9ZaM+tXg6qX4JRfe7Z8udrGCZdQ0qiYcHB7Z50rei5Hke/cl
         KrazgXfa2qwaw7DXAUD4ipXe45dvnfLyt1kmXwJ4NZvvLROke1bFbB+oXWGneaNKDgAi
         daTqu1NQNDzN0KjK+WWV3m8kKrN9gm9h8eHvzoupZtMNC7TcjpleRlh8yMnNy31f4ZQy
         lDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076712; x=1787681512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Pp8eRbtdJC1ybFAuB0ihbgIaBXGaMzvJfeMNRLq26k=;
        b=qQIExkG+eFVXvafOcnd6CADlvQMFM0gBevz31ep361fHuHqd2l1Z1N0zUqpnyom3q0
         V3ulrT4pNQvuZh9DwT4+zjha2U8mPpkrrxUdiyHOswmdK3/xFSyttPmAjTc4EC/zgA0/
         aHcrn/vxomJRIB5ubtjM+/EErvU1RGLZuVvclFskL5Q6HzFdo4m1AO3kIbfQ8pPXBhsS
         +2wttfsFA8HMhOI3qfgCJRpFV1VnWrsbLUb/uwnRA9jdXjfKt5Fmvard6D7fxyf2ffoh
         XVOBQf5PuH7qJDCpPMwQkSJdz7WJYtq9R5drtTmG6n1qwUgGvqDFPS7iCXvmXJ/hGhF/
         Uxeg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/JtVkp3nEReyePmc2Dk0pF7g2MnYjxaRGWVMyDsfetUxZl7YkAaOoFlMj9iPtxCZfjpef7PqeuBk8@vger.kernel.org
X-Gm-Message-State: AOJu0YzvY9g8KVPi7lVRcOSvYsLBt9LFTq2rzyTPH/IEkMtTAD4rTUqO
	tPZwO1HwzNcKQNaaB8Kz2NUCy8TzZAgKOxZAjwP8uSGeRhvLqGvSYiPIVE/jnViRh3CsJreSiHS
	rLmaRPvc=
X-Gm-Gg: AR+sD12SdA15i7E12C1Y4BZY3GTPjgFxdCMkuV7NwJlOwk141hyjAZuuqiGZsS8lrEo
	MiDXSw2j+6CzfpHtLQl9z+lABEihvxIYirhS+yXb+jlU6hbVNsJY0r76jF5PxghILJ1XHlj2FLT
	gBu6qRhXx2tqdeEO3BKH0WrhX+ifaDEpRRnlYi97JpNGiXuxFb4+B6qvKO5VXmMitm49sVV9OCt
	5up4U7Yn/cK76OekF82g2ZmIj288ZStJFNg10CzvOr0OXOK5sqxhIgmPTNCJFCf5KVX3LQBSREV
	S2YtvjVTLPUmaBULNqf3VV8MfnYw+YEBDe27g6E7vI4M9LrVcOKr5o2nug3UKRisEV8RYwpP/qq
	2B+c8y+lFQoiIwbwjKip3E/Lx3OGtKPSppMVDOfpdQszmpa70exfq2cg+vS0ic2qYwMkJnyNcWY
	spsG+Fv2D4LF8ircSep8edPo3K5CHLnktg4vwcPNb2BNUJ9BFWroW3zwfrUUUkvctw7AjplbgJw
	bwMwoYXenN2o/vrJZ88ry6IjrYixrCxT45YzA7V+IujOCW8rCG07B8gkkoR9n+I
X-Received: by 2002:a05:6000:3ce:b0:480:b3:aaf4 with SMTP id ffacd0b85a97d-482b06cc8d9mr343481f8f.4.1787076711965;
        Tue, 18 Aug 2026 11:11:51 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:51 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 05/12] fs/ceph/super.h: convert ceph_cap_snap.writing fields to `bool`
Date: Tue, 18 Aug 2026 20:11:37 +0200
Message-ID: <20260818181144.3541770-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow better struct packing.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/snap.c  | 4 ++--
 fs/ceph/super.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1b904089b56f..51ed5aee193f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3304,7 +3304,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 					struct ceph_cap_snap,
 					ci_item);
 
-		capsnap->writing = 0;
+		capsnap->writing = false;
 		if (ceph_try_drop_cap_snap(ci, capsnap))
 			/* put the ref held by ceph_queue_cap_snap() */
 			put++;
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9b79a5eaca93..94964e0952bd 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -521,7 +521,7 @@ static bool has_new_snaps(struct ceph_snap_context *o,
  * However, if a (sync) write is currently in-progress when we apply
  * the snapshot, we have to wait until the write succeeds or fails
  * (and a final size/mtime is known).  In this case the
- * cap_snap->writing = 1, and is said to be "pending."  When the write
+ * cap_snap->writing = true, and is said to be "pending."  When the write
  * finishes, we __ceph_finish_cap_snap().
  *
  * Caller must hold snap_rwsem for read (i.e., the realm topology won't
@@ -627,7 +627,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p seq %llu used WR,"
 		      " now pending\n", inode, ceph_vinop(inode), capsnap,
 		      old_snapc, old_snapc->seq);
-		capsnap->writing = 1;
+		capsnap->writing = true;
 	} else {
 		/* note mtime, size NOW. */
 		__ceph_finish_cap_snap(ci, capsnap);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a3dae2c0bbee..0d3363b0a33b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -271,7 +271,7 @@ struct ceph_cap_snap {
 	u64 time_warp_seq;
 	u64 truncate_size;
 	u32 truncate_seq;
-	int writing;   /* a sync write is still in progress */
+	bool writing;   /* a sync write is still in progress */
 	int dirty_pages;     /* dirty pages awaiting writeback */
 	bool inline_data;
 	bool need_flush;
-- 
2.47.3

