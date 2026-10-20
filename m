Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528025;
	b=xzm4dTu+a7SpAP/Vitu5noS70rAjz4wuW6+ZSflrOZ9pt/qXBTIQHqvyRpDSgwfxfizw
	 PxnfUYYA66zdqwIrGcJrPUkregQfub3GsCBCwK/k5tUCweAQPHFaVUklvoikW5nXADexR
	 n4R0NXaKqYrlW8L2o4FzsYSBqhg6ZPMwFcpk3uZ6TAwNC88nvkx1fdgdWKu9WrqKeGxXx
	 SbqF+BbA8mkvdLe5UrL4FpKy0CoMLSqDn/7qiNth8i2sfL/m0+TQ4eCOmksDgTZwPvu+J
	 1CWvkhCWm6T+gMzV03g4YkabwiBdtx81TrXvqDdNc87QKH0qeu9Zdyo8vvjm+nxmc5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528025;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
	b=SDtKHPhmfro5qbhB13n3ZwNKZwkFTBbFUVatyOgRMBa9pyXiuFWtKnGODewa7OQACCaO
	 nfPSHw/UIjCvHO/UjG/V3uufH3QUhx4bJAkB7Ectq4QjsNatDk1Bu8NHLCSD3fB9GPa9u
	 jlIM90DlzjHy0ClmyBKy5JK+arZtdQvqcqUQikBHg13R3V189DHrDlK6FfSrzDvcaGc7w
	 /5XHFkQ2FgUj0T71jTVwEP7QXK0ETDfqfpeNdtSyGjSl+XMXapL0Y9mamQi2Pw2Ejwrrn
	 IxC8dnZ5gGBAzdNVQ8qgTg+m0NZhnWYBu0t3N+/bBm7dX1VZhSTGGY2YO29D6AhE2Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B9FhoizM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F9t+xOcV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4268606A320
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 20:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4268606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B9FhoizM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F9t+xOcV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792528023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
	b=B9FhoizMBGB9AIOLMDK+Q/AD9D01TRiQmZviUH/QAyWdS88YfWz604bL7Z4DoUkWCZwZaS
	c/FnXwTlwYAo7SgIDrJe8WICFAGW1cjTZaciNaGnlPNj9p9HKfrrWHTx4rc24tEjV/Y3vc
	WN4uvynyp+jbqHTAFZwSPIsCkimDYGE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-oSydiKPTP9SJjgPQ48Zylw-1; Tue, 20 Oct 2026 20:27:02 +0000
X-MC-Unique: oSydiKPTP9SJjgPQ48Zylw-1
X-Mimecast-MFC-AGG-ID: oSydiKPTP9SJjgPQ48Zylw_1792528022
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917a7fffbe0so1753006d6.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792528022; x=1793132822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
        b=F9t+xOcVCMZ2b6NV69G5TCTuuexVxgSwJb8b4gdLlulNr93AVnkzT4kvccau4eU15z
         TO83oJyTPjixkOv79QhmGt9iqBdVvtg7SAjTdz5Jz2F98+Q2qt/YfXlB74Wi7JFMevfp
         MSBJTu6eAQQKsP4YY3hs5Xp+ht4o08DoySgobd/eASbr2ZZ3dMHw1KtlSa/zVTfquYJN
         UrAdOuYoLutIDHx3exJebqY/s4ax2BevQkRQBoik3Etmg9HKzFtYC+t/BiXCiTJSrR6u
         xEOJovelL4xLruoY5/tTWvhKWLXTu50ui1dckyHya9pkghXZD7AlQvbRN8gBRRIHfJsR
         gfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528022; x=1793132822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
        b=OKwG1KSwE7Ds3GuFtG/xzWd9Ui7XgYmXvktbxRPmxSC1c0bbSPZi6hOR7qvdF3Uzdo
         wsX1ojfeCoEeRKX9+y5Lu1093CcmIuiFtCWFnpNJow/T6NgkrtOGMiIS36nhOqS1fT5Z
         wRKf6lgbVZOrGKcCdz28KGBP2U98yzzKszgXoNnSoaTnMs0kvV98mmoFx6mvVTCublnp
         VuJos6X6NWSnZx0dsZ6JgvpNQxQlsLwNC9ZmishGDsYf9xoA/8M703ZQsvk2hQUX6Hry
         fs6U7as799cpCIc+li5cLfUgSZG9kkdVp88HU+whhstv+w66G49Y4AvxGddVQ/jbrS4l
         /DuQ==
X-Gm-Message-State: AFq9FYL4RCRYspFZs0nd6Fmm9vNPgI+Gsvm96Q8GGnhdLmVQEZOE3FE3
	T6thp7e/h0nAtxST/5L1zCtY+YXz/lrUO6S4AtD5RkuUaengpAkDuROiqzyjEbt4kuyfwGGh/ph
	rj6nozYds0JeXrL+19BUl7svzmjVhYCAQ6SZcxMBNIK5xlsH1c5987ziKa98YZsai+MFJb3R5pk
	61hNaGMfoA/Sy8eTJv97MPdkxvrdFaQUonmRMkd44qAFkiip7XaQ==
