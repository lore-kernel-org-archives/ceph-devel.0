Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8C32937D
	for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691999; cv=none; b=fzTshUjqcNELRjZUCuq7s8pDYWcMtax3erSgbFSsg0U8LD44RqEXcL2noCR5mZWfwNuKfwuoRqt0/6b4WvfBJNC3bE/Ic6aqedh8waLF/OYT6m9T2jeZVTihFN17RSPpj7ChlKiLQw9wUSpG14Nms46qJfXkB0o0/x/GvvPJU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691999; c=relaxed/simple;
	bh=U57Xqi41GmcO0x6P9Zx3BaCcGSfhRtmMSS7Uf1PuLxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpiz+3MMhrM/Cwy1N4MOU6+iZlxSFPrd4TB82epWtSjVa0Fpc2xVSs0oz9qaqA27de/Z2lZhvQTvVRcctNT1D8X7SbybYt8O2DkLcS4KduDbnD7xyaNHxf/rjSC8Dm36boMav1hBVic+AgExfE5D5mA+3R3mDBjIFpoQLob809w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuvVAcjY; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuvVAcjY"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c70b5594f4so344938685a.1
        for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2026 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771691997; x=1772296797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+im6HE0V+UhU/UpPycv1gj885b94imjLQRZ7n5HPX5c=;
        b=BuvVAcjY+6dGMHDgXSFODidIutr0CpfsL0MDhiN74AcsG5wI++XEOIkF8OQImB3xW+
         FBymDcScEa+NkWhfpm/v+lKY8nI6v8HHKYsQsalGGrPYGwvDRvFUCyeK2+B0p/vv399+
         erEDRHtf18rd8e+PgNx4auEkGqEUt29aQm5Voa+IWmaZ8n0c1+P1XZc6TRlSH2e5HXqG
         Ipe4exUqPdE29c+6IvyVakp+p/ib662X/e7phZWLwzEIkRhlG6GXhgjncJQbOP8gKILV
         sgAzrhkXL5ywjs5UF/jpJbGXptLsTtUM5unEoAxeKcquxoIUgFiwIb66brlr2EPXvnYp
         JTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771691997; x=1772296797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+im6HE0V+UhU/UpPycv1gj885b94imjLQRZ7n5HPX5c=;
        b=hxcBM33bstMmqnLIZXKcKdjkrEBDqHPjfm/v/nu7/eqiyz3R96KxNxhYLE+xm0S2qa
         U5Ic/T/YOfctT4+WxXZgm8Tcibgjp+U23Xq+bzvYpKG2l1ySzLT8ciCIQs2Yg/3efqe2
         BQmKEjJk98WtmCCnf9IB0Ke33bXF9AWE9i+VrqY9ww1bI60LHr5s+JuwDfuO1/eCG6iY
         ayM0bP1yyUqLE0n6Ewi9yGJk5BfCbMclP84vgFD2oxbnCNwHKtWuBWzsG3JINm+d5zuW
         mzEpZFhg5aNMbIHRbxVDswu042ICiQiCQdltpmpF5NX7WyaFkKuOwdK43qp4ofvDLKrz
         fvHA==
X-Forwarded-Encrypted: i=1; AJvYcCXFYW3o9o5iPKT1w4uj4DGCoMvll344dyG+XhvTmCWTTgiKyjijSbzcVrUAJo9MBpBCbq432PnbIRvd@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBiVm6DGcKv7FVjT7HI1ODVRVjgMQacH409MZF3LGGtg7KCA6
	MqtknWSnXzXYvhzIEEAa48/OMhErmd/D4cwwpmItjFEMbAtl8ak7QTJ/BkVsjg==
X-Gm-Gg: AZuq6aKYy8J6wn/j+v5j49NUtlhiRcDso0M4RqFr320JsENRc1v78bJ1vTTz9QNh6nx
	fBUy35oVFu6k8rHro426rNCVeXDLLiAIkuaEZNMzvZ9n6WF+hDizmmOr8E08ZeUFuKAslnUHEdJ
	0ZXpMvWm0Rx8SDhkiUar6rRtzail8ZYYif5HKEIKL3HuAnnufpCSjqzs1TnDf1ns7pHm4r+iP1Y
	x0L5PUVddiK58BTY+hdG4NLOcRSsuYX7L/yl+I+0ZVwD3GZamKX+e6aKk15vbD5J1spfiTU+UXY
	hG814+JOrpn3ZJF3Nhn/WdWmhCZ3VTnQjxbbAUnNCz/catNsT3F5vlePl8hm336vIsW+hOFh3wp
	Ldtn6OjkmjVCXKZr0Xq9e2sa7RZvmDQyJljwl+isAPoMb88xr6KOXQ8BBiQaNbripdy1s9KjRWw
	DRaPOrADl+Ytu7OgTqKQ65xM2mwAUv6pyMp7IL+k/pAGz/n7YhvDTjEsI=
