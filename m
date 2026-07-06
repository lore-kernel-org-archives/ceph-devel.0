Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9F3EFFA0
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322711; cv=none; b=dqVVGW1WncwO6YMzUEClPB80HjxBxR2HWVNa+aqwvt/LK4nk8YBGpkSapzhID7PZ+PU8G3MbuO6xqRRXDUfjLXTuyTjLlpKJqAgFLnrWkgXWhK0gj2ngUpwGTj5Bj4XqomKEnIk3lgFtJhJfTYhQlgyNcWOYBcpV1S+zy7k8BAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322711; c=relaxed/simple;
	bh=vZ7gRo95tF/kqgzTVygqtXNVLMo92lelt/8iAfWrtpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgYNT1TPIXTuW3Su1p6FVceriqMIbrv/qpbQK/qUygPjTBhlQmbgjMYZag13NPQTxA3xmGZLFVFHed9eqEB0pnj5yLW51p9ZUgusLamasRnEkIFpOZiNLuGA4maOzDFo+7jF6k/ChYDoL81r6KIOm5FC3HoglxwpC7P+Zhdf0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Rs8ocuvc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Rs8ocuvc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso606870f8f.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322701; x=1783927501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h3RiEJriMYlQ3k6GEtIrqFIdNALC21eRy/CEabRiBs=;
        b=Rs8ocuvcHCMHQZvbJ5nW4FcGo72nCBUj9DcnIQFVCWhR4J6/v4ngsVi8ey69BF2iC9
         rjFj5TdpUX878/YhlHmJ3UwG74X9K9nYOeVD/5nEFOhfGG5HvZWgfjdorzs8AUivA5RL
         yhpcNYfmjPDUiCz7TCRIBAEORBJycrKZTsY7FIIZwCtnOEBoYNFtD6IfVXlD5AR5jPyF
         j0TDuMVHxqifsOJZdRzN9ylBbPsCbLW4n1DX38ABEwvRcxugMgIbMHBqDaer6+iHColV
         kV4wExJ13wJsG5AvICE1jspgCBqD3OwTKVF8jR6cljq7vQmSQeZBI1K/yFDSrsdS3T+V
         y3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322701; x=1783927501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/h3RiEJriMYlQ3k6GEtIrqFIdNALC21eRy/CEabRiBs=;
        b=cmOar4umP9kDLbKCLqvClAoBZmJwn/99B+iveqzAG89eUk0pv2/cDsG5oCKLyl3Uma
         Gq8kbC8vPlrglPgy5Z9eGR+hf5riixI5A1MxqS7PEI5eGNyhujwKsK5HBgE8T4lS/U4t
         LPvND0/L2mlBbFQJgvIIifzO5m8Kq2H4iR47UxKANQL2hD08AHxQEjSC2bb2L7kxq2d/
         8XzY7es//oknvNbQP+vhiynzDS6gCBOqW8mREpFKDWaFygziY80IzRpfYzUakGyaOdQ/
         NtSs79z4DnppGxvYAxas/rthdOzxwp4B3EtNvXUJ7saVnkzn+jUNEbd9aLkzNhPRuTLN
         WHnQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIzpwEcgzDZ7xMYOvfhwmxEjv9OwPyqF3qB+42t1Km6EGpQKvuTNb0sG7B+zPVbmqQoYqkIBDTOyU9@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZhGyJmYGLMVSqB05AjbEnQEh1LiL3SrkDdKme+Vzn2xCeuPk
	NgWcpUba7x4HaXGLsSyb2NQifRqM6u4d6IkTMp++kDmxjbrCXY17Gv5qd3gPZ+I0eiU=
X-Gm-Gg: AfdE7cmYwMLq+2tdOPnKMvsxnb9RPYy51CtiCelofj74jlteR7w+JZLfM+lAonWBvJX
	be9jbFI+zJasEtmeviZRiP4xqWlI1Z0A4KQxnRAJnihuMTH84ncezjtkbq27/TbMTzXJufM/H0E
	qX0bVZ7r95cz7PLX/dB4jj46dc7VmfRm6cKgaOxdSyx2Cb35+Q9+U0uc7AoeD0ii9gKfrDAho48
	YomBtK0dl3bYPRfvuuw7biGEz5oqEo5Fnb56veizHPsm1JNAkLIV3sVFhhsLhp5ayckxBCSdbRy
	hcT0enzU/HpKMLehJce37agoNoadooFN/AaKhSjTZoiK9VsUZxFOG43EWk5aGgz2KFZzN2s549C
	VJNm7ix8T4QThmroqTfnN3xhqC95j7/KqRxjbWga6KxX5hpYVq+bRNOkVxRF1awp4IafjBeD4zH
	zQra7ywHsRp3TxCmwoqd1lCK1xDS4eA9p/7HCH9+Mifuy60JWJzsitVIzT/KWOvyKIec6jxwV7s
	jlPtL0syywrSXAn
X-Received: by 2002:a05:6000:4691:b0:475:3a97:8e47 with SMTP id ffacd0b85a97d-47aaadc9ca9mr6202068f8f.29.1783322701442;
        Mon, 06 Jul 2026 00:25:01 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 08/18] fs/ceph: remove i_truncate_mutex, use i_fragtree_mutex for both
Date: Mon,  6 Jul 2026 09:24:39 +0200
Message-ID: <20260706072450.3920010-9-max.kellermann@ionos.com>
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
index e79ba09f2cdf..1f65aa387008 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -677,7 +677,6 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	for (i = 0; i < CEPH_FILE_MODE_BITS; i++)
 		ci->i_nr_by_mode[i] = 0;
 
-	mutex_init(&ci->i_truncate_mutex);
 	ci->i_truncate_seq = 0;
 	ci->i_truncate_size = 0;
 	ci->i_truncate_pending = 0;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 05452bc7eac1..35399689f0c1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -466,7 +466,11 @@ struct ceph_inode_info {
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

