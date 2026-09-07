Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E983C5DBA
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816214; cv=none; b=cYcHQz9IDbZ812GrTUKCoJe6WYwGaZouTEuUuDWxKja8ZrY8flQ8QXPGFCnSRQd+4EPMiTN//BQyt2fROhLwH4m13/VBqBJ9G0URyA+KM5YNiqa3JCzxxkXJ8Rg0UPc3jJ7cViF4BAJOPKti1T1y6R2smOvTO60/6YcRIovv4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816214; c=relaxed/simple;
	bh=ORJG5RZBBKDF5w5yXgfyuVNDj922KNo5P3ZNmNwwYkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxhFJl8oSnxfRVqXUAGb6PRX9iG6eafdNNHrgjoCVj02gwFAhSlchBE/+1G/wEq1ylXLHXu7xqrDVP6qYktqt8bheGYup0R81khG+9Fsd3gCA7XUs7f1MTHll3XtGWG1D64ZlMrtfiRIeKE6s6cwzKYXRuZLLcujAEcX5Nguu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XL/CPr5g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XL/CPr5g"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47fe89fb333so2549026f8f.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Sep 2026 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788816210; x=1789421010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yL/LcatQKBPIKGEJBi+B7MdIyWnp6MwRkzotSVxE0II=;
        b=XL/CPr5gLbcxMq7loio21J39o6oTJIFwaWwt2z7Bfsj1wmz27KfS9bDKmrbBLnG8SM
         J9u8zgIO4ANLcXEwfLGvD3D4vehCWnZfJPl3YiagMFwgdTNASKCL7aHCb60VqJClCcj+
         dKtLihuIiqM0q6KNuNpjc5nLT/pTPuxeoWxMt8TFGoNJQ8R5Y8qxo7ylDm1hSyM/O1VP
         hAHU7ni2slQorU2bCznq7XYXPfy5fdW8uZnXuIfogDYW0qalIPkRRKUZwFK16ii3RtX8
         450ILBQPLPDNOvixqVPC2tQRTrpdNVmFUGgEtwIGfEXZiAHbh3fFiLVMf89v8r3hoeiA
         FLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816210; x=1789421010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yL/LcatQKBPIKGEJBi+B7MdIyWnp6MwRkzotSVxE0II=;
        b=K9xeBEOHkd8eh/4Uoe+TABb5XXxfBAg8yFPXL2hrwSH0IzX1uPa38LlFxelhdDjryr
         0O5Ccg2XN9hyA7j6usSPo/KLQdeWgBWbUhP4gl1S3+q5GlKYnVupg7bSVC3vpSv3+C2r
         34GZTRC7JCUTF5LFAnsAJhH2wm2R3iypba9z0awuYDmE7735vfv8LxwVxriIyIRS6g4o
         rkiiMjQT90PemvQ0x1tPsdggnb9OPsj7GOpe6Vfs0KQgR+k9h+q87gCMPHxJvk5HicLQ
         +rpPgjax7S3L87LIyE5CsV+v8UGxnPPQ6+F89CFo8a91kctuBdigkVzO/1yliQ0/vqQQ
         /Ccg==
X-Forwarded-Encrypted: i=1; AKwUvBySiMa7/a8Y3lqwp0k9DFELLkAPoO52S9eA/8AtjSl5DOC8EULfuq1RX+K5bPBOOeMZuMuesKy4RQTM@vger.kernel.org
X-Gm-Message-State: AFuF++kv4SDu2Ak2oFcH4KOdb9ZCBuQpcn5lFiMbrRhjImIOzr1TnIgK
	1dgaCLviHW15BT5xCnWttrde3gKf2L2NowOEXQgUBFArsAD+/q3pRM7Lny1ldGKL0dI=
X-Gm-Gg: AYBFou238iJmfVt+Bxg7RX0VXZrd8Xuvjeaz+1y3CXM3/AYmVmz7BllRmK7ioV4u+Xl
	VQZvDk1RGrxJ6cUKc9XQcdJTws/N/lB2W7DngTWPoV3Byudpqssp5pYu9zU4DopDiArNm/1kcBD
	iEjyMtGb2HEcrGRI721iG6f+uAKrPdo2EVsQDor3d7MJARqPqZuJuvsGrubCd9O5klPV4A1ku5X
	8iSo4s5V/i3AUKBnf2A407eLsz5tsVap1FtwqGVmo7L21zilKc/5zolFC3+aKa+o7oCG8rlgoup
	kTkUTokZmQCx5N2Fhg8QJp55fO9ViSdX3RWBwSCk8Wol1LCcShSsOuA9g8M/86a2V2x42ADv8Ny
	epxjDC7doZluz/DqmskNIQAIsW/if0waibvTmGgLQVb5BeOGqLzCtyjmsWDxOgRk8s1dH1wI52l
	Gb6pk2kDcc/zDWv44SVwr+Z/AcJe7klcPH3ROhPDjLWJXFDWK4QoFLOWprf210d0zDmMUnHPEK/
	4XxkfmasVMHckAGUaynkfNRMyCqvA2WWBpChIEEBTQgf/5CtYjfJ+IwtU4LhquN
X-Received: by 2002:a05:6000:2c0e:b0:485:a1a1:446c with SMTP id ffacd0b85a97d-485a1a1450bmr4325820f8f.16.1788816210120;
        Mon, 07 Sep 2026 14:23:30 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bcefd59sm26232785f8f.19.2026.09.07.14.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:23:29 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] ceph: skip alias lookup when trimming non-directory caps
Date: Mon,  7 Sep 2026 23:23:25 +0200
Message-ID: <20260907212325.508739-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drop_negative_children() only does anything for directories; for
other inodes it returns true unconditionally.  The d_find_any_alias()
and dput() pair around it is therefore pure overhead for regular
files: an extra `i_lock`, a dget()/dput(), and a ceph_d_delete()
check for zero-refcount dentries.

Only look up aliases for directories and prune other inodes
directly.  d_prune_aliases() kills the same dentries either way.

Side effect: a non-directory inode without any alias now counts as
trimmed if the iterator holds the last reference.  That is okay,
since with inode_just_drop it is evicted as soon as that reference
goes away.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 085ae0cfb5f7..81cb1e9b9769 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2315,22 +2315,28 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 		ceph_remove_cap(mdsc, cap, ci, true);
 		(*remaining)--;
 	} else {
-		struct dentry *dentry;
+		int count;
+
 		/* try dropping referring dentries */
 		spin_unlock(&ci->i_ceph_lock);
-		dentry = d_find_any_alias(inode);
-		if (dentry && drop_negative_children(dentry)) {
-			int count;
-			dput(dentry);
-			d_prune_aliases(inode);
-			count = icount_read_once(inode);
-			if (count == 1)
-				(*remaining)--;
-			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
-			      inode, ceph_vinop(inode), cap, count);
-		} else {
+		if (S_ISDIR(inode->i_mode)) {
+			struct dentry *dentry = d_find_any_alias(inode);
+			bool prune;
+
+			if (!dentry)
+				return 0;
+			prune = drop_negative_children(dentry);
 			dput(dentry);
+			if (!prune)
+				return 0;
 		}
+		/* The iterator's inode reference is sufficient to prune aliases. */
+		d_prune_aliases(inode);
+		count = icount_read_once(inode);
+		if (count == 1)
+			(*remaining)--;
+		doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
+		      inode, ceph_vinop(inode), cap, count);
 		return 0;
 	}
 
-- 
2.47.3

