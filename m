Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500774;
	b=np5GJav6jEVQt5O5xDG1hgrHTg1WmWjDVsNPtabemqtJCRbUkUes+qM3p4oV9qKHKd0i
	 n6MKr60aV5kbBA8cDtYcwxjB3dGo0bM7U7xK6/d5zrVYi0Q1y+nbQI7iHTMburLdFWOTH
	 71hqH32L8lKiAxVdKDzrwlb6rEIs64h8b+8YYnDXhT8Qn3KBufmwBoF0ZaO8wzouXACML
	 k5mNJKM1ih9dbZL82KKD/rm8kOipoYPOvninm7B9un6bheH7+e3BbDhQXl8EupqvuUA4s
	 2fOFnIoR/DX9gHbm7VLLiRVb6Mq3mlvhvku8WIE3uTUMnEhYNq/RAXD5JL4RDj9IOkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500774;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
	b=3jsGymyr/r2dPXbuS6pD6/IDMeJV22qngcFGx1exzqOQYdndS1X5gkFwmImuZ8tC1Rww
	 p5QGnrKyjNxwXSZOBzNIeiA2lZj8kqCmim1XYh04WxqbZ+xiMqsOxYvNTl34hmzn0G6Ui
	 Tk319i7J3J6EBfRhXL8cfFMuI9N90stIgvVv3gt+1oSdO3qlgu5EmvGIEgWOLdeJbzR0R
	 d1SKlx1TG7PfVA62gcwYquHpygljF0fyvjDoYGv8JJyBJfWCj6mt5n1dAKpCpHU6W7ds1
	 QJzJ3vaQq0y50T1jCbcIsOgEqAkrziuw3uwx+Z97xyrPpD7nvvJN+RUYuFyEzg/xGUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WasJzw6Z;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="T/AfZl//";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37D606A32D
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 12:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB37D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WasJzw6Z;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=T/AfZl//
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792500772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
	b=WasJzw6ZeCGGF1V4Rk7wc1kroAkBzZfa6kp1+Us4DAAPxuKyM6zrHPFL+PcnCnijmCDYaO
	3Eyx+u9pbEKnMKNfd7YVABPQu0muSdrsVOfzDafFb0bbdgZC8ZYvFA7Jun6eld3kue3Rjn
	Iu0m3pu/VBpPfgsAvPu4ylAOG+z9KhE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-2pOvnaohPXCADTcBNJxbsA-1; Tue, 20 Oct 2026 12:52:45 +0000
X-MC-Unique: 2pOvnaohPXCADTcBNJxbsA-1
X-Mimecast-MFC-AGG-ID: 2pOvnaohPXCADTcBNJxbsA_1792500764
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6afbe6b47b7so3368307a12.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792500764; x=1793105564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
        b=T/AfZl//r11NPAOFNc6kxNyuPPkrEHu303Itf6+ltvC/eN3J3A7jFZbeSBI2Uo23W5
         en3bqsNlpGaL9alJ+YnCKafbmF3PBw2TNH+r89LMbRLkwazf70J46GtwYmOhtnxwOER2
         n8f+u+j4LevGrryQc/gb82PQs7Sha+aMmdhEKK5oJBIpdrfIOG+P6Rkyk5US2m/yTC4s
         YtDwsRXGvMO1d1IXMr0DWs+meKK8baEkSTpJJThhonXzCYIjnjqzs59eH/CRpcf89pro
         ATuaA7rBlrrO2eubzPQvwvZZDUm+kZo+aFuOEw1BJSz9YKUPh+WGxQ9N46Pzp7rOUUlv
         FCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500764; x=1793105564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=11oaeN/8N1hoT44N2YuHBHNc8eMWNhQWc/HCa490GyE=;
        b=yZhtU8m8+LDWKlYzmCVUMPUxCg2BYwHDx5zOH0F9nrwncdmDy5oXIsmkMQQPaaRjz7
         VxkWF01cFRwsiOKvUPCmIoxNrxRGVPwuyXdPLROdeXHrlDzBOyx2cJK/y+q74YEwZ12n
         gWl3Xl0LD+dSdZ1vN7U5KTg9yZIVci104i0njFgC7Wdk/5xA8NuOsw+e6cwjrDplcngp
         xrhEotQItuiVhx74dR4Z2SVTTXqwWXFMlX0wMjXxENRlezdkjoroT1XspuK8c2AECzUY
         8GwGPlm3GirUkgsQygi31tZXHdTsM3F0NSLWS6StuwMCq0F9wJ26A9Eh1S7ttZwXv2UK
         jPgg==
X-Gm-Message-State: AFq9FYIE+IibiMKfE3CPJKWvy74R0DJthCWvjeaB2FceJ1qw+XxpMjb3
	L9RKVIbZweoM/q5sUiA3mkb3E+gPQL9AbPGh52J7CiyXElYhr4mk+izndSAbh3FrA2vwi2EOlYd
	1FWZl2XJN0XW6I82AtqhQeUZ7dwkSB9gt5xBqs03gpDSH249OjKRYoOjkgJvGbvh9pNYA40lCbg
	7hPWtanDUULEIjcqT0wlU9XX96Nf6oqbW0613U1bCSYk+BJlACzg==
X-Gm-Gg: AYBFou1XJhx5aiM12j8KaT5JJJpTUk/VvgV2mwsQJNHiSlz60tw4al4OzuwTMvjtpi8
	VunAGM48k4BFx4SzfLi4T1mp6THdynXBZFrgWaJuB2ywAK7vkFRXp+jMMknYcBW8Y1vOrCQNUSM
	2VLI4xniy4taTNNf/r3QUlGeldfmHX+86urM37EggwSKn5wmUFlSrctQ4cW+EhMwZBnjYpF91gR
	BkwTBT87pRB86iW4Hd7p/YMtyJUu4reK/XUZzCpYTan9MPVxmQfHCyYhqF8GqeFMNZJqhDUI2Gx
	wHDJVBW4+gs0M42xP3NCIIMH5c7vpB3Dqi5+ssRWL841s17e/ym3rXrxKMtY7khKHJTFxb6EYge
	qeh5OYPuq+csC683PWAuoQWCEw4k+wLZ8HlB90AayTn1Nr/XKpOQpxIuNoM1nYuhP9wdoOwyobE
	MzruaUvEXi276Bic44xwBjmX6FE3p96Ccbn2we/fyqiU4JP190bn8x+1qgJCx7THis77lhH4A4I
	CA=
X-Received: by 2002:a05:6402:4495:b0:6b1:497d:1c64 with SMTP id 4fb4d7f45d1cf-6b3a82153damr6927995a12.45.1792500764119;
        Tue, 20 Oct 2026 05:52:44 -0700 (PDT)
X-Received: by 2002:a05:6402:4495:b0:6b1:497d:1c64 with SMTP id 4fb4d7f45d1cf-6b3a82153damr6927967a12.45.1792500763580;
        Tue, 20 Oct 2026 05:52:43 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3c74eb8a7sm2982781a12.2.2026.10.20.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:52:43 -0700 (PDT)
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
Subject: [PATCH v4 2/5] fscrypt: allow filesystems to disable symlink target caching
Date: Tue, 20 Oct 2026 12:52:34 +0000
Message-Id: <4ef1532159c9312287a604efda1e6a3c0621112a.1792498351.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792498351.git.amarkuze@redhat.com>
References: <cover.1792498351.git.amarkuze@redhat.com>
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

