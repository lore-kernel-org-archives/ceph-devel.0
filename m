Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85118DB26
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938644; cv=none; b=om3fnDGDqDy10y4v7Xw3eQ9yUUdU98nMt1jiR70RcGKU/gYl7DJn5949aRK6LyMN9CN9alx7udytv/pXZAEwg/JnF8F/vJrLhL6qjRtwQmQf8CYY4UmWBh6ejHLcwHCO8pFoOHi0hIZGZ3c/ZIhN7Vt+6ZZdFTCcYAm/HU7y/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938644; c=relaxed/simple;
	bh=7KbyPvsnIyffv8erfPVQaDbjs1ksW8LpD5GRCqCoQwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDassM1JnLvINu+vtlwAkAcLklT/ilAXYrW90/T3neJgcOp0isskapXSRlaYTYWvJYkJCXFKy7WIQlvGybQEiwJdplH+kvDJyei0a7DT4DzDPry9s+Yo8cLIUB348xiP/eSDjQTUkrxVcs9xO91wOfS0UbNqeLxoY9LmFLTGkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=afpQawon; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="afpQawon"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a16a400so4887617f8f.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771938641; x=1772543441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf+c8hVZNgFP3BiEHZouqSwT6ALbJDbEZGSHCOTFUzI=;
        b=afpQawonFPFfdrC2ZaMhISCOvJaCLQdrJSJ4W34ASxvmjG7+H4FEoaB/PB90U0aejH
         o/BUmZVGEWki9d2v/O25FpHeprAWRNOAK3Z7OINjY0TPbt4XG6g/8OhynolgL+N14Sem
         o5QkHt3GHujFJhNwfTCNAjB4I3cKloq1a9oxSduqj1dD8QiaVYqnsqA2FC9w03NnWjM6
         ViqJ9qH4VZ/5uenae/QoMCRhwqIl2QY03fbhWp6m2TOaSkud2TsddGxNodrQjG+Y8O+t
         5jiHtISMzec0eSC6lmo3Z2CybH6fEjMe4Gm+h1ikkFEbvmCluFnVVr5wV9rvmw8BiLYf
         Y+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938641; x=1772543441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf+c8hVZNgFP3BiEHZouqSwT6ALbJDbEZGSHCOTFUzI=;
        b=fli8cbLeihokVynuE+uY3MNegzYfp43VDGbITCqqz53hQMGeS028D17flNkWTjGiaI
         3XvTzBGnRWI3sQMRdbJFv+RniaSUINgdnYEdewEm7OGYnSEhJiFInJ2sK1qvKCb8b6GO
         NerBlsnYqu7Qu8MWbBqbwl9ywPGlHbPfVH25YD+HD4y3JcAt7p5x2+k6cqpGx7j5lxGL
         Cvv904SVsgOCJSgZpauRdtbPbQnfsceq8DtcMAVvmvIXuQ9bj4SBCAM+bQnU8ve+shE5
         Gc3DblPTrV0wZqlD87VdBw9JtzvVfPtboF4v6d5iFO9eYtzWy8AajIBXhM+ngzoJ2Nxb
         ZcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGkHD+JrbaPN0fjbu2x0oIgRpQbRd6YM4r/m1Cx2q6MHtujRbTHnlDMa/UFZx6m4vwF9Kxgf1EFOLG@vger.kernel.org
X-Gm-Message-State: AOJu0YxaraQS98Rk+BAiktyI5LNAXHdsIKDqebLjBsiXRbusmXzraTKQ
	lCl+xp/r4SDvteFtAI7Y0eI1c+Q5YSAzrPwm2qEq1KEjxBbo/478CtRxWtKeJihxpnY=
