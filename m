Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE43E1D02
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2026 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614859; cv=none; b=QMk4jiE4TEVaw2nFiX8gKJ/TH99bAVfPLMb1CKndUw2HdrSwz92wdDPF89GjaoYDWdmB19eiA3ap+5xulF3uy0bxHxA2CBw7XTp6efsjJUv30+DUsljGP7ptNj48emDXEDSf4QHu7kPuQltBbew5rOYC/IEih8a+KED2SHzFtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614859; c=relaxed/simple;
	bh=0Tj3LFCBAm+Dh1IEtEUuQKH6g+6N7pgBfSJCYkAPS+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZNGOC4eZNWAYNj29i1OvNPQJvXJ+WVfejlBpXkbTX5p1y8XHbbZR0+rP68eubo4RPz79UHVNkEJ5ps5r6AoDRPWIWbdZLtLBxwhu2houC/QgLmEyE8th8xj0+UjTUqpIE8bdoPiS9XFVy6DvF9NCOSzApX45uarZCzti2+3YOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FLtXprgE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FLtXprgE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so82783985e9.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1784614854; x=1785219654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7FP3MNblmlu5NslE4mpBL3j8Z5Uszv4ETHx5WOrkF4=;
        b=FLtXprgEM4az8nM7wvkDS8KQxb3drFztE/mRMcJ0vE84aaYzVKM1dcz9aVz9Z6Sspr
         sBKnXX4hAzUA4tOB4V78/nkdJLXo+tk9KHgquKxy7JrMZj3pRHH3awrxhtUgFOQtTHwc
         Jpa+rZGbc2YyrIeZWrv+jqIeWLn4t+KIe3AVFV3nEmsNgnehWs9P08Q/avRFw8RNkfv9
         RIxQfE29nf9P7GxcYid24RoahOXtZKwInJ8gcuR9ruk9r3SaH2WgxZ0FCYSz9J+KB5Sb
         Bt6IpzGfTjN7/89V7wGAqXEAxH44ks4c1V8mGZpSZsm5/hq7EjLj3YBMPLQyonGkTE/Y
         pYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784614854; x=1785219654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7FP3MNblmlu5NslE4mpBL3j8Z5Uszv4ETHx5WOrkF4=;
        b=jH9fvvPdaQzPEtWl6k6K5+ra8PMv+HAteG4w+CCrtE+mjEHi8Ds+Im5C+IOIg0u+rk
         7e05ULlPZIrQcQipLuoiZAUYwPQnH4L3ecHre86Lq9VApKyXgx+hbN9/pTcgIt7aeoBC
         NVCh+Un/xVba4XQte9pmXeTzPRTMNx2eZDdeGeQCkAyVRGdxfcwzZ5T/h2OBx5eK3mWJ
         PpnwfBMaVMEH6Sh3vOqLcPql7BhUYzcIt5fvOyb3NZzVh6V2VTfz+kG1MxSrly46LVQu
         L3Kvh1cz5YUGmUdCamVUiD9dYYOrwz6grndv+KWvuoYJry3WsG+Y0s01g7dBftahi9UK
         UQvg==
X-Forwarded-Encrypted: i=1; AHgh+RqSdxtXU9GVBuEXNfh01FM+u3WLym2PqtwDhx3YHmMXvpzcJkuzdMuKqAA+BrjYF6hCFhqUAZCdIbN5@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmsXcnk9rTu4oa0qtdWjES4icX2N+DAbZBKKqJMngbBr2e6aS
	1og3lJy7v+prTFJcp0dI9L33ZqYXz8apuCqDfGeX/Xwlpy32jytyp86h8EHR5WVq8fA=
X-Gm-Gg: AfdE7clj7S4ARIKg+TieIWvK02J1kUDsedGezjaGSzvxIjt8hItUKZvQUC1aJPCMzdh
	V61evBytGwJUWw0Xx8+07PVap4prFv8yx6YcnoakF5iYS6UNY+XJc+1EGWRrzN79G35Cb1CzVkz
	+oMEZfATLRWXj+9OzRiNJolZZtpRHcicM9e2M0Tp4EVGlF9Kdn6PmCRgDGp2l5SXS/tRzyQ64gK
	nLGMJnRHT1ysdQGjb11tXo4131qU6PokfLyDshyS1Nj3YraU35uul5d/5tkYBqWYL1txULZKarj
	XTDbQ/qN5Q8pzbaCULjfxdIcSqFnOqeQROmF0JFfVqGyJlDGxm3pnVGtep0jCyf40I2doAZtuzB
	bVy0NJYUXEXvSmIOtA+u3f+yDfj3fc3fmR/gJ1ppxI5EiARHgho8vMoslruQCLudD9YZH7o7iSF
	m4Ud43cDihjbjmqRzxIQqjUPpndfLIJp8+8mFLmBTaK4muIzxF6vnoRUgo4ZMDssDuQuMrZFhBz
	jddKg==
X-Received: by 2002:a05:600c:1d18:b0:495:515a:dad9 with SMTP id 5b1f17b1804b1-495515adc7fmr142513775e9.37.1784614854456;
        Mon, 20 Jul 2026 23:20:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f484700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f48:4700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547af7esm47681535e9.8.2026.07.20.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:20:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/ioctl: add owner/capability checks for CEPH_IOC_SET_LAYOUT*
Date: Tue, 21 Jul 2026 08:20:46 +0200
Message-ID: <20260721062047.3162957-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These permission checks were already missing in the initial
impementation of these ioctls.  This Ceph allows any user who owns a
file descriptor to manipulate the layout of any file, even if they
don't have write permissions.

It might be a good idea to guard other ioctls with permission checks
as well or even disallow regular users (even if they own the file) to
manipulate layout settings completely, as this may be abused to DoS
the Ceph servers, but right now, I find it most urgent to have setter
checks at all.

Fixes: 8f4e91dee2a2 ("ceph: ioctls")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note: this is a resend.  I had already sent this to security@ceph.io
and security@kernel.org on 2024-11-25, but the Ceph maintainers
thought it was "not a big problem".  It was never merged.
---
 fs/ceph/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 15cde055f3da..de07f19b0caa 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -72,6 +72,9 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	struct ceph_ioctl_layout nl;
 	int err;
 
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+		return -EACCES;
+
 	if (copy_from_user(&l, arg, sizeof(l)))
 		return -EFAULT;
 
@@ -142,6 +145,9 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	int err;
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+		return -EACCES;
+
 	/* copy and validate */
 	if (copy_from_user(&l, arg, sizeof(l)))
 		return -EFAULT;
-- 
2.47.3