X-Received: by 2002:a17:902:d48c:b0:2aa:f5b4:9a2e with SMTP id d9443c01a7336-2ad5f7349eemr96972465ad.11.1771685998012;
        Sat, 21 Feb 2026 06:59:58 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:59:57 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
Date: Sat, 21 Feb 2026 20:45:43 +0600
Message-ID: <20260221145915.81749-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag indicates the path should be opened if it's a regular file.
This is useful to write secure programs that want to avoid being
tricked into opening device nodes with special semantics while thinking
they operate on regular files. This is a requested feature from the
uapi-group[1].

A corresponding error code EFTYPE has been introduced. For example, if
openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
param, it will return -EFTYPE.

When used in combination with O_CREAT, either the regular file is
created, or if the path already exists, it is opened if it's a regular
file. Otherwise, -EFTYPE is returned.

When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
as it doesn't make sense to open a path that is both a directory and a
regular file.

[1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/alpha/include/uapi/asm/errno.h        |  2 ++
 arch/alpha/include/uapi/asm/fcntl.h        |  1 +
 arch/mips/include/uapi/asm/errno.h         |  2 ++
 arch/parisc/include/uapi/asm/errno.h       |  2 ++
 arch/parisc/include/uapi/asm/fcntl.h       |  1 +
 arch/sparc/include/uapi/asm/errno.h        |  2 ++
 arch/sparc/include/uapi/asm/fcntl.h        |  1 +
 fs/ceph/file.c                             |  4 ++++
 fs/gfs2/inode.c                            |  2 ++
 fs/namei.c                                 |  4 ++++
 fs/nfs/dir.c                               |  4 +++-
 fs/open.c                                  |  4 +++-
 fs/smb/client/dir.c                        | 11 ++++++++++-
 include/linux/fcntl.h                      |  2 ++
 include/uapi/asm-generic/errno.h           |  2 ++
 include/uapi/asm-generic/fcntl.h           |  4 ++++
 tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
 tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
 tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
 tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
 tools/include/uapi/asm-generic/errno.h     |  2 ++
 21 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..fe488bf7c18e 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define OPENAT2_REGULAR	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..d46812f2f0f4 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define OPENAT2_REGULAR	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..bb6e9fa94bc9 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define OPENAT2_REGULAR	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 31b691b2aea2..0a4220f72ada 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			ceph_init_inode_acls(newino, &as_ctx);
 			file->f_mode |= FMODE_CREATED;
 		}
+		if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
+			err = -EFTYPE;
+			goto out_req;
+		}
 		err = finish_open(file, dentry, ceph_open);
 	}
 out_req:
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8344040ecaf7..0dc3e4240d9e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -749,6 +749,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		if (file) {
 			if (S_ISREG(inode->i_mode))
 				error = finish_open(file, dentry, gfs2_open_common);
+			else if (file->f_flags & OPENAT2_REGULAR)
+				error = -EFTYPE;
 			else
 				error = finish_no_open(file, NULL);
 		}
diff --git a/fs/namei.c b/fs/namei.c
index 5fe6cac48df8..aa5fb2672881 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4651,6 +4651,10 @@ static int do_open(struct nameidata *nd,
 		if (unlikely(error))
 			return error;
 	}
+
+	if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry))
+		return -EFTYPE;
+
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b3f5c9461204..ef61db67d06e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2195,7 +2195,9 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			break;
 		case -EISDIR:
 		case -ENOTDIR:
-			goto no_open;
+			if (!(open_flags & OPENAT2_REGULAR))
+				goto no_open;
+			break;
 		case -ELOOP:
 			if (!(open_flags & O_NOFOLLOW))
 				goto no_open;
diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..1524f52a1773 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1198,7 +1198,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
@@ -1237,6 +1237,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
+	} else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
+		return -EINVAL;
 	}
 	if (flags & O_PATH) {
 		/* O_PATH only permits certain other flags to be set. */
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index cb10088197d2..d12ed0c87599 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -236,6 +236,11 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 				 * lookup.
 				 */
 				CIFSSMBClose(xid, tcon, fid->netfid);
+				if (oflags & OPENAT2_REGULAR) {
+					iput(newinode);
+					rc = -EFTYPE;
+					goto out;
+				}
 				goto cifs_create_get_file_info;
 			}
 			/* success, no need to query */
@@ -433,11 +438,15 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		goto out_err;
 	}
 
-	if (newinode)
+	if (newinode) {
 		if (S_ISDIR(newinode->i_mode)) {
 			rc = -EISDIR;
 			goto out_err;
+		} else if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
+			rc = -EFTYPE;
+			goto out_err;
 		}
+	}
 
 	d_drop(direntry);
 	d_add(direntry, newinode);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..a80026718217 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OPENAT2_REGULAR)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..b2c2ddd0edc0 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/tools/arch/alpha/include/uapi/asm/errno.h
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/tools/arch/mips/include/uapi/asm/errno.h
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/tools/arch/sparc/include/uapi/asm/errno.h
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/tools/include/uapi/asm-generic/errno.h
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
-- 
2.53.0