X-Gm-Gg: AZuq6aKq4xcfU4ABnbX3NpG2z9wnEQzFRzXblqi7LdF4u4v+DORUsuGfcynyr9/iZCN
	/wTFw8QGEWt0uGKEMVp5BqBgtjN0XEgDBtDWKAe3QDH+vUrT6bKFLbTujfAA8Le0ydZSCSfSSYR
	W4EPrRSPOe3+3+7KXAfcKLr9P5Nv8Z8aporXzOUh0nrz6LSjRlCS63EWssCwSk9md0AfHGBOIIY
	3zJHIDFzX13UBI2QEaUerRtoZPnp+4q0LP03pIkIgP8H4X5bGEPKqwXoQmq3sdwbYxo7xrDqkUS
	8WQBMT6c5oZUCsEe7XeN37s5jXoSqF7pqrzJ2Ch+1JPtq6oENXDWag5RH2ZUgJ4K2vOp/Dq9wvP
	Zjm2LTP9xjMWkiI8AJGZcG0oxmFfgckYo9aA+9L8ZJr6rWUmZMoBPdNRmDpVBKdzZoU5hnFB3lt
	9o4gDZjnnjE/c67HR5lwD5up6MYKRP6n2Z63cVVQGFSOGJ9HSjdTcTy9RqwQBIAvG6ixn4WqQXM
	qrUX1OiFrKugd/gqF20MyphDQ==
X-Received: by 2002:a05:600c:a11:b0:483:361b:deff with SMTP id 5b1f17b1804b1-483a95c9e16mr214164825e9.14.1771938640642;
        Tue, 24 Feb 2026 05:10:40 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f3d0100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f3d:100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b87db57fsm33188865e9.3.2026.02.24.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:10:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: to=idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph: add a bunch of missing ceph_path_info initializers
Date: Tue, 24 Feb 2026 14:10:29 +0100
Message-ID: <20260224131030.3049328-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_mdsc_build_path() must be called with a zero-initialized
ceph_path_info parameter, or else the following
ceph_mdsc_free_path_info() may crash.

Example crash (on Linux 6.18.12):

  virt_to_cache: Object is not a Slab page!
  WARNING: CPU: 184 PID: 2871736 at mm/slub.c:6732 kmem_cache_free+0x316/0x400
  [...]
  Call Trace:
   [...]
   ceph_open+0x13d/0x3e0
   do_dentry_open+0x134/0x480
   vfs_open+0x2a/0xe0
   path_openat+0x9a3/0x1160
  [...]
  cache_from_obj: Wrong slab cache. names_cache but object is from ceph_inode_info
  WARNING: CPU: 184 PID: 2871736 at mm/slub.c:6746 kmem_cache_free+0x2dd/0x400
  [...]
  kernel BUG at mm/slub.c:634!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:__slab_free+0x1a4/0x350

Some of the ceph_mdsc_build_path() callers had initializers, but
others had not, even though they were all added by
commit 15f519e9f883 ("ceph: fix race condition validating r_parent
before applying state").
The ones without initializer are suspectible to random
crashes.  (I can imagine it could even be possible to exploit this bug
to elevate privileges.)

Unfortunately, these Ceph functions are undocumented and its semantics
can only be derived from the code.  I see that ceph_mdsc_build_path()
initializes the structure only on success, but not on error.

Calling ceph_mdsc_free_path_info() after a failed
ceph_mdsc_build_path() call does not even make sense, but that's what
all callers do, and for it to be safe, the structure must be
zero-initialized.  The least intrusive approach to fix this is
therefore to add initializers everywhere.

Fixes: 15f519e9f883 ("ceph: fix race condition validating r_parent before applying state")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/debugfs.c | 4 ++--
 fs/ceph/dir.c     | 2 +-
 fs/ceph/file.c    | 4 ++--
 fs/ceph/inode.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index f3fe786b4143..7dc307790240 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -79,7 +79,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 		if (req->r_inode) {
 			seq_printf(s, " #%llx", ceph_ino(req->r_inode));
 		} else if (req->r_dentry) {
-			struct ceph_path_info path_info;
+			struct ceph_path_info path_info = {0};
 			path = ceph_mdsc_build_path(mdsc, req->r_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
@@ -98,7 +98,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 		}
 
 		if (req->r_old_dentry) {
-			struct ceph_path_info path_info;
+			struct ceph_path_info path_info = {0};
 			path = ceph_mdsc_build_path(mdsc, req->r_old_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 86d7aa594ea9..a87c2bc09965 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1363,7 +1363,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	if (!dn) {
 		try_async = false;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 66bbf6d517a9..5e7c73a29aa3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -397,7 +397,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;
@@ -807,7 +807,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!dn) {
 		try_async = false;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d76f9a79dc0c..d99e12d1100b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2551,7 +2551,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;
-- 
2.47.3

