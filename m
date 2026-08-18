Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390A485CED
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076724; cv=none; b=qhwOY4NGlz235e1foQW/NM1p3kd8/1BkP5iqK7jpeGY2bI6uouAqdh29DZwJUFcGuqGAe5kudI28OLxJVP9opdO+KR5P+t+iTwim5MkSaL0XS0sXop/t6NbnyXm4DpC1cJrvMqFyBFl/QstsdlP3gIbREdhp96Yrn0UoMSoe1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076724; c=relaxed/simple;
	bh=M75HovAwVxE+r0W1d1j99uEBsZ5rG6t5WcnCQiQhemA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiVFHnYUsbz07Pj24uCdVyYpNmSBEeixes5RO1sxdU64K2kFytMTsHHOXLA5Ks5md8bGznQmM+SXUle/a/t21oNCcZEL2ubLIJrlfpIha8xB3V7ZN4/7sh7//ORNCb7EvDEWcr6h7yP+zaFqgiIoMjNbF1zS0V2pvxMxw0ebhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=P3Qdo5iN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="P3Qdo5iN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-471eeac43bfso64881f8f.3
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076713; x=1787681513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crLAMeWTSlyJshBmHidF2nl5stcAZaMFUr6sZlkiZkU=;
        b=P3Qdo5iNsu75bIfq4Upk+4ktKmRR0WjDPHvmEudtTtp5vINYgIPJiyfL7YEjbTr47h
         UYMBSDv5uvBvptTAVoZgeC0B8WlAUx6K/VkWU3ofmDi7jEzUYSUGIdsoHOjxEAkIHef+
         imjC1P18CzqGXiwa6Hv22AwMK6POzLhMTRbE1YaKlcpd1RIRxtQZBASC/J07xdVxWTyC
         FecnF3Ny0nsrlCJImIYw9Bh2RKByeUTPy1rMQHrkh8Q7Oj7HwBYtTxRVPqSrk9yaV/4+
         //R6HE0Z3Wp6DKStRtSgMXorNEZcv84jC3DqEdRfKzOpwtLzVzDvCl3B+Yxhz91N1UpU
         HaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076713; x=1787681513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crLAMeWTSlyJshBmHidF2nl5stcAZaMFUr6sZlkiZkU=;
        b=UV3x2BZPLNSYkZD40+qYi7WbFKAzzbY7FBn1wkcbnJ43RYrol0WUTEusF14PnpMjKd
         mrYq0gcoLtPpUSxxjS9kaz1IC8zdMtQvKJQGZZlMIlBmVYoIWudMwwC1M/IHfhDYeyMb
         nBIPzMKXIxcdBtNbbUcYlxdAp5/jpeKc8kcSO9r6Dc8TKfB8I2TP3tl8pMAiB5zxVZLY
         Pczi95zBKhrXY04ncFMEUIyTQYddGLcuc798V5nmeSHD81c+g9lM0f+N92qr65pW+5CD
         gDVagOsFf58+YNiIeVzYo2sE5aEmcvYFHDejBk+0clDPXID+4qYrB7gRFkBhmdBxyKlU
         ek4A==
X-Forwarded-Encrypted: i=1; AHgh+RrsKZad8XKz8kupJIj6uXz6C53Iy/ZxZzx3L9zwTcHjiUhxcXTtFsOAscmc9P4j/dxHwKNBtiVxe1BL@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbh7d0C/0cYmOaiHlk72/ijnwPnljS2SQ0fa0lWk2YqH46UGS
	X3GZf7XN+sVXnTEfCzEOVz9ch5vVXvYf42dzGOfslQGNfjoXhnxn/d2ECzUqR7LrY+Q=
X-Gm-Gg: AR+sD13CSPkHroNyS954OoqQDScoo66VKt9T8fvPIa/hPjOzdlTjK8/yJby79MW5UlL
	nPWVKQVBoBwx20njX712bOUNGxLzyPpOBsw/1f5RFhrgb1lC3YJlwHAzWKW+pOoYvwm28idBlli
	COLdazGb7qjKUADZMZyS1J0pjEPHUKma8U38a2UcHp3cdsTxYzUnBP3UK3JHVdNCGHcQClkr+pL
	fnEsCwwrcRkL76cB/HF2Tx/EwJdVRPERc0Qx6EHNR1oxIXALZqmLpNiI34sBWV/2hHGxaNzR1mp
	QTZ6NUuNEF0hGdCLxwaL/V6LblHwddQbXHmUhQ8OXhOqH/oNZ7PNeJWeeyNUfgc22Ln3/cAod8r
	vk/eHHB8wEIU6dyQ2rwsKeZwX01Xwql5GdEK1xAKR1vs3AV3MFgyCQo4iBoOI+IgKgTNqewDDba
	ypqJajtUSZ+L9QTGnk9G0X3qNPD0KIqX0WmK8CQzbNRbD7JS8oxyyanX0UGrwltSd9Rwc9fyKom
	r9DhYZqa9TKUy7X3P0jdxpcb33bL2HjN1V86NrUeuK1Lx7nnFEq7MNcr7JV9JGFMzsJf2ny7q4=
X-Received: by 2002:a05:6000:2406:b0:481:5021:33cd with SMTP id ffacd0b85a97d-48160735191mr51429862f8f.3.1787076712695;
        Tue, 18 Aug 2026 11:11:52 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:52 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 06/12] fs/ceph: consistently use `u32` for `time_warp_seq`
Date: Tue, 18 Aug 2026 20:11:38 +0200
Message-ID: <20260818181144.3541770-7-max.kellermann@ionos.com>
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