X-Gm-Gg: AYBFou194fDJWvhwmFiOYfW4OyX/BA5R23u++pkJK+H1ZVp/COmZ7yQnlIlo0nI7x8D
	ZwcAsIg6XKiV5WfON0mg8QEvr7cP5PH4LOOMUQnSd0eNptnIUhytF/NMA5lbbmHtjQUpDxNota/
	hpQtZRqyiExAeuvM84l/2yqNMBRbn8SdQ88Kh0d5Jhxxqe3rXXzv4K9+9eAipm9LIWCG0x5Wt0h
	EhBFiDU1fq8YEwCrVfRKACraXUMGDFsoEM/XSxoHi3pW6Y9DzJuZXiQn/+vXHfD6lwhbChreK0B
	BAj4/g21aYiK8DG12PO30OCkQAN1L7TjHwtqpMpcQV3gfODVlGRKj41h3jNGcRmkiuVdkfufBMg
	qy3e4lp4D6QsesotytESBCrPFYJLMU+ENS41TLH1VOo4Ox5kNo8gbLoJ/3izbtWVUsjCMfP7srK
	RYMKTQuFELx4k7sXKta2imBbDiAjp+6j+wRi3YHINxuBvf4pentmbD+nxOJRVEC6aWejbz8NGPi
	8E=
X-Received: by 2002:a05:6214:598b:b0:91b:5d3a:f13a with SMTP id 6a1803df08f44-91bdf62e3e4mr201889266d6.57.1792528021808;
        Tue, 20 Oct 2026 13:27:01 -0700 (PDT)
X-Received: by 2002:a05:6214:598b:b0:91b:5d3a:f13a with SMTP id 6a1803df08f44-91bdf62e3e4mr201888746d6.57.1792528021147;
        Tue, 20 Oct 2026 13:27:01 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm7461436d6.3.2026.10.20.13.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:27:00 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] fscrypt: allow filesystems to disable symlink target caching
Date: Tue, 20 Oct 2026 20:26:47 +0000
Message-Id: <4ef1532159c9312287a604efda1e6a3c0621112a.1792527529.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792527529.git.amarkuze@redhat.com>
References: <cover.1792527529.git.amarkuze@redhat.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fscrypt caches decrypted symlink targets in inode->i_link. The VFS
can return that target without calling the filesystem's ->get_link(),
so access checks in that callback cannot revoke a previously cached
link. CephFS subvolume quarantine needs those checks even when
readlinkat() uses an empty path on an O_PATH descriptor opened before
quarantine.

Add a filesystem opt-out that prevents both creation-time and lookup-
time cache installation. Leave cache readers unchanged: the option is
fixed before inode creation, so they find no cached target. Uncached
targets use the existing delayed-free callback.

Opting out costs a temporary allocation and decryption on each access
to an encrypted symlink, including readlink, traversal and lstat. Other
filesystems keep their existing caching behavior. The Ceph opt-in is
in the quarantine enforcement patch in this series.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/crypto/hooks.c       | 28 +++++++++++++++-------------
 include/linux/fscrypt.h |  7 +++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index a7a8a3f581a0..6bc7ac82ec34 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -321,11 +321,13 @@ int __fscrypt_encrypt_symlink(struct inode *inode, const char *target,
 	 */
 	sd->encrypted_path[ciphertext_len] = '\0';
 
-	/* Cache the plaintext symlink target for later use by get_link() */
-	err = -ENOMEM;
-	inode->i_link = kmemdup(target, len + 1, GFP_NOFS);
-	if (!inode->i_link)
-		goto err_free_sd;
+	/* Cache the plaintext target unless the filesystem revalidates it. */
+	if (!inode->i_sb->s_cop->no_symlink_cache) {
+		err = -ENOMEM;
+		inode->i_link = kmemdup(target, len + 1, GFP_NOFS);
+		if (!inode->i_link)
+			goto err_free_sd;
+	}
 
 	if (!disk_link->name)
 		disk_link->name = (unsigned char *)sd;
@@ -411,12 +413,12 @@ const char *fscrypt_get_symlink(struct inode *inode, const void *caddr,
 	pstr.name[pstr.len] = '\0';
 
 	/*
-	 * Cache decrypted symlink targets in i_link for later use.  Don't cache
-	 * symlink targets encoded without the key, since those become outdated
-	 * once the key is added.  This pairs with the READ_ONCE() above and in
-	 * the VFS path lookup code.
+	 * Cache decrypted targets unless the filesystem revalidates them.
+	 * Don't cache targets encoded without the key, since those become
+	 * outdated once the key is added. This pairs with the READ_ONCE()
+	 * above and in the VFS path lookup code.
 	 */
-	if (!has_key ||
+	if (inode->i_sb->s_cop->no_symlink_cache || !has_key ||
 	    cmpxchg_release(&inode->i_link, NULL, pstr.name) != NULL)
 		set_delayed_call(done, kfree_link, pstr.name);
 
@@ -442,9 +444,9 @@ EXPORT_SYMBOL_GPL(fscrypt_get_symlink);
  * This requires reading the symlink target from disk if needed, setting up the
  * inode's encryption key if possible, and then decrypting or encoding the
  * symlink target.  This makes lstat() more heavyweight than is normally the
- * case.  However, decrypted symlink targets will be cached in ->i_link, so
- * usually the symlink won't have to be read and decrypted again later if/when
- * it is actually followed, readlink() is called, or lstat() is called again.
+ * case. Unless the filesystem sets no_symlink_cache, decrypted targets
+ * are cached in ->i_link, avoiding another read and decryption when the
+ * symlink is followed, readlink() is called, or lstat() is called again.
  *
  * Return: 0 on success, -errno on failure
  */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 28f2108e29f3..ab77e685c75c 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -107,6 +107,13 @@ struct fscrypt_operations {
 	 */
 	unsigned int supports_subblock_data_units : 1;
 
+	/*
+	 * Don't populate ->i_link, so every access calls ->get_link() and the
+	 * filesystem can revalidate access. Set before creating any inodes;
+	 * this option cannot invalidate previously cached targets.
+	 */
+	unsigned int no_symlink_cache : 1;
+
 	/*
 	 * This field exists only for backwards compatibility reasons and should
 	 * only be set by the filesystems that are setting it already.  It

