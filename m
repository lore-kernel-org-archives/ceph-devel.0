Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E380346A19
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116878; cv=none; b=o7A9Les1WBOshb9tkaDx0+GoJgOcSNfmunaP8Ffdwje8UV5FKwny+oLEyiUQpvXfAgMPnBxs4H9zFbXuRUsywi4C8GBwugAaDvoqtg2HZIUH2+BnRLP+eztiNL7d93JlF/yI+uRnQH0gsL77k2dsAtR+0Hyk350YwtMTh+FWJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116878; c=relaxed/simple;
	bh=AVsuJJQRTTWoyOJkTSi6fUKZFteb6ITubarU8DpDMps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enB3oQ3/LIQ7K+R1cOU0PlgwAzeFifFeFAamweyEWDyhzAwoREjp6Nocn4di4w/UkMdhkJrWdMF3LBq45CYT+j2LX4C/1Et8WXJE/tKi2KbUqHWQX/VZRJ2rHFqkO5Oxhie8q1bOd8/tWSYSIH1dds8ygDmnSqBtQDMSHEIW/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjuZaRBu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjuZaRBu"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0ecfaee7so14872641cf.0
        for <ceph-devel@vger.kernel.org>; Sun, 26 Jul 2026 18:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785116876; x=1785721676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSqmJSe12HqDp26C3dw3gZtstJOdYyHd5Hf+ohShs7o=;
        b=TjuZaRBuWsTSZDd6LYUBMIpVpjNpnd6zTAqOA5T3UJjkqYIO9524K0741hhEW6aK7F
         pnVJqHJrpgO99cjFOdMCx0DEHMcWmS8dRptuXvTSjDV8pgmVTp95TTJ/hqqiGEhk83zp
         s5bABNdRTUlasmZ1CISct27u80dzq83AFg3wnPuLZGhoXRFs4UsMqgsWI7VKiB5ZeJcI
         joxIvnrp5ik4PmItocdIkAKKoaouIL8qaWFVL3fCPsh4wPCd9x9KXaVEBCH/hMCrEBUu
         RxxlmE1rEEvMEkzcgJ7hxbmbKs151lozoFfY2146XfcugnYsTFn0tLgnmv7GMLjclgrF
         tfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785116876; x=1785721676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSqmJSe12HqDp26C3dw3gZtstJOdYyHd5Hf+ohShs7o=;
        b=GGp7X5N2VS8TQ30CgX1O05P1UVvvg/mD2WAStB5jrgx4HmYW5DC8qB/T2YFcvweP1R
         At34STeu6Sx9lhVm9Cxp2GuDsos7F+2SkDwPS238Ot77+34tToEkc0rZGle9TlBWbfEE
         fn20JEl4yES1dr/Vr+tBam+KdgkCCL+P1Tz+19hnGLaWwhNenokwyJjdkxuCyr60jKVr
         V1Kwt7V5RP/Fzs7U7NGE+78UX1F1tMjEpX9BX2rHoBaW717ULtmBG9Cg73ywO1J2tv69
         2JhapUSDQtP8lhrtybYQf/Z9P1K17XzGeaqRSyP9nDPwj+JBrPvurJoiDKWtqpEMt8ec
         j0aw==
X-Forwarded-Encrypted: i=1; AHgh+RrCRC9PiBmYa4Iq/BNevV15ebh6tl7tuJeOV85/Mw+6aFiTyl/RVExAp7rPsCNv62dWo6sy6NGzVOgL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45Taux4kFlNzW1J8/ZcEF9+Ps/JzideLlUSjAhMUbDr3JAvxw
	KtLdpMsJUOYX7SVdsvAcuJGB/80+sZ2Eq+uRFj7wf+tpW1QcDh3QD70m
X-Gm-Gg: AR+sD13tVWmOO0MYK0rDP3ksIl0RCVBEBCughPgsUUbyYaLJ2G/OjHuu0F/Oa6KF0v+
	PCASA9HJaqoFD39co+z46S/O/81nU10Q3sd31yE87J5Rc4xGzZtr24vnbkkIYtYkYFG4yPkW8sh
	EIUt9rRvE0d0SACSu9QedHg5XCGdqrnQzt2+lEGmb5s3wD1rBhjB+TX9RYOZnuS3AcdjKS1Mnjz
	rQGDITaPOEz0rL5/uCS+ZSWgnXKzKHB29xgibzUwRXkUzg4k/kX2KICLcDCwS31pOeN7C6r7TnJ
	rpVKypI4BKrtPE6zncsiUdZbKD/VKtpQxKEONz3BNg5nTWDkeAjI2UcFx1kRYRiehC11Y5THBFo
	X7Y85TlU3cP3ZAOMc3fwMqkciG6v2p0wAunxsaS8Kp7ocvkPEl/9HJPTY/hId8ReSAA7AML2qkX
	xmOwEfTPGZ0biB5Wn73A==
X-Received: by 2002:ac8:5941:0:b0:51c:a8:51cd with SMTP id d75a77b69052e-529a8314aa2mr63874141cf.1.1785116876145;
        Sun, 26 Jul 2026 18:47:56 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2989b24sm44064281cf.15.2026.07.26.18.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:47:55 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: use the mount idmap for the owner checks in the SET_LAYOUT ioctls
Date: Mon, 27 Jul 2026 09:47:44 +0800
Message-ID: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ceph_ioctl_set_layout() and ceph_ioctl_set_layout_policy() call
inode_owner_or_capable() with &nop_mnt_idmap instead of the idmap of the
mount the ioctl was issued on.

CephFS supports idmapped mounts (FS_ALLOW_IDMAP), so on such a mount this
compares the caller's fsuid against the unmapped on-disk owner rather than
the mapped owner: the actual owner can be wrongly denied with -EACCES and
an unrelated caller wrongly allowed.  Both functions already have the
struct file, so use file_mnt_idmap(file) instead.

Fixes: cee38bbf5556 ("ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ceph/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index de07f19b0caa..12cb50e0a166 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -72,7 +72,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	struct ceph_ioctl_layout nl;
 	int err;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EACCES;
 
 	if (copy_from_user(&l, arg, sizeof(l)))
@@ -145,7 +145,7 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	int err;
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EACCES;
 
 	/* copy and validate */
-- 
2.43.0

