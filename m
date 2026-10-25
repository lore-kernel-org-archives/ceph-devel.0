Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953775;
	b=E8XMNqWSFUVyEE4ORYKHJX/j6SbTdlbjV7q9GJ3+yA0osG/kzVn7YlTR4zpEEs4eJ8QO
	 tTC9QF++9gMoooAuRSv61L7j+bugLTVaySEfr4teoLWFYXES9GDm8PlMRUz7dMrHNoQ/W
	 cvaI1tJgswTphp4qz3OHfONsWm5njjEqNYjLG7JG6SmcgB8vRUic2oAsSTLq5GHwBfxZz
	 Aub1urW3uix9KHeY0FMYO2M5whPKiLkPBjFJO9guPIVs8FKVohu245qgh+CVXAICAaUDt
	 0IDa4Py3fRmAgH6PDs2c0z1Jgn/PK4H0tlSUJJYAW8aUmtWAdENFNfgcv5wo4AeFZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953775;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zEq3fV+AI6+Jq6Ar+nT4ArTrmS94UcpXesUCpWADxJ8=;
	b=apTwhw/RJLOYa1eVLnlRxHi/UR6A4EADMDRJIgbxbixHFB1QtC155DaoHwMP9iYCxsmm
	 lcOO/ID8vqFdlKlcZngAdH+KENh8ZPq+hap0r415HFT2YW5jPsSzR/WgS4rIw7AHgjJti
	 92+aQm4lvPZHMJj8LZWIxJqk/TzsUNL+LdkoaYwv+r9YIhbnGZ3um6P6vtUV2x5fO47nW
	 Mvs9RrI3B9jDg9GRBk+dG5FZsBUd1B9rO4ZQ60IBmHvR/xJjJFjzglKMyx9EvLRLTv62P
	 x0tJpOqaJ25uVDmlk0O4S2+Wvcw1TQ+GeEqc0OdVzE17jE2pYqbgyrK9QIwozyoNCQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OmOZk11g;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qF3p9Apk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AA60A2603
	for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 18:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B18AA60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OmOZk11g;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qF3p9Apk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792953773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEq3fV+AI6+Jq6Ar+nT4ArTrmS94UcpXesUCpWADxJ8=;
	b=OmOZk11gcXdYm7wJ44/C2qICUyuObPNxFokaPipuM5pbx8pLbteSBLzA7iSdFKpMPCb8yq
	SkGXDbzjuxIr2i1s9jOo8Fzf310FrDWUpgLx4f4Bq9Z7+3JByVu8N0C+JyLX5rcN/Le4/a
	328hyFw9mCZo8hwIYiQowvK6UM3Id74=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-mPBpJ_W3N7W5-pWv4NC9rQ-1; Sun, 25 Oct 2026 14:42:52 -0400
X-MC-Unique: mPBpJ_W3N7W5-pWv4NC9rQ-1
X-Mimecast-MFC-AGG-ID: mPBpJ_W3N7W5-pWv4NC9rQ_1792953771
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c414c206673so262934266b.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792953771; x=1793558571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zEq3fV+AI6+Jq6Ar+nT4ArTrmS94UcpXesUCpWADxJ8=;
        b=qF3p9ApkwLiKfPnGrfVeWryTCEvGSMwplkt+ENqnifmY4yk/LOENzAUL5wUD9MbXJ+
         I1mKZsQ638WraIRJEWIgsiJn6NCSlwLumvpqJIHeQRU925xdRuWUv7Ex7+8s2IvSU8LM
         yYmAgre4Y3wLxsYzs3GZanCZo+E1r2h7waRChIPqdrffC5p8HHJaxWdLc7zPblLiG62x
         Bz/aHKAywTTq8FRXfkPwG3sXgJu24/YG9AWIu0KX3xYTb946nMoaDjed97V5NXP/MpVu
         6yzdmPV5c1ZNJBmOa6xK9uUXbnb0QYz99eaMyKE2apRORifL56Bhv42JbaNY/F+aKFl1
         LRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792953771; x=1793558571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zEq3fV+AI6+Jq6Ar+nT4ArTrmS94UcpXesUCpWADxJ8=;
        b=DDXuxjxIgyCLJAzm4y39Q5tOaSQFhN9Z9+gV6v5b1u9oOmz0hifNjx5ZOE6dGhZ9Dw
         ifUIRCU7Z1oJ7tTf1K+llB5ERtgDoRgluDEixukWGlkXjS084jLC+BVuRp6uQ7gNVbcn
         FYR8YgZ9RBjAEEE3hUZuUutDGeIgMTnvYEk4iA3S/3F82p1skPLlYu5jMlKqKsRPOhJN
         trYHZvcS9gFnUPBNylemEZsD5nYs4uaB4yv1OvjXQ6FMYxqAOjLjcnuXqdYjDIzHqsw8
         vvl1XFlOpbNSzu9mppi7S28377D8z0Lpn243Myh0wMmKwGV/vnPRv1vKw1iIWJZ7TA0k
         cdZw==
