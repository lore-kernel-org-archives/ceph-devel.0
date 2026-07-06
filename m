Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBC3EB819
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322727; cv=none; b=nIlfrk46RdIDkjEYw8VEZOs3nz3kdffiRuhQt2T7VlkdhI5Yv/iSLVbFpe1sLdOZ43ur/XqLaQWBhrEIkgYV/zQSonvWlGtZa24HywVylqYACApF8MDgbpSjt0a7CASx8rvCf3UTPR/VRfyyDG71U5YqJdTHRCFbFsMDNL8aTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322727; c=relaxed/simple;
	bh=M75HovAwVxE+r0W1d1j99uEBsZ5rG6t5WcnCQiQhemA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFiZOS/ljPQhTFmsdkplwoZceSdhyrsY0O9vo4s9Tobr651/jCQfjrdbu6X12tKRa7xXOtQl5hXcGzq7zYQHWirofl1byaT3/8tofPLlHzoptYwxRMPYrJrwSawsuNqtU5B6/H+t47h4HdJ+z5inphHcl/INKZlatXNPrY44iis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BebrNj09; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BebrNj09"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso500433f8f.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322700; x=1783927500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crLAMeWTSlyJshBmHidF2nl5stcAZaMFUr6sZlkiZkU=;
        b=BebrNj09BRNRUKGBMwAoRBPL59saasGkrR8R2y+TshKCCqgL8mZcMYylw/hTiiFI9n
         BewLeBvH+Cfa67kLbpOIU8W4s2FiO4BXLc/CdRrPdmBGE1G0ijnEhCebeGbSms0FT5TC
         pU+C/IBHYj0SbecpqtG+ys1BbkQzxH9Xa6dTXGrAafUr1GooY628vFXlbpUNR3MouySm
         PDEiL8Q5sMaELNtWbApZnUxrcmDHQfJHLSp0nymEDnF7AI3DWjkqx5xBwfL2KGmKNMjS
         68JYW0KVmxmAmp32KgOPOcwfc2uH+6s6jU+rsBWD0rBeEZoV7bNBp/46pEb/g+WsRIxO
         Weqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322700; x=1783927500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crLAMeWTSlyJshBmHidF2nl5stcAZaMFUr6sZlkiZkU=;
        b=ZqfngZchkkxf7TMzKxqTvmJ/1NEyblD86/qzQo156RiiJJJBImkWk/NxJGtBoJYXd+
         EMRHnPH7dFzfOurfuHxsRjUw6OLwP44qyXvUbQ+3Jrq9YA0qA4bA2kErZhiVJCPNN5jL
         j4BNRtMWXNUyX9xI2cpGsVeuqPVkgUPymfsXT386PMf0RIKRu5mjzB1Gzs1WsX1gjPjO
         NXn6fzAcrLbToVUtWmdwbPDliDpKj99zeTCHBWdVz7oYXVz9lc00NQrjExQdcqPKXl3b
         nuNkU8HKW7rMflSQoL1Fu00ieG0TWfT2uB/NLE1RtLCZrpXjhLuxxwf6XhWgsaZIBkHi
         UEUA==
X-Forwarded-Encrypted: i=1; AHgh+RrX4GHGpTk/E/pQbD/CMGnlKpKwfXML0PAhVk4mAxvP/pmuzo9czLiYuBinOJG8tvxdTIGeNYKdqbXW@vger.kernel.org
X-Gm-Message-State: AOJu0YyURh2fDLMlewojdSVtHy0flIzY4cEL9zGebX7XcFHTEkpVYfJm
	e2rPFyk/9ObrWC/jJ12G8OQMsSrCxxFwq9psdYxpcGIY9jnz1Nci8Fls+lFSWwnpxis=
X-Gm-Gg: AfdE7cmx8Z3A1uw0PjtQtSRSkNMsNN8IZGhWDNn/7QFcMG2OF+swghdT8/mAp6m/jtm
	5JBTu8FmKX7OgA8oKEzPS7Pczt26FBHKFFib4ESmGKMDyGVfue0Gu3vL0slMx+FVDeI+UBiXOBq
	VAjZfrrXObOIoMU9UDG/ivpV3WiMXyhFA39X7mbqigeQnVgHKZ6ItjwPZaZm1UC3WV97De2mNbw
	j2ft9SuS+KmgGzYgEfkkuRKjDMjBWkNa09H+Z3EuEq31i5iFU275BdZM0BTOo8hNQmY7bY1zEZL
	C/GR8ApzQeA+EEH1JypNBQqfS8tUfCiOyS22dlJUUKnTe6NRZLH41hO1YrueY5vWKebtyWxMSfp
	Yena7Zj8GIveZf0yNMhU6aesLVz1Fm/PPl48z4kuZyCE0OSiJYj7g9Z9lztQpMVaW+ULTzxtsMi
	I6fJUZP86+8bw1nax3gSRvytOoJ01WIGBM+zVaGV+Wz6EnRtyI852S8fGPTWayb+hNIvbeN3uBl
	F3mxHWW2YFTEBJsTxR0pR8m+uY=
X-Received: by 2002:a05:6000:310a:b0:475:f0f0:9eef with SMTP id ffacd0b85a97d-47aaee4c661mr10495915f8f.52.1783322700149;
        Mon, 06 Jul 2026 00:25:00 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:24:59 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 06/18] fs/ceph: consistently use `u32` for `time_warp_seq`
Date: Mon,  6 Jul 2026 09:24:37 +0200
Message-ID: <20260706072450.3920010-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706072450.3920010-1-max.kellermann@ionos.com>
References: <20260706072450.3920010-1-max.kellermann@ionos.com>
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

