Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988E3451CF
	for <ceph-devel@vger.kernel.org>; Sat, 30 May 2026 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110426; cv=none; b=FddEcqVVJRfAxTJKjkoQCvDGedaxnmgq+NfLWgIwyyXLjI/xC4BnB1na2EkeHhkRDADvEx5rYyA/neSKTWcWpJACmHMqdSUFIkFVlNRnwwrRhNfzajvkdSjw+Fs8sXe+/jVxPAqanCwhGQFmR2LYayz4m3UI/3Z4jp/y8mV2zVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110426; c=relaxed/simple;
	bh=Gl+oNEFXUYg1MXuvkfTeuMhC0a+ImFlx8zDMo2wS+O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqncEC5xI/JkUksXQytPiO2coZCfnXRmY2ZVNTPL0SAXsXTio1IvSEfwQyDPsErCKebPAF5zd1yOZf/V5jetdG8Ck3ggtIGoLjMzui/XgKydr76nKsH2VwaVhshv3YY/Fbb7iczbxmEGPpUDAY/uNkbCbGa70dmZpMq5UX2Kju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AExovxBo; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AExovxBo"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69d42abd04dso4456813eaf.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 20:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780110424; x=1780715224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5nVQSaa/q2GpmFlwFp6psfjVa3qOQkwnv2EF2O6PJg=;
        b=AExovxBoNPBzcVs3NHD25Ng9o0Cseqmq850y1lTlQDUVo5jFmr4U/JCvGWl9yCe0x6
         7gPq7q/Yq8CdxdxhhpOLykCAJP2tEmv/D6GD2voSY/AfTZ0mXQidRTA90R0HtQvRW0LQ
         jdBlh6xoXQGR7ezzU+grOip22XBeNXR7V9ytjvHD9Z140ZJeBv0XAdGJ/sm6Qn5W0PyH
         qR0CPpl59DWesGqGsn+/+mR8hk4q9nAIOslpdeayUvPGpfx9aHg9HZgGiU/8wv9XQxAu
         ydS+e18f2lfEPrLT+fld10eC/rxoiBr7qO0WiPMow433nVGB2HjJxmhwYWjIoG1SRZ/E
         iZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780110424; x=1780715224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5nVQSaa/q2GpmFlwFp6psfjVa3qOQkwnv2EF2O6PJg=;
        b=XiUSMV2vhfw9axvfBW5HJ14Ca+9IEf3p/2edjkVTZz57XmZtOYb3tbdZK8ORj2admO
         jn+xYUPT5dkcklMU/eU8HhqZfy+5B99foOQQcGtOrIkOxyU6ZYWV1fS4j9znIdCO56IN
         Ya+ZcfCA7RxPZ6ol0A99NwBjoXBO47Rcfe5wMaJSPja+YsaXLa5WLUgut6/hafVbPrfD
         CUvOHS0Tz8OGL+lQP6HE94tZlhVWgEpzEWMu/md4+RrKAMXUWifRi3cRxdV5lXAcONUR
         Kxrmy5BuyOJcil4+p2ax5ofBOW15gY5PdsC7M5BlfQrohCtk/HPXwvzboJXnMP/qiPCg
         9BRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jZv/f3zClKtYliWZoKCTUxPGzi9Ide6cwc9bbj3udzeF8UpnT5vUSCR0+Hegiz0By8f554pX2Jak0@vger.kernel.org
X-Gm-Message-State: AOJu0YyUydSgQwiFi/b0AnK4QuFm4V98ZcrgNRdaZNW6EDB1bNBrAd8n
	Hxhk1TE/xSrzL1H1S3e48CneSWHbDWTQrhtmSnPy/n89T2RYDAJKLDRu
X-Gm-Gg: Acq92OHSQuSPtGSxgMaQ1EyXbS5CfocNH04xxJMTneQ9QZX1dlaGfYUt4gC+fF7NK22
	13RL1eRdUoXtPnr5B2XcXHvXDxlqKbCISOoe5Nng3bgycDJO1Jyoorndj604dW0bnfRyepgoiNo
	Y12MxcnvQLmDfQl6kVPVgUTnmSxPY+udeXd5zuRjVIFhpaBeEWqAL5gWMR7RJobGFbSXe3vZmRD
	4EJJzUE+K56ov/tncgaOejNeBgZxoduLXy3j4DjQ8JS1n3xZ2FACKuGbyQ+JDo87EUMmUJO2bsG
	Itj5B7jLMmL2RfIMMfJWoTpfLh2PXPGzgZ/AP+6NyTCW3e8nY6uVg1uKysC30NAFs1E+39M1kME
	eZNwNdEjAdop+QwP5/QWVS45ds8TJw6D1+M4YM8w9rKrJiRYY4xhihxNSgZ8U4Jft0LV2nasCIV
	v8DEkX53VJc8WJsfjGy3ZVf4v48C7citWUnqmqulJmbk41cuozs7jLCHFOQHrqqcFgJ2m/Zg==
X-Received: by 2002:a05:6820:4c8a:b0:699:a7d1:5fd5 with SMTP id 006d021491bc7-69e103c26b0mr948441eaf.39.1780110424430;
        Fri, 29 May 2026 20:07:04 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-69e06854390sm2374443eaf.8.2026.05.29.20.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 20:07:04 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 1/2] ceph: pass fscrypt `tname` buffers directly
Date: Fri, 29 May 2026 20:06:45 -0700
Message-ID: <20260530030646.85589-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530030646.85589-1-CFSworks@gmail.com>
References: <20260530030646.85589-1-CFSworks@gmail.com>
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
 fs/ceph/crypto.c     | 9 ++++-----
 fs/ceph/crypto.h     | 4 ++--
 fs/ceph/mds_client.c | 6 +++---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 64d240759277..7493a3acd7d0 100644
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
@@ -357,16 +357,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
 			if (ret)
 				goto out_inode;
-			tname = &_tname;
+			tname = _tname.name;
 		}
 
-		declen = base64_decode(name, name_len,
-				       tname->name, false, BASE64_IMAP);
+		declen = base64_decode(name, name_len, tname, false, BASE64_IMAP);
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

