Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763E305675
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850762; cv=none; b=MqncZT81yFIAgOYG/oc51CJleq1bRwdL6t+p9m9IAs1DZGl5hnNVXLIb/biNIDUBmwJuVXJ0kJrFiuHCtolHZG2/J7F/mlTM/zJz+sIuMF1LjLzRCvpjYEOGc0psm362tci+ZbEFpWKBiYLwKHB1Aw/xW10XKhxZgCtemxfdWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850762; c=relaxed/simple;
	bh=ENW+Jh9GjVaADer3GH8/vF16gW2KGubnHMr5bU7vLTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaTuar75qoxk65tzYHgi1t2K/awAMM8N13CDdppH9PjN4aC365RfueD4NHmj73OBhyHiiI4mXi3lexdnaz5Up40mMg/mnkrEFGWo4oWxZMO74ebioWyiSYHemM6jbLwungRPrjdXpeowg3E30+UY4zceDXeiMMXlyutOIu1+7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc7qg8Wn; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc7qg8Wn"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43b57ee1480so1626425fac.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779850760; x=1780455560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2HVx0cIWNPm75Mm5KDsYNcRwTeRpFNb85G0UNLDiN0=;
        b=nc7qg8Wn+O5TgItM2FLMBtYEDRZCuiBRSHmFkYTps/Xb0+/eqx0lN4q2U5442HLElT
         nYOEmgaQIWmupguT69Xsh7/6cvVV2sCSDIFB0T5Y3ecQ8SzDsw/akM5b0QqJevdTE9iu
         4RtDSnJmeiF85H2/H/4CavMHjab1saAXNqr2aiVaniV9jxBtwNOdsRWIcNivz9PccLSq
         YuTHv/YAUo/hhwbEnG6hKV5QazhqrviQtwmlI2s3CsLcqm3fDsCvxKqApUOKtZjzC5qI
         iA99ZwGzaLGfZMerEn9WBNglcQssJWFVdzScBLp0pJZm6CnErdLpoqtVckg360DClY0R
         TiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779850760; x=1780455560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2HVx0cIWNPm75Mm5KDsYNcRwTeRpFNb85G0UNLDiN0=;
        b=CdOT7LIVYOZ/47e3nFcGVNavhtVLwle3oi7cQ6x7hA0ao/5+C1M17TRDo3hzkBZTul
         IaghqThdDeRTuYDgAPIuklyZZnec6VtNEx0DuoC+ghGgJtdmP0atjGnk+5apZ0OHCz/j
         srUEYSc4yLzXp3DEGC+KqjgG1ya0rCqV6wgURe1JSx5leqTA00RYB1s7PwZ8F2KjUgw3
         qxl0xrZlk2qI7CKI9PLUsbdlSuEUCUK6HwrZuKeR45ydGQ8oXvzYpQOR77hOVbCxanmy
         f0Cu+NxknCx1JlkmJoVz4tNrnX2/gIzXRaoLjw1oiVbiuFNjX8yzzxndHrpVOPFQWgLl
         t9SQ==
X-Forwarded-Encrypted: i=1; AFNElJ/E8TOThLurB4MW1C1GEjiCgAZQpMiavAWktr64xeVCbpV6Y7WukSUxQ07yE3g4IkhQx2218mJsXi1P@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYEDYsEusp5T+NfW0lDYuQBnEtLfbD3fYEjwPgY3UekcP3F8a
	0UBOv2GIH5DwMXVGVHhwVI8IsWvbkyRZBeB+xKSo232EcAOnf2KipZ5U
X-Gm-Gg: Acq92OEP5bpzqouAMavpx6WMSIII9PR4/HzYIdBXCn6gxLxBkC/tKLBlWxOSwiAUdpa
	IcvMR2ECaYCgRUpYER0XXyh3ZjME3UMIuc6ly10ATzoUrV2o0TYEdRgfSaXEf+aHhhCG8EYnbEx
	hp1yjw4NiyCtApdWGN8D+R1dEjvIbL0bXGQuTj205HQ6tjLLsLbWnICm4onxsTUL919+kP17F7Y
	o3qX7MtSM4ia0RYSiXD+GoDfIXF06Zx3q3dmavf2SxiTUgY0HnGcyf1tf6UvxZ1392wOaX+iO0y
	PCcprvqIQksjGlED/zmVWeCnOtN/vqcovRThcF+R60dyPCYIA3NfiDUfVUtEivvliuTtS1oJgPZ
	265neNOvNk/+Y2oU0h0yiCtC2Ft/tl4tml765X/JS9FI9MHPwgb7ROF/yPjM7jkoMY1AlFePXAT
	q0cRcTpIpDomw6CTSaFgwlxcJqooyGqiPj66YrtQASJnSAFgyvpmBmU3DHcXeMssTOub3MVA==
