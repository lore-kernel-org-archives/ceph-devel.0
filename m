Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A83F54C5
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467145; cv=none; b=OvKJV3rUo7f4XZk3y2anQtm7ENipmYfWokOg8URW+fi1zY0n5FtFcDnJAPDR1jWDVT725ZlmLJYCZ17l3hqpvUWkqMfJqiTh/9phLvkPtcpV3PcgmZAp/b9mRf0C735j4VTYYK3pMOtKzFjW0GK/3X6gMEzVwSJXKRGk3s9EAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467145; c=relaxed/simple;
	bh=n6py2gDKtkRa4hq2U3u/EpuJJ52f5YtnTxhElAFdc98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8q6kwhyBrEOwlbF+I8/raBykkDmQ1QHcSOY02r4K3s+vX+rOCMKSmmAsPoYtn616WD4gPLzIGf9IbKGCEewastlZCSKGdpvxTzzwGg9jxj5gMqu5P95OmiABLgvnvoXU/xCCaNNT1aS5ZCAsBFHsvgc2hu3En67hzVp11CcT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHfjrTBm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAZ1JPfe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHfjrTBm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAZ1JPfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaBh0LY8b0LH2S35QVWwlSLJbEkN44+12f5qWMSzHpY=;
	b=bHfjrTBmBtiB8lKT/QdTOrOwf0Iyv4BwwyfmTb7X6ForWe70rJMsVXUzgk2ZmKw4HE2B3G
	YqZ/WxttfQvciydKLvIxl2at6YV1C9PRpAwR+7zRtWCSQFZpY62MBGweNXfxRkyvyy5bTq
	xsnMBJ4EI712TJYCe/pzF33OumVwaGc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-PUt88Cq7MVehETUBLo-t6A-1; Wed, 29 Apr 2026 08:52:19 -0400
X-MC-Unique: PUt88Cq7MVehETUBLo-t6A-1
X-Mimecast-MFC-AGG-ID: PUt88Cq7MVehETUBLo-t6A_1777467139
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-67483b33fd6so10255059a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467138; x=1778071938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaBh0LY8b0LH2S35QVWwlSLJbEkN44+12f5qWMSzHpY=;
        b=DAZ1JPfeKN7hbn9z3FLpbJQ2c6G3lpPeejT817AC0lBkjVHncOi1yf1BFLiHcH1cE7
         9QbRkY7rJauYegwdysm60dm52zuPy64q+IRZv5TlBWjtj8fCSPn51S1Anz78oWr3YO8x
         6elOKcbUMPd50xw47L5WwPC0day/kNgiPDnmiCz7qQHQi9dyRO/4C44dqEWdIYmQkeEB
         XpZKe7p2+yZFMlHf8poKjIEPafY068s43mBuCtSOUwkA/2/+r82J2+OpkoVOoQceBBb/
         OToQv11kXs/SyZ81gOMPqVD6VAkoNnfWju1Y/tBqncZ41v6FXfjyFMN95ylhklCD6sSH
         wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467138; x=1778071938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QaBh0LY8b0LH2S35QVWwlSLJbEkN44+12f5qWMSzHpY=;
        b=Hj/9gJrLM+hoKj0dwWFXU5RHJmYLtvVGUt5k1oetUoPXVwmKkRjY1fUyt2plgGt88S
         ZcKHUqNMyDnEC8aYMBy4siFfeThDyTRNoRcsrYh5y9C0W7Dx0Ivbsa/ucQ4Xo1btfDyh
         3y10kP1MRl6ugOEfkWEOo8soTIJkwBhNme10gr1PTRNY0MHiF4FXvkSpGXpK/hhmHuN/
         eqzSvt1n2OTHm1BcZCRpPFo84QeWuDFfD8l0ha2E4rEdrwyapjTYAqSk06XfsPR2cZoK
         ylFofRD57uf8GEZ2D5Z+L/Ck4HEUeDARSMJT/DceFvYziQ2Lk7oMzt5Nctc1Rbdr6+n3
         S7bw==
