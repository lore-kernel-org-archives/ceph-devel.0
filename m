Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DE404BEB
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283144; cv=none; b=LX8V3+SMUsEAEN/gvkXMEHdPZIF6ZLrIr10CaJAXJdvYvWgeaOpMtzilk6aZQ+FK1D9t1FS6RelYmffqSP9Fp4LnEjqfl20KiqBGiAyYse6SvSpyfa61hflpbO/srYrwWLHCEUUeNJn/SgrbVUWBQhS0D2bPN4UaiiiFDVDsUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283144; c=relaxed/simple;
	bh=8dzwpupltTFCViKBQh+d7RDx4TMXV8dAWM03uOrCOMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2HU1f1a5y1lnjz069m/NN69k4YnU8b+Yx2rZPiL+FyySgxyKrrt0zm6lbYcV+KaYC6xTHojhRaZW/klROkwNktbuWPBtNL8fkqWeqlthxEGbeYxO9M6+KI7IuZOLEttfsQ6l6vuF+jUdqVFTqh9StfZXKeceJdW3ZuzQVxGxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MKL6h/7h; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MKL6h/7h"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so756799f8f.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283141; x=1781887941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaysBqFg3XAXW/YRqT7HNuMGZNj9hUY+RAGoeBz0PF0=;
        b=MKL6h/7hqBftBEyJAKu+jGwezGfUhNfxAMqzQftxAqVCTHLFEinRJyBycvaFshuxcI
         A3DI+CXKkXLjMk21+PJSeFfrUFWzz/WePKg94qFUZUKvdfVe0D6N827OAtY4/GsToadU
         m5mFbSBAZutGZFfVjzbMrVt+VnbPnS6a4cHWfyRflxANnvBXJAuOELrByWMZZq6YmcZf
         xSn80zCVyzWfr25PccC9ht0gBaQ9o0qVOV8WZeEG5CkA02JhAq9tdlLoaqgFJP7nNR90
         XAJcX9/IUJ7xEvwWchwPPwE3nE9QBUDm8jtkIjQAfbNef1ll7WNZcHjo9vDydlC2kDHH
         csDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283141; x=1781887941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RaysBqFg3XAXW/YRqT7HNuMGZNj9hUY+RAGoeBz0PF0=;
        b=kSpi7xLBIxIXdCLK4S3deD6GbsFFzKiUDc9GZNHC3W+d149naxM5Xxh6kDSwzYU5el
         MfpcurPFSWuCrr5WlwwVtYdiSAMrLOdDUP7QElUR7UImxWT4G6f4RBkeXX57GTrkfeqK
         YuXSxqyGTU98xwGK5MhxT4aeaZ6WsfebXLUArAQ8X9dpLyLp9Hv6/ViOf4ZJBBf/mh3j
         ixfOyh0gne/+UKHa6JpfxPAXgnWEtiAvaabEpGZr8WSGWI/LvDyj8q51mBmcSa4mrjva
         hV9njccvg4UbwlbWafBm+t299lUEcj5uR23LDtmGbWJTIZHzos6usMP9CZdx37mQSTI3
         fP0A==
X-Forwarded-Encrypted: i=1; AFNElJ89r3KeFY4Wo1MxFJR8txajJMmLIZiONX8Pf8P5avktPNkf5ZXgEix5J9UzHkHC5PoYNhYrTBAfF0Kx@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4DEVKBbrgXREkFnObc1seVQ244VDu3aAl6bxvBiW5YeQRgdk
	nMlYF7ROqkpwrF1wCh7+kR7lnVXg9nIss6zdI+d/09YiqWivs58rb4g743DR5AHOq80=
X-Gm-Gg: Acq92OGT4cc5n32q1+RwzhL63fEk2GzJp2Cn13VNRYaWc4pT83CmkWGmSFRfqSiE5yf
	1hNwmI9Dn04gs3rNM1XcRoCt1KLIfJFC6HdGiiFbG5nOg46yFU62VPWWInxPEL/fhCUZ9yzKVIT
	J0SOV/SRK98eUkD7ncL6kQAHgDKnF/h/0wCuJUkZXpwJy+zP732H6ZMdW+AU5EhskDu4fgGaVbF
	ZDHZLyP7A2cyDRQAZq70F1BK8aDM4/YzKifwQ7pCs/tkYBDfACUQpHFHpG6STkSm3EOxpCqayim
	frS3B/kXLUkLr+G0TQfBeNgMFrvCsO+8Ee+PWsgHUwCigTgFXLo/mCqJ845BHENBvXKNgMl08z1
	QcWQYM4m0IozCVpaWAyhLcPjDKMiq51JeuoSlqZxL8kn8PD7PBb/5UmmLYiNdB1s5k+EvYMSXtI
	1ehZUP/eld4SbQZzhtxtC9bNJZ0FoysabrXFbOJ58ApH3cuJETC3x2pYXcCKgfQyDHvq6LUdkBU
	Gfe24IO8pmh037lTagE1zN4ktM=
X-Received: by 2002:a05:6000:383:b0:45e:f780:6177 with SMTP id ffacd0b85a97d-46074a64ca8mr43455f8f.18.1781283140858;
        Fri, 12 Jun 2026 09:52:20 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:20 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 06/12] fs/ceph: consistently use `u32` for `time_warp_seq`
Date: Fri, 12 Jun 2026 18:51:58 +0200
Message-ID: <20260612165204.86137-7-max.kellermann@ionos.com>
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

Previously, both `u32` and `u64` was used with implicit casts.  All
this does is add useless overhead.

This will allow better struct packing in `struct ceph_cap_snap`.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/inode.c | 6 +++---
 fs/ceph/super.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c26217ed2034..17df694fe978 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -915,7 +915,7 @@ void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
 }
 
 void ceph_fill_file_time(struct inode *inode, int issued,
-			 u64 time_warp_seq, struct timespec64 *ctime,
+			 u32 time_warp_seq, struct timespec64 *ctime,
 			 struct timespec64 *mtime, struct timespec64 *atime)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
@@ -939,7 +939,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
 			doutc(cl, "mtime %ptSp -> %ptSp tw %d -> %d\n", &imtime, mtime,
-			      ci->i_time_warp_seq, (int)time_warp_seq);
+			      ci->i_time_warp_seq, time_warp_seq);
 
 			inode_set_mtime_to_ts(inode, *mtime);
 			inode_set_atime_to_ts(inode, *atime);
@@ -971,7 +971,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		}
 	}
 	if (warn) /* time_warp_seq shouldn't go backwards */
-		doutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
+		doutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
 		      time_warp_seq, ci->i_time_warp_seq);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 505a1552f355..9b5119b1d0a9 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -266,7 +266,7 @@ struct ceph_cap_snap {
 	u64 size;
 	u64 change_attr;
 	struct timespec64 mtime, atime, ctime, btime;
-	u64 time_warp_seq;
+	u32 time_warp_seq;
 	u64 truncate_size;
 	u32 truncate_seq;
 	bool writing;   /* a sync write is still in progress */
@@ -1091,7 +1091,7 @@ extern int ceph_fill_file_size(struct inode *inode, int issued,
 			       u32 truncate_seq, u64 truncate_size, u64 size);
 extern void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id);
 extern void ceph_fill_file_time(struct inode *inode, int issued,
-				u64 time_warp_seq, struct timespec64 *ctime,
+				u32 time_warp_seq, struct timespec64 *ctime,
 				struct timespec64 *mtime,
 				struct timespec64 *atime);
 extern int ceph_fill_inode(struct inode *inode, struct page *locked_page,
-- 
2.47.3