X-Received: by 2002:a05:687c:20b:b0:43b:5d42:ac34 with SMTP id 586e51a60fabf-43b5d4c15c3mr9548737fac.36.1779850759891;
        Tue, 26 May 2026 19:59:19 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43b63976dacsm14863732fac.11.2026.05.26.19.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 19:59:19 -0700 (PDT)
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
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 1/2] ceph: pass fscrypt `tname` buffers directly
Date: Tue, 26 May 2026 19:58:27 -0700
Message-ID: <20260527025828.5966-2-CFSworks@gmail.com>
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

ceph_fname_to_usr() needs a temporary buffer for some operations
(currently only base64-decoding ciphertext) and it is convenient to
allow the caller to specify this buffer to avoid a heap allocation, so
it has a (nullable) `tname` argument. Until now, this argument was a
`struct fscrypt_str`; however, this is unnecessary for two reasons:

1. `tname->len` isn't used anywhere: ceph_fname_to_usr() assumes a
   buffer large enough to hold the ciphertext, and
   parse_reply_info_readdir() -- the only caller to use tname -- doesn't
   set it.
2. While the `tname` parameter is documented "may be NULL,"
   parse_reply_info_readdir() always passes it but with `tname->name`
   sometimes NULL in violation of the contract, indicating that the
   unnecessary container creates actual confusion.

Therefore, change the type to `unsigned char *` and pass the buffer
directly.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/crypto.c     | 10 +++++-----
 fs/ceph/crypto.h     |  4 ++--
 fs/ceph/mds_client.c |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 64d240759277..7515cb251226 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -300,7 +300,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
  *
  * Returns 0 on success or negative error code on error.
  */
-int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
+int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		      struct fscrypt_str *oname, bool *is_nokey)
 {
 	struct inode *dir = fname->dir;
@@ -357,16 +357,16 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
 			if (ret)
 				goto out_inode;
-			tname = &_tname;
+			tname = _tname.name;
 		}
 
-		declen = base64_decode(name, name_len,
-				       tname->name, false, BASE64_IMAP);
+		declen = base64_decode(name, name_len, tname, false,
+				       BASE64_IMAP);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
 		}
-		iname.name = tname->name;
+		iname.name = tname;
 		iname.len = declen;
 	} else {
 		iname.name = fname->ctext;
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index b748e2060bc9..79cb563fd887 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -115,7 +115,7 @@ static inline void ceph_fname_free_buffer(struct inode *parent,
 		fscrypt_fname_free_buffer(fname);
 }
 
-int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
+int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		      struct fscrypt_str *oname, bool *is_nokey);
 int ceph_fscrypt_prepare_readdir(struct inode *dir);
 
@@ -204,7 +204,7 @@ static inline void ceph_fname_free_buffer(struct inode *parent,
 }
 
 static inline int ceph_fname_to_usr(const struct ceph_fname *fname,
-				    struct fscrypt_str *tname,
+				    unsigned char *tname,
 				    struct fscrypt_str *oname, bool *is_nokey)
 {
 	oname->name = fname->name;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705..aa6730b48e97 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -488,11 +488,11 @@ static int parse_reply_info_readdir(void **p, void *end,
 		struct inode *inode = d_inode(req->r_dentry);
 		struct ceph_inode_info *ci = ceph_inode(inode);
 		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
-		struct fscrypt_str tname = FSTR_INIT(NULL, 0);
 		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 		struct ceph_fname fname;
 		u32 altname_len, _name_len;
 		u8 *altname, *_name;
+		u8 *tname = NULL;
 
 		/* dentry */
 		ceph_decode_32_safe(p, end, _name_len, bad);
@@ -540,7 +540,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 			 * always be shorter, which is 3/4 of origin
 			 * string.
 			 */
-			tname.name = _name;
+			tname = _name;
 
 			/*
 			 * Set oname to _name too, and this will be
@@ -557,7 +557,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 			oname.len = altname_len;
 		}
 		rde->is_nokey = false;
-		err = ceph_fname_to_usr(&fname, &tname, &oname, &rde->is_nokey);
+		err = ceph_fname_to_usr(&fname, tname, &oname, &rde->is_nokey);
 		if (err) {
 			pr_err_client(cl, "unable to decode %.*s, got %d\n",
 				      _name_len, _name, err);
-- 
2.53.0

