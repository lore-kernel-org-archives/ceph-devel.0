Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30E38887E
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596942; cv=none; b=RGJnIAMgdzNkQJ+ESzhoCwy2FS0ScSU4sLosfxY+Tc6dPveQljV8Lg2e3DElU4CstiB/FLEtY7QT9zOLOjw/gfqceAvTmR1N/isEnIpUTy1Sp5FaEoVhXjj/jIeVdYoIlI+iRnccXOCbFWGzb4JcvxIvbfC+NTzQtw0j+PZ3Lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596942; c=relaxed/simple;
	bh=G2IH3CzS7Zd1/D5eiAydefKLOkU1ZCpbZx58dYM+kZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIG9U41jf/al0/iRHQb5mSURZrM6WEr/lN/u0nlD3jaEiUDSgPTnX8vpASkVAxU4zVBngz58uYqQCuxehJkFKbuCSa23I5lrJwrk7C2P4ltPrzpuhYsN9pspHIFCpqXkhTSkEmjkh8CxOGePdVL4G/Sq7nnm2adRCp1OBnP2eeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vx/+MofS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vx/+MofS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2074710751so700058466b.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596937; x=1788201737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8Pz0kJZhXOEmft7GuhfPd8qakMe4j7ZLaQkh5Hkdos=;
        b=Vx/+MofSNncPZ14bAbKrS1I7DWAn98v19p/ZE6oVSd/0A4s0P+9dhUVdDmcofKbx07
         g3kTDWFaYY1jY7tYM5QD1wlY131yfdZNN4Z+LXIMQ9TNFYAeMyhaMJVKDdUnFqkYRW40
         vVqEDHAQxLRQaS8XNNexydTiVUledLVNTPR707xc/jbLcmsLDI7VUIO4PdxwXxlv+TNT
         +ELt9Hh7TisOmizfr7cmMzxOnTurGwrwMLm8xWpHVeyF+kq4gU63mxHcIJlk7vW1LJpJ
         8mrv844MUTfUGhazBPNMPfA7j/COb6tPI/W6chhu3TAULYn1Ntzfae8aQVnnsrnk5z7d
         v1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596937; x=1788201737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8Pz0kJZhXOEmft7GuhfPd8qakMe4j7ZLaQkh5Hkdos=;
        b=T0EAu9Fkc5cZpApMTUiGV95D0YsHz0SpQyVoBN2/fjO+/7VaxgOpX4EZUuhW5gBns4
         nW2t2I7kOmtW2sM63d3tzVc/DkpdowceDwQbHf1LVkhe2ecFcjmAnvYMPMsobErpnc5v
         rvVOrGTja5vWnMITWj7GSXkHauXupVc0/+AlM+2v4AZychIHsmwHU51xh4UiWgudP+rS
         trxDTCABYBgxnr1/gOdsA2Z0m9YjoKh7v3JFJmAVofXIg5y0gKZ25U/ixRbRxCtIEii5
         J5IECfDJvNrOgM+NiybDVifgqKrOgCeZHyTUhrCdp7KDrN5CreaiTAqpxondyNyLtnDa
         dPfg==
X-Forwarded-Encrypted: i=1; AHgh+RrLXNpZ2z4JhU2GckDWc1DHfISGrzCeo8A5yQJfzjI1dGR4EDdj9zK+CxT/G1bFVco7t2kaUGkF0WDx@vger.kernel.org
X-Gm-Message-State: AFuF++kahlnRXyICZPzukjgaKh9RYZ4S1kTvKbokbuec4WZNO8P/ZhiV
	dm1/GlevNfijoPH/ywI6ZgU5pWBGLNHqM1aNNEQ3KRJE0PHJdQrnHdxDEm41GJ0+F2k=
X-Gm-Gg: AR+sD131weSvyzshrqnsMMH8F51zuV/qfg83EWwg5yoILqP5dSXvTxXDcipp2m6GXu7
	jI5c7owsXCzIdGb74z7lHfkWbGdnGUFfVwNoTFhCxN73W6vP+V0k7rzOmbhud5JD9EQ6Y+0nCK+
	v03jOa9U1l25MKpf2si7dvx+ERAmK9dSWkW1pvoAsO1i/0axrv/RA7QMT8bFwzNKpDFkpUeYOan
	jueLfyeQZFATpIewpPOXtketBraE69iQD/YrRzQDCclUssSj8hrAZXwqNbYh/lHmrBpwUxbpovk
	wqiTjC73pvV+erfeKhk0abu71mLrFPacnl45mEkB1+Ve9diS3EZkZhOjfyf3eDMhqSMWUCx4U9U
	+RUDtb9V4Ax/Qm2eZRDVuER9ErRTxCoMy1YLuSDRUe6AJTaCKObONWaDBp6EyAQ+NmpVJ0NUqOk
	U56ka3cqCcDQZX7qZ388/WWNXDxl6b7SpLBE4+FoGdMHU/nkBjzArz7zqxbp5y6EHWN9SoDpx+P
	/BCeyLPeCE0N8rOYNixH1WlrPuDKpihDt/N8XsUOyEPkon0xDvurQOfc73jdwJJ