X-Gm-Message-State: AOJu0Yxy5WpPyxkxeqz+pjW7LbXrxzG3Mh27SBH5SdQFaCkZVKZEMwR5
	TBb7GNq6bHKVXB+6+ZTBg1PAO7+8LG49ZMux9Dx/pNSLVzqjj2EwEgR78jcJMAmVaSb6wC3QkAr
	Kh74rWB7H7WhM/pFfPui85INaqUJvZaS5b2a6UUuDIL5MSgydUctxVyqoD2//3162nSAIx7nKSc
	0vokfsIRlxtr9ZCY1mNoWk2bGOUhn9u8cnEJhKfi7MXP/3xs/m8w==
X-Gm-Gg: AeBDiet2w6awsrzaxD/TH9tp72zyQPXSWQJpAQMNZa3f2iT7HlkdLVNzEyP2ZSjGHIq
	TX+JHolpMeeD4qQ1jYJPVk72fXlaFrya/xLXFUjyqt9paqCNwZ3C1gkny+BhTM/MqtTFNmbRcgH
	nSPoc7JIK+nWrdKDgOxCMMo+UOfZuj0iZvmDYPQ2AOTycq9NWLIF8hOcEqspB+8UvnGzMGzv+Vw
	vqINx+x/OfA7VaFUQv2GRxunHLKB286RGIuoH+ld4lPXGnE68+l9F/FpAWQ1V5vFjWjgW1lqXL0
	/bD8VbZviPqFnhz8M4aXvmcYn4IdlfpzFKZvSG5ZrfioO9Rq0b36a1dy7u2+0zRLi9UVvXSFFAX
	ntP6U9IvGF54U9VkrDw9HkbEHgFufSSVAoDBAm5foW3nh1yPNV0pxk8FODwSh5WRDMA==
X-Received: by 2002:a05:6402:538a:b0:674:40c3:f047 with SMTP id 4fb4d7f45d1cf-679bb05e13emr3933436a12.12.1777467138329;
        Wed, 29 Apr 2026 05:52:18 -0700 (PDT)
X-Received: by 2002:a05:6402:538a:b0:674:40c3:f047 with SMTP id 4fb4d7f45d1cf-679bb05e13emr3933407a12.12.1777467137799;
        Wed, 29 Apr 2026 05:52:17 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:16 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v3 02/11] ceph: use proper endian conversion for flock_len in reconnect
Date: Wed, 29 Apr 2026 12:51:57 +0000
Message-Id: <20260429125206.1512203-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429125206.1512203-1-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the __force __le32 cast with cpu_to_le32() for the flock_len field
in reconnect_caps_cb(). The old code used a type-system bypass to silence
sparse; the new form uses the proper endian conversion macro.

Also switch from a raw bitmask test against i_ceph_flags to test_bit() on
the named CEPH_I_ERROR_FILELOCK_BIT, which is the correct accessor for the
unsigned long flags field after the bit-position conversion.

Remove the now-unused CEPH_I_ERROR_FILELOCK mask define since all callers
use the _BIT form with test_bit/set_bit/clear_bit.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 5 +++--
 fs/ceph/super.h      | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ccf0d53dde2b..871f0eef468d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4693,8 +4693,9 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(path_info.vino.ino);
-		rec.v2.flock_len = (__force __le32)
-			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
+		rec.v2.flock_len = cpu_to_le32(
+			test_bit(CEPH_I_ERROR_FILELOCK_BIT,
+				 &ci->i_ceph_flags) ? 0 : 1);
 	} else {
 		struct timespec64 ts;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 66b047606d65..30911ccf961e 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -681,7 +681,6 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_FLUSH_SNAPS		(1 << CEPH_I_FLUSH_SNAPS_BIT)
 #define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
 #define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
-#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
 #define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
 
 /*
-- 
2.34.1

