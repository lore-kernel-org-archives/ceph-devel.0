Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8FD387369
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596936; cv=none; b=thLfzWPPsNPVa+OKKyMqkhAM8kFwZD+Tzo221Msdudwq4mjWg82WkRWyETpiKmluGFu3eLHHWUVtwB7XsS4ZfIt6fCEbh5azDiZAZ4XkDpIOV6iDMpwHGTX9W4I67iw3oo1aGJOYsffZ2kxSdz7vJpJa/IxQSKoiZP1FCd0mX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596936; c=relaxed/simple;
	bh=H5u3z+Tubpf2cLYERQ0X8l8ceHX8Uaov/HhBtKM5scI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u66wMuUOO3oVtqmtylThaS1t8ny9oiBeuI5gIPRVEDV1PbarPb4PbTEj8tJHIwq1oxvp0ukx5kWiP2uqwVzG9+G/O94OHN3fyfNdBbKIbUVpb8OMRiinlxW7inTG5RGpBpa/YhYDlIEOhel5hcbDXlB+pkyC2OgsZxCcu6pSTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZH9isdwU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZH9isdwU"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c197eaaab00so644876166b.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596932; x=1788201732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjRbzK6XVZM3n4obdC7bI65Mf1F229RRowFXOtJI7ns=;
        b=ZH9isdwUW2SVLVY1IrDFyAHNN+tvkvZAyrKqgCJpQCni0DExhSQrQ0MsIK8fbhm1zK
         jK9tP830ynVjCvD0okOeK8R0nMY9jdJy4i8bsdtHMvkZuRNALa87ukvu4QiJ8CYJkBdm
         EfMfd3aNm76471GXveYPSUGx8lFkDpHhS7n389QG9GCM7u9izgh8KQx+9InwWL4SZTIt
         x27yGWULSv9L+e8sD2hf9VReblIAWe6DgHWqswZa2FEIB2kyNIDYqRHmhcNacxtRdKrA
         ZSIsGGz5HhsdC6QK4iiRx8rECAN2/NV8w8XUnett24M0PtQlofDrN0ulFaPxLLK/IJuU
         nS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596932; x=1788201732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JjRbzK6XVZM3n4obdC7bI65Mf1F229RRowFXOtJI7ns=;
        b=YmpkgoPbm86MNF62evfR/+4I+Jp7PuV3uYNMhbIOxW+fiqwKhrty4vtqUnmFFS4s2n
         sGMTMNksNU5qSJ4LrwFgcQigYBmtZYRzWV2JWt3a55Q7rbzPM6WgKH5YE3HM5wo1zN1U
         lHY/HJ+TSiMKnS8pRIG6Bq9rfPNEVBudVyNJpLTb0AH/8m1XcVGwWvTW4742ghkI5rd0
         7/xtOWGEp8QBbtqchtMyPrTchUhtr8LMhssJvgArKZ+zeugUl/aB5fbC70IS+o50Cc0i
         WfOPuTyBylc2rJx1tJLViOc3m1n2idaP4k3dTQc3AmX0TIGwMtN9lfwcQxkWba2zwEoT
         6tsw==
X-Forwarded-Encrypted: i=1; AHgh+RoPKleI0+zmjMJpGN+xS7jr5GRhNjEMbSh2CimVkJO4Lk+5FqUXVFolNuE+ecWGS0TuxL5+ED+C5Fj2@vger.kernel.org
X-Gm-Message-State: AFuF++nEtxuOComQ2SKgbFx5ctHfa23qk0XBtpleTjsbB3vWpB0AjGcK
	HLYaoLN0QTq3tipHv7Ntv1is4mwzKNgbmk8wLZqnU2fzfg8eBe/E1pLrEZxwZ+FZHd4=
X-Gm-Gg: AR+sD106h8l3UgV78ffTxsKqD2YEtFHut2Vdkv4cpecz/kJrIj5uLhN98WCOFM0JgsG
	SPaWRdBLjWvEjvfcQWzKxTifl8QQVOukYcAYQLypby+eTfbmephv1xME6zjFf0i719WwXWPl8Gr
	WCQ/1dj9/5aAYaot3WeXW2/uA+9nwkIYtnnA7Q3sJx4bv/3E91AhiYl/1E6Mz6Z4NxIdHMm3Gs5
	Z1OZFRP1EKhRmg8fpcXoV1Enr+a1bjOeFYJGS4mJNLeJM0DFv9+viHukEL0Al+DK9nmNSnhxSBt
	/uRyV1wmnv/WdRQPbndmpu+BojhXtg1BQwOj9cF4CcKQm3nLwslkpvC0YrFumVH8VOl5+ZHnl4p
	A9h17r21zBHdgYRbDen5W1DCtxgRtqS+KMKPpo8f8390ZQ8OPSm4lFfALgpzd0UcqOZPti9v3sZ
	5/1/Hvs15e+GK1xTxFrz39MH2AMQvXLmWd49FkyncrCJpLLczdHSX4h91yCQqxFqmE0BkScjNXs
	tRCHwQKsGalWQfnfhQ2LMoaWeRphoGMbxHn+vSaHaMSyS7ylMbhnrwn+EooMUqY
X-Received: by 2002:a17:907:3e98:b0:c16:8adf:f183 with SMTP id a640c23a62f3a-c24e5fc4f6emr35155466b.14.1787596932328;
        Mon, 24 Aug 2026 11:42:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:12 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 05/11] fs/ceph: consistently use `u32` for `time_warp_seq`
Date: Mon, 24 Aug 2026 20:41:53 +0200
Message-ID: <20260824184159.240821-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824184159.240821-1-max.kellermann@ionos.com>
References: <20260824184159.240821-1-max.kellermann@ionos.com>
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
index bdb82f123033..ce793ff934d0 100644
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