X-Received: by 2002:a17:907:5c9:b0:c12:83c9:d41 with SMTP id a640c23a62f3a-c2491e83838mr1925053166b.12.1787596937373;
        Mon, 24 Aug 2026 11:42:17 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:17 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 11/11] fs/ceph: remove redundant inode number from ceph_inode_info
Date: Mon, 24 Aug 2026 20:41:59 +0200
Message-ID: <20260824184159.240821-12-max.kellermann@ionos.com>
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

On 64 bit systems, ceph_vino_to_ino_t() is a no-op, and inode.i_ino is
the same as ceph_vino.ino.

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/cache.c |  4 +++-
 fs/ceph/inode.c |  9 +++++++++
 fs/ceph/super.h | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index f678bab189d8..289615e58196 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -16,6 +16,7 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_vino vino;
 
 	/* No caching for filesystem? */
 	if (!fsc->fscache)
@@ -31,9 +32,10 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 
 	WARN_ON_ONCE(ci->netfs.cache);
 
+	vino = ceph_vino(inode);
 	ci->netfs.cache =
 		fscache_acquire_cookie(fsc->fscache, 0,
-				       &ci->i_vino, sizeof(ci->i_vino),
+				       &vino, sizeof(vino),
 				       &ci->i_version, sizeof(ci->i_version),
 				       i_size_read(inode));
 	if (ci->netfs.cache)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 62399361821a..acc600e0024c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -44,11 +44,20 @@ static void ceph_inode_work(struct work_struct *work);
  */
 static int ceph_set_ino_cb(struct inode *inode, void *data)
 {
+#if BITS_PER_LONG >= 64
+	const struct ceph_vino *vino = data;
+#endif
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 
+#if BITS_PER_LONG >= 64
+	inode->i_ino = vino->ino;
+	ci->i_snap = vino->snap;
+#else
 	ci->i_vino = *(struct ceph_vino *)data;
 	inode->i_ino = ceph_vino_to_ino_t(ci->i_vino);
+#endif
+
 	inode_set_iversion_raw(inode, 0);
 	percpu_counter_inc(&mdsc->metric.total_inodes);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 15fa433c9485..79917adccda2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -378,7 +378,15 @@ struct ceph_inode_xattrs_info {
  */
 struct ceph_inode_info {
 	struct netfs_inode netfs; /* Netfslib context and vfs inode */
+
+#if BITS_PER_LONG >= 64
+	/* on 64 bit systems, the full Ceph inode number is stored in
+	 * netfs.inode.i_ino
+	 */
+	u64 i_snap;
+#else
 	struct ceph_vino i_vino;   /* ceph ino + snap */
+#endif
 
 	spinlock_t i_ceph_lock;
 
@@ -571,7 +579,14 @@ ceph_inode_to_client(const struct inode *inode)
 static inline struct ceph_vino
 ceph_vino(const struct inode *inode)
 {
+#if BITS_PER_LONG >= 64
+	return (struct ceph_vino){
+		.ino = inode->i_ino,
+		.snap = ceph_inode(inode)->i_snap,
+	};
+#else
 	return ceph_inode(inode)->i_vino;
+#endif
 }
 
 static inline u32 ceph_ino_to_ino32(u64 vino)
@@ -601,12 +616,20 @@ static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 
 static inline u64 ceph_ino(const struct inode *inode)
 {
+#if BITS_PER_LONG >= 64
+	return inode->i_ino;
+#else
 	return ceph_inode(inode)->i_vino.ino;
+#endif
 }
 
 static inline u64 ceph_snap(const struct inode *inode)
 {
+#if BITS_PER_LONG >= 64
+	return ceph_inode(inode)->i_snap;
+#else
 	return ceph_inode(inode)->i_vino.snap;
+#endif
 }
 
 /**
-- 
2.47.3

