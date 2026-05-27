Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA12375F81
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850764; cv=none; b=AcfiTz2W3wDhlRfw32JmD3roCfnvkljtuAfMrpSxQFBnsONxDJhy89jx2PUz/clD7YQYWJ9Uqi9WQPTMezP1uRvDE3VNmwoDvOiLn42HtkmxS0EdjSdNJ2PzxxVvENXWsqSwAH2vHeSg1/C6bRyvkDbR/NQzbblMTJeAjtzENqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850764; c=relaxed/simple;
	bh=kjicujkA5E7r76arGyOQ0yL2KoWTZqaFbfby1uBLO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRMJgbVeKYt+2qdikZBnKKBedtdFiSxJEB90VgsPmWg2tdCRJs7KVVRTdLCvx7xtOAm9i1CUS1AnZ+VaVGDuXz+unuExLlpwv4QNIgOrfW0EbFHrkjBrBOCPrCyb6M8QnoySNFvQHK+yuO4KvJDie+gKJrlWguJTIFGLuJ6HfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UysuvIhR; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UysuvIhR"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d79fc48d2so3654643eaf.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779850762; x=1780455562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zegv+ZZxpEC4mW2h/ysZZnf1Sps69/IlZUIElRjQ8+k=;
        b=UysuvIhRG5IcrkrkpEDoV7+WWk473J0TvePpbTuLr4pyCyi3y+WiFjewZzZyIaC7E2
         eTpnoPuO2p644Z4CtwWcpeZWfXP63vY3rCyz+sK8DUYhBgK9yCFT394aTpsDDivGCWyi
         94AIkY7STXGsywlqEia4Gp3RSsj4iJmeXGffnHQqFJh8Upz6r2eEFDAVJNjc9LeLFmA8
         4UWvlBoJbNTQLwNymFdBcEN6aykfLIwxaWDtU1PoI1E7Eo3qCDpTOI+IazY7gPfYLwL8
         1D4PuDk6vRN3jVED6WEYpSIXspyNOl4z5zjyOzHiMfwsXAO9IOJ9ypNosxMzFOk3AqsI
         kpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779850762; x=1780455562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zegv+ZZxpEC4mW2h/ysZZnf1Sps69/IlZUIElRjQ8+k=;
        b=KeuSRIYGxrufTc9npU3PCkigQPbEWhr1QU/MgrCxUvQ2/dKrrfZnVweTL+pe/SvJ9e
         ZXwv06S1RGVZIpsKBIvxYLlHI9YoOWy++kfFuIbeRN15xckwWVHGd5R/7QkxMLJ31nQS
         nRy+DAgIZNOzjrFN0oVNh/SpJhJ4/yxxG3cTAgpNuoBjSD50XXzVK5JLmR9+wnXqmVfX
         HkFb15mB8gkkKpJqngfRJ49oTmgpia4QZenESXqH0mAGczfsAwpgFjvo0gXuqDPQhFtD
         pMPODju48b2nKmHsgq49gtFLNaOjU6hf05UJzQZwqI8WP9iihMQfcVFrjXfmwIIKS/4H
         Zzqw==
X-Forwarded-Encrypted: i=1; AFNElJ/v6Ad8iQdM2JftApxv+Cae75wTdXQb8Y7mIatHVodsBpmkz/He5XWpu6/hyzRB1xWebjrxWBjVFM/J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97upkzAJryHscVD/OpDaa8vnfDKXOPqOrxTpuFJnmLDTIjAA0
	WLj4oVePFGk2jq0U6PlV8UWIoGSN2uKA97D56UT0vnRKPWkmDD4iTg3b
X-Gm-Gg: Acq92OGCRrMudo1qIjGDS0Fzdr8Lf6rk06+I3V+1tFt9lNhLvO3L808wvdiM1fJgo9S
	m94OvmzKNDmuT3fDdEuLE/lMkJVSMoEhg3C/jvw3zJpUhoWVOXbXH9nOMPpw7pc5D7+XuZ9Azzn
	LOuadK8CIqWVQVbIu5dEESHoTjdUuXEeGpnI9qj/qzyvKzWdj4Iw6qXI8Nx89J8bnGOBzOfWWdN
	//kkHquOhDtXqbaQq/X39LXTPRlj1CEaeD/wPz68jCx+aTmcQDUpwRr1PJfENQyvjeJQWNGbzVq
	NWws13ERRJaH7mMOQgFOKseJyrrSDjG8+ivTxoxFJltfRCViSP7HyJvpEs7tDa1NZcQwCH8z4Ls
	zok3RFJK0vhiYqP0W/tisYcdN+QXVLXvCTFZA2j6L1TzSRMn+sehB4Vs2aAuPwRV682WWqwdciQ
	ZiynyFkINAPsB87Zkf0V0VngslzSVHho0yTFDiCQvMFGePmEE8G/jHGQl384U=
X-Received: by 2002:a05:6820:1748:b0:696:17a6:c06f with SMTP id 006d021491bc7-69d7ead4fa3mr11345857eaf.12.1779850762129;
        Tue, 26 May 2026 19:59:22 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43b63976d57sm15305313fac.9.2026.05.26.19.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 19:59:21 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ceph: properly decrypt filenames in vmalloc() buffers
