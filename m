Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAF39CD0B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566608; cv=none; b=ZJq9UOUGhQrRomS4bdTbD7U/gUNgdNkiy6+SzlG+o5K2BWtd5w4jSOCSiDstBXwzt1Yv0jrZrAj6IcEs397mXR93TZ1prR4Ks/1W+xBV2il8c9Cz7dWHoL48wos/mikOGeGCBhN7sjrXYhO37aiKOvoWm4nZJeRi4JUi0lYSLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566608; c=relaxed/simple;
	bh=vZ7gRo95tF/kqgzTVygqtXNVLMo92lelt/8iAfWrtpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKVKcVzq/80cSBlLpry/QRWRjV7DRNMElvuEcZHS7Xh1+aPslGaoqfO7HTkx+6dOMfzVXvrxnU32AhA4nPKpieqDIe2nyja+p2LJxY49xk1RlVxgxCCLoMkgNrG6TXh9MTY69Pobp2HiZcEghpUuqPF/TGz5rAEdEkAja2wFpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dDhZT+mn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dDhZT+mn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so11509175e9.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566601; x=1787171401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/h3RiEJriMYlQ3k6GEtIrqFIdNALC21eRy/CEabRiBs=;
        b=dDhZT+mni2/QOmcoF1waKr//UZZ+l/ysPVBA8HpK/li+axAivk/OCf6RLFZSH4ijgR
         bRxvEeogifwJIXDxMtaG5GufiLPB4BZXuqleUbeIJGJBw15WgPjVgjmXbefkCil90m/c
         xSPkjl/fOeGYsfiOoXMXwVPlphHl9W6PNbpqkafRZA9qOEfx1Xc8d1asvISc7rTolt4v
         x0Nrl4mI4P9xxPXgpwaE3UYzUB3euBelzsjoUnNbarLdfl69mO+NTaruyXRTCx7gcIuR
         Vnuw9Z/qilupqU9rsO26Qhi8XZXvRLSUgZnYtYwrtBF87wUPBrY39Tq/NstSN0byxc+i
         F0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566601; x=1787171401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/h3RiEJriMYlQ3k6GEtIrqFIdNALC21eRy/CEabRiBs=;
        b=nwEdORxhU45wBR196JbvPtESPNnKbE/3iciAi39AHN9oVWQWp5PpxTofLPADXA0ZJs
         dA9DPsNcQZeauqt09YxXxubl2h/oX114Nqi7eN2ZQrIsWORpS2eBojILEsfWD4voxXp6
         S0DdANhP5cqL/QS4Z+hfgSBihRPCufjHbPbyEodX1EtuJF786shFBYGuMTsHcbVmgpKS
         MHruE48tdlfTAHaF83rzcWhzNkMdPq2T4/pN9iqhCnLi2hch5IPO2VbPx5Jp1HAOIDG5
         6bhZKzaaJ1V0N3yVmMlCtGbtLdG3AueW/+UJ/IzMSTzU+lQ8vMrpZPk1PfwwGFSyQeuq
         9YaA==
X-Forwarded-Encrypted: i=1; AHgh+RprQ23Y3s4x5ZF/Rc/X3xdlDMvnpOAWlmAxYcRuGRqxMwmIsoFzGdN+tj7Cf2hbtM/mKmvZU6ACnVnu@vger.kernel.org
X-Gm-Message-State: AOJu0YwwB0fA2wkClvIuCk33I7xbX/Ib8K6iWpIU+jw5WocmLZToLAf5
	fJRCdFhTdjomled6SeXUwAvWeRtaw60FBincm+uO/GjbJ/HsGmKArRKmWLS4NyC3gQJ99Q8jYFu
	m7plIqG4=
X-Gm-Gg: AR+sD10j999XEgcY5+rCGgmd9PAvlXwmgC+wskUn5lqEaeNkUg0ZNnU4jlTdZywwnnE
	7QIDhZt8Z7lhhCtjoUSNbunxNkLKSuOjmvWbziRnJ21A5oObiIc1aBZ/ZyhhBVTBl3SZ6bpUYpF
	uklPcZk0QsQF0aJDcXWbFG8Uag+EdS70VLOJUBq3812k/cwYBH6fFDS+o+/3xW4XliJ8h1PWPQz
	R6Vl51oWpAOaJa8F4fmo7wljeOeoc4ZRAmmjlZQKITiG42VRwCprWJcVWhxepx16hNIlfni65PK
	r/BnPE24YaeOkaAlmLX3OoVosFGEpIKTmJ7XD62DgYCmxFqrOTOQzMU8ZP5S2qeYWJmN7EJTUkR
	JNkXWI8bNtG8IlxYcYXYYtHx0YiBp7vu2/J1C+j3+M1XHf6LLvRabHD4VevNizLdSvnl0gDxQ+o
	9dCjsFaTy5oWVQwtcCoGjCv1wOtP0fP3XqM1R0N6VRQn8f9Np8etKjNbUG5HB72AiKkr3XRTLWY
	0OB98Kj9Z3uaoLteur9VXNc0+7KUIQeEw76m4SArh54CmbRqLZzhU8DCXGFpJey
X-Received: by 2002:a05:600c:6995:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4998216ad6cmr5510455e9.7.1786566601183;
        Wed, 12 Aug 2026 13:30:01 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:30:00 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 08/12] fs/ceph: remove i_truncate_mutex, use i_fragtree_mutex for both
Date: Wed, 12 Aug 2026 22:29:45 +0200
Message-ID: <20260812202950.1800340-9-max.kellermann@ionos.com>
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

