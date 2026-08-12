Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB52EEE88
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566608; cv=none; b=kLGHncL8dMgD7CRuyeZxd57LWPKSXY//mWfdJh6aTgQmtkIPfffUnrISkpo+YzldsMTCMHfPT2/msz/XoXWrR+5sHi36i7vKEfKwM05PdWjQ0sHUYLHwMdL2jHFaAKHZVPknbh8XXuxoZKmi3zpNOOAdKzcx/b/waB46Fu4rr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566608; c=relaxed/simple;
	bh=M75HovAwVxE+r0W1d1j99uEBsZ5rG6t5WcnCQiQhemA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiAG0WW9PYEmSee3A9n2nW8eOWKAM+JOiHWXN881VMURZHdBaM9m2hK/V7IQBU2kSFkJ/nGfxAgzjQtYXzPHR8HHRwN3eX9dvxG8Nk8NMR/Z+m7YuGWGfoWmFl20yykp77YFzTue2IMouM3LmC7zCd1JTkiv6alFaaoPClwZxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HAPbrm1u; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HAPbrm1u"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so1092976f8f.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566600; x=1787171400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crLAMeWTSlyJshBmHidF2nl5stcAZaMFUr6sZlkiZkU=;
        b=HAPbrm1uykOG2uSfUFY2n4gMRjTYej11d38/8ysHWdOAQ5+Tq3MeFypz7MIXKNK1Bm
         FtiCf2uzrqXa+243GntZzIijWu9UPeiHRyKF2HSbBfWsvnG0zge2XsIjqVI6oIdiZmmw
         fBwfvmSZUiQpfWVfe7vNucHknkwQ10wNoxRaevzEYzJdVgtFt8Af/BBvlsbg5W9fCJk3
         CXSzju805jgfU+zzRI5Btj8UYAdoShJkPHjb2q3ZqBSf1fNxO+uGrWgTbDihXnXd9LSP
         ttNGdzvEzn1GWi1aBelEbDpaV0j17Lnpht92Ys5JAHG0XvQ9aL4LO1zMLz+enPCZtzBq
         6gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566600; x=1787171400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crLAMeWTSlyJshBmHidF2nl5stcAZaMFUr6sZlkiZkU=;
        b=cnBILE9/h+x/NpXR8oVui41x5/3SFhdtrMpqD9K9blAhe/DOjAA9ZQwGcWWuj9yScE
         GCZh5Yz9QEFNlDvOdWdQAeL/tkfOneWXDq1m+GDikrzZZPTeUxmaFVkF0My3DQz8nLop
         oRRXrsQfLIa4LkWQ6sfdKE96+b7oBDdn/RmHFqyyyniup9caKSrHDuREmmdS73/RrbRH
         /Qux+W7DicMnEWFAP46mEBbkdyRWH0wvqqg2ObaWkVltmj0lD/U9uZQbNvtAXHxJcrnn
         7eLooIgA2SS22MVAFAs8pF8/KSiWOO1jRI0qqxWkGIyAzZ0TQ/2WpxVcHqXVCR+tOLxY
         bjhw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0zuyf1zEOVj9UnNFjGmD2a/3QhsDjtwwUQh7fiPqlerS5tMKOYaSwN9LwayN5TTMVxD2qR5AopERz@vger.kernel.org
X-Gm-Message-State: AOJu0YyS67eKFJlnZGvXYws+MFkQnW2mzwLo7WmHvBzv2DiBGZrGExhQ
	v2oliJfh6TJ/QVdSXI0WJORy6UBl4jGKHWtBXpUAnv/I9l2VarfrsPOXlbXYIl6HTUE=
X-Gm-Gg: AR+sD12ovFWdJeIsFmvmT49uW6t/8kIO4WUl0E6a8fXbhibUsccN6ZMAi7ecajL7BPU
	SG2hUES8pie1I7A5T1EI/tFG38/OnwFOIH5y6IVAc3+2WG/M5oseEhOAn3HgFLWfyCdJ3JcNKGs
	PJTa/fSFxb+V0S73X7ZxmTjZh4PdaEYnLztZaH7gQtZEUHWTuZEr12rUSpngWtKyW49ipdikWQq
	TIjkT1oAR6mIzoFlYKgQJialoJayotd6op7R5yimiqKrQeZz3FVTQ3q49QN5ALtB89IDFdbpLlj
	Ctg79JLVcg/Z3SGw9yorHAAJQqMFgbBdIlu7tT19JKTjMvWiRgMT4bnwmOoNvUIK9ndi73vJs++
	8b+RjzA55BwugLes2n/nO9Mf/gCDePPrajEo4l1EnqzIbtWfExgbmttLNvyyb6f4vw/Cq5mxdoa
	rTOdQ5cxg0eADARKY2pwwmqbhO+5gfw8R+8laq7aIfH8DR0GTtXXMKj38YHUol1oZl+QxKwKGpo
	MAE0B/OkGxh9isXcfhWnicxUgkS0AZMTO1oR2+IZlkLuh+nL/MdSwyhOhGgtrzv
X-Received: by 2002:a5d:4acb:0:b0:47f:d0fb:ea40 with SMTP id ffacd0b85a97d-48159ffda98mr775975f8f.21.1786566599907;
        Wed, 12 Aug 2026 13:29:59 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:29:59 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 06/12] fs/ceph: consistently use `u32` for `time_warp_seq`
Date: Wed, 12 Aug 2026 22:29:43 +0200
Message-ID: <20260812202950.1800340-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812202950.1800340-1-max.kellermann@ionos.com>
References: <20260812202950.1800340-1-max.kellermann@ionos.com>
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
index cd1e09c32eba..e79ba09f2cdf 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -916,7 +916,7 @@ void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
 }
 
 void ceph_fill_file_time(struct inode *inode, int issued,
-			 u64 time_warp_seq, struct timespec64 *ctime,
+			 u32 time_warp_seq, struct timespec64 *ctime,
 			 struct timespec64 *mtime, struct timespec64 *atime)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
@@ -940,7 +940,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
 			doutc(cl, "mtime %ptSp -> %ptSp tw %d -> %d\n", &imtime, mtime,
-			      ci->i_time_warp_seq, (int)time_warp_seq);
+			      ci->i_time_warp_seq, time_warp_seq);
 
 			inode_set_mtime_to_ts(inode, *mtime);
 			inode_set_atime_to_ts(inode, *atime);
@@ -972,7 +972,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		}
 	}
 	if (warn) /* time_warp_seq shouldn't go backwards */
-		doutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
+		doutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
 		      time_warp_seq, ci->i_time_warp_seq);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 0d3363b0a33b..67411a5d8b91 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -268,7 +268,7 @@ struct ceph_cap_snap {
 	u64 size;
 	u64 change_attr;
 	struct timespec64 mtime, atime, ctime, btime;
-	u64 time_warp_seq;
+	u32 time_warp_seq;
 	u64 truncate_size;
 	u32 truncate_seq;
 	bool writing;   /* a sync write is still in progress */
@@ -1099,7 +1099,7 @@ extern int ceph_fill_file_size(struct inode *inode, int issued,
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