Date: Tue, 26 May 2026 19:58:28 -0700
Message-ID: <20260527025828.5966-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527025828.5966-1-CFSworks@gmail.com>
References: <20260527025828.5966-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fscrypt subsystem uses the scatterlist crypto API, inheriting its
requirement that any buffers are in the linear mapping region. However,
the messenger client uses kvmalloc() to create buffers for messages,
which will occasionally place those buffers in the vmalloc() region when
physical memory fragmentation doesn't permit a large enough kmalloc().
The various callers of ceph_fname_to_usr() directly pass (slices of) raw
messages from the MDS without considering that the messages may be in
vmalloc() buffers, resulting in oopses especially on non-x86 platforms
(see 'Closes:' for more details and a reproducer).

Make ceph_fname_to_usr() explicitly tolerant of vmalloc()-allocated
fname->ctext, fname->name, and/or oname->name buffers, using `tname`
(which, when non-null, must be a linear address; when null, is briefly
allocated as necessary) as a bounce buffer to avoid passing any
inappropriate addresses to fscrypt_fname_disk_to_usr().

Additionally change parse_reply_info_readdir() -- the only function to
supply its own `tname` -- to follow the new "tname must never come from
vmalloc()" rule by passing NULL when the message is not in the linear
region. Though this causes a per-dentry kmalloc()+kfree(), this overhead
exists only when processing the minority of messages that spill into
vmalloc(). My (crude) testing puts this at only about 1 in 8,000 readdir
messages. Still, if the overhead proves unreasonable in the future, it
is easy enough to mitigate: a future change could allocate a bounce
buffer in parse_reply_info_readdir() and use that as `tname` instead.

Fixes: 457117f077c67 ("ceph: add helpers for converting names for userland presentation")
Closes: https://lore.kernel.org/ceph-devel/CAH5Ym4ga7miUQE0K-cJA93Ya7w62P69MAN27R5cBiYnudoOHdA@mail.gmail.com/T/
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/crypto.c     | 37 +++++++++++++++++++++++++++++--------
 fs/ceph/mds_client.c |  8 ++++++--
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7515cb251226..61d6830d16bc 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -298,6 +298,10 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
  * Otherwise, base64 decode the string, and then ask fscrypt to format it
  * for userland presentation.
  *
+ * Though the fscrypt/crypto subsystems broadly expect all buffers to be in the
+ * linear-mapped region, this function slightly relaxes those requirements:
+ * fname->ctext, fname->name, and oname->name may be vmalloc(), but not tname.
+ *
  * Returns 0 on success or negative error code on error.
  */
 int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
@@ -305,11 +309,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 {
 	struct inode *dir = fname->dir;
 	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str _oname;
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
 	int ret;
 
+	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname)))
+		return -EIO;
+
 	/* Sanity check that the resulting name will fit in the buffer */
 	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
@@ -350,16 +358,18 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		goto out_inode;
 	}
 
+	if (!tname && (fname->ctext_len == 0 ||
+		       unlikely(is_vmalloc_addr(fname->ctext)) ||
+		       unlikely(is_vmalloc_addr(oname->name)))) {
+		ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
+		if (ret)
+			goto out_inode;
+		tname = _tname.name;
+	}
+
 	if (fname->ctext_len == 0) {
 		int declen;
 
-		if (!tname) {
-			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
-			if (ret)
-				goto out_inode;
-			tname = _tname.name;
-		}
-
 		declen = base64_decode(name, name_len, tname, false,
 				       BASE64_IMAP);
 		if (declen <= 0) {
@@ -368,12 +378,21 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		}
 		iname.name = tname;
 		iname.len = declen;
+	} else if (unlikely(is_vmalloc_addr(fname->ctext))) {
+		memcpy(tname, fname->ctext, fname->ctext_len);
+
+		iname.name = tname;
+		iname.len = fname->ctext_len;
 	} else {
 		iname.name = fname->ctext;
 		iname.len = fname->ctext_len;
 	}
 
-	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
+	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ?
+		tname : oname->name;
+	_oname.len = oname->len;
+	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, &_oname);
+	oname->len = _oname.len;
 	if (!ret && (dir != fname->dir)) {
 		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
@@ -381,6 +400,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 				    oname->len, oname->name, dir->i_ino);
 		memcpy(oname->name, tmp_buf, name_len);
 		oname->len = name_len;
+	} else if (!ret && unlikely(is_vmalloc_addr(oname->name))) {
+		memcpy(oname->name, _oname.name, _oname.len);
 	}
 
 out:
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index aa6730b48e97..8fcf185e3a82 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -538,9 +538,13 @@ static int parse_reply_info_readdir(void **p, void *end,
 			 * to do the base64_decode in-place. It's
 			 * safe because the decoded string should
 			 * always be shorter, which is 3/4 of origin
-			 * string.
+			 * string. If this message was allocated with
+			 * vmalloc() (happens, but rarely), leave it
+			 * NULL and let ceph_fname_to_usr() allocate
+			 * suitable temporary working space instead.
 			 */
-			tname = _name;
+			if (likely(!is_vmalloc_addr(_name)))
+				tname = _name;
 
 			/*
 			 * Set oname to _name too, and this will be
-- 
2.53.0