X-Gm-Message-State: AFq9FYJ/D+x34/JcPRW3YZRn1dBiQ4ZlqpMhZ6VgJ1+7PQuG6FFgqUSU
	cRrCjN1xLv6MUaGhRYzBx+WpY32iKaOjS+QODjwXlTxRJgVEyK1oGgU02pGCOJjgxN8mSTaGPyy
	xifqtS9ThUkNAZ6dcOXwwnuIm/ZO9s8GQOmuiahFC4oaEJw052GUcjLJAAK+9zbMmjFNns7RbUQ
	FCGsxJ0MOQcECdKFJx5L8zb9gQRcDEqgJRUo3Vb0Czeakv9MVqwg==
X-Gm-Gg: AYBFou1xZmTjzeY7PJq84qqPD/axRl8zncoNCRKUqlJVNtQltwRl20zjfAasSUZXrC1
	QBjpdd8o6EjW35vjgjOei9eIP3cngo1aHPpozm8RgOWuUpurOxZBxlK/p8zeWkdnHrAMez5FE3Z
	OjyAdYOyK6mxnnTQJQGcO1DRLoepFFhz94n2JwB32bqbHxo8sU6y1w09oQ/IBb8SR38atu+QVOp
	OhmFC26BmDcaArIth99nFRjMzTAaiqoqha+U+YbtcimFU3DRrvIhC28VFz+aLGXAcbzgJZ04Ff+
	Zs4BKhVD/wxBB8theVpFQaC37oIK0Y/tgdnhetLWEvjAqEBkHaVdadJsKaE7451LOZ9Q0cEo0Br
	sO3gTYuQ2Kqx5p2dvnBKdwDTm0U2B+mGiUyIOtLEhSE+i3nN0OtwW5Uf7j67QGuB/hHoVkX5agB
	b4+jGol8qqE/jasaLHWXp1iyg65Lt8tj1TOPiUH7e5cpmX/2L9q6/omYqz263eiFvsCTO6VY6/8
	2g=
X-Received: by 2002:a17:907:9412:b0:c40:a4f8:e036 with SMTP id a640c23a62f3a-c46bdfde8d6mr601521266b.43.1792953771053;
        Sun, 25 Oct 2026 11:42:51 -0700 (PDT)
X-Received: by 2002:a17:907:9412:b0:c40:a4f8:e036 with SMTP id a640c23a62f3a-c46bdfde8d6mr601518466b.43.1792953770582;
        Sun, 25 Oct 2026 11:42:50 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm230750866b.64.2026.10.25.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:42:50 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
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
Subject: [PATCH v6 2/5] fscrypt: allow filesystems to disable symlink target caching
Date: Sun, 25 Oct 2026 18:42:42 +0000
Message-Id: <aad6b176009101cb8dbf42e4f8c62a1883400050.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
References: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
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

The VFS can return a decrypted symlink target from inode->i_link without
calling the filesystem's ->get_link(). A filesystem that revalidates
access in ->get_link() therefore needs a way to prevent that cache from
bypassing its checks. CephFS quarantine requires revalidation even for
readlinkat() through an O_PATH descriptor opened before quarantine.

Add a filesystem opt-out from decrypted symlink target caching. The
option is fixed before inode creation and prevents both creation-time
and lookup-time cache installation. Uncached targets use the existing
delayed-free callback; cache readers need no special handling because
the inode has no cached target.

The Ceph quarantine access patch selects this option. Encrypted symlink
readlink, traversal and lstat then allocate and decrypt a temporary
target on each access. Filesystems that do not opt out retain caching.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/crypto/hooks.c       | 28 +++++++++++++++-------------
 include/linux/fscrypt.h |  7 +++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index a7a8a3f581a0460537f5ff955bc8b5d30573a033..6bc7ac82ec3470d633f2203a40c00a422b8e76a3 100644
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
index 28f2108e29f3976ebe861c425b129ac0acec479b..ab77e685c75c5d1132db82e5cfa718ba6b2847fe 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -108,6 +108,13 @@ struct fscrypt_operations {
 	unsigned int supports_subblock_data_units : 1;
 
 	/*
+	 * Don't populate ->i_link, so every access calls ->get_link() and the
+	 * filesystem can revalidate access. Set before creating any inodes;
+	 * this option cannot invalidate previously cached targets.
+	 */
+	unsigned int no_symlink_cache : 1;
+
+	/*
 	 * This field exists only for backwards compatibility reasons and should
 	 * only be set by the filesystems that are setting it already.  It
 	 * contains the filesystem-specific key description prefix that is

