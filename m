Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC2485CC1
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076732; cv=none; b=ToFLgrqroLclWh5IJMPGc7n4bGpLlpO/2bbV8ICRdM7HXaJNMFvp8n4vRCwRgWeBmzocwfu6n/6F9HG5+JgjSjeUnY5zBkq3bpPiecEPVz8gmYVQpyTmzWF5ccQHCA+2BGzi8Yp3vkobR3pndbFnO9TeJt9W4VJFw6tCI6O1tVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076732; c=relaxed/simple;
	bh=uwMVf0O38dwYPksuPIL39EvOaE6wl/Xh+HGE7GDWUgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De4t/y8Uvdh8mzWHXtA/iZcuikv18+BjlsnMzvOMpNshWkfSTDPfOx/CUkUV8CA2HR+1dRnJQHy76Y+fe4hVm/UMmzjhJBtn7QHRL03LuriqebkQA7nnz5oTw4QugvKL00LBb0gNF+3ajQcqLFpHNFV3h4nh2WqOgQnTV0SQDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=P7MyxuQV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="P7MyxuQV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f84023916so65865f8f.3
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076715; x=1787681515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Of1+ge4btYx5YTxbaLAoVEdDQy7zf8P89P8GZMDVTYU=;
        b=P7MyxuQVSTaCmldDXIOA8psDKMRuEWPuiy6FhsLY1k6S5AkOl82By8+xT3gx5nYof5
         k+s2YV2LQM5jE0IW4GjIagKHJdCeAdATHDL5dyYi0wRTA3rASUE3s4ekG4F9d1DjYIRL
         6XP6FOBcvllEf8BGS/SD3+oUgKkNxxhdVOkl1TN9IYg1gVBZ6t/n7FWik6rQkQHzpjHy
         OLidE7GrYuxd6diieP7j8yTe8DGr3F7oYKi6gX1JJhP+BM5VnMVRHaBMGsheQoR7NPJO
         aKnrc62HTVStODigpEY6R38gAOZidk+g6QnnHb3+LxSaMNlOZccK9A9Ue46cyQa1fKWq
         Sc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076715; x=1787681515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Of1+ge4btYx5YTxbaLAoVEdDQy7zf8P89P8GZMDVTYU=;
        b=MjBGuZ4UbcNCUj9JU4ZQNjUkDaPvgASe/0OmR5ZtyJed6YF4vzBNyeTNBQ/c4IX/8P
         Y7tGIS6+i9Smh7PH2CxWEQ+YRH0+nmVI2NhzzrwS8FZ4XUH0yLK2RuSEkepauqytOj0J
         260XGuJvaSL1Uk+kUz7Nw4TnQgjmzAUesZKbV9PUNyhy1BlVJi7qs1oWfu2zjO2Y3Z9g
         AZfxP4w1vtMA04AGLFmPwqMWjmwsS6jqolZzuSCIq2hDyNEEjScK2FHlpU8IFk0XRBla
         fheBsTCJpgq6+1Tb/jcKFDCDkLFLVqVeRaqI+QBCDKlKgcGPTsIkUZcCcj4z8LJNwIbY
         /myg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4kl0cX7IlQgcZHNRHP2uBSZXoj/HNLJ2GUdsTMDDPv4anLr6KcZQSzo6F/eow0lIfxchYPV748yP6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzezh1x2Wl0pFnMSwSwSWGfLipi5296lmS9PRfrnHFaoUZTaaON
	mvWCl9w6OELSUZMCH8mFS5Kwip5XQrnF3OlN/S87rb22L44DvN5eotl+m+T3IL1X1sToJK9MY5w
	h/HFKriI=
X-Gm-Gg: AR+sD1238ofbTpJwcuUAO4pF4iLmDKZn+9si5b/5EtvcoQjhZc70DDEymT1FvVhO+y9
	gEJA6MgSYdk/gbGJsrtEwjTNqytuOkFbxg59VYcTHe4of1x4lQNVxx5RC5Oy0puVqwj83FZQAuB
	Cjx6eRTZs9GXDD2DDCcAtR9vLyf6wCyOpEWeZyDxq8Nx9gtPjynzJ8GCow0+eHbGerdr3wwLHvF
	bJGs10ABlAKklajfi465BOt1t/EAI4uNphozWC7aMsDW4d7hoCWlSp5X1r64m/FU/u/KN6VcYrI
	jDeaCzluajMSvZqVby0085CIe/HtNsM8R7tBExOQ9n1XIc1QuaArzF1mGdrrE43mvvEZXmfDsN4
	sKRmzpy2surWmGNSL4hV6ByVOauuPSFbJdzsrkUxE5nYEixB9EPN9A2Z0aEejJYF+L+5RlThatH
	YZiIRJhS5fhsSb0F2kFFjkxM5s2TSi6vnnY0yzyd2JRm8I9losO1TViVKoICc1ApCpoLRkO1O/i
	16uuQiW3XTkSidUDN8ayjTFmRzU/joIy23MwuUZp6CXOeyt9VghkdOkud0hejHe
X-Received: by 2002:adf:ee06:0:b0:47f:9760:4d2e with SMTP id ffacd0b85a97d-482a90f493cmr15861358f8f.24.1787076714970;
        Tue, 18 Aug 2026 11:11:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 09/12] fs/ceph/super.h: add `const` to helpers
Date: Tue, 18 Aug 2026 20:11:41 +0200
Message-ID: <20260818181144.3541770-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents that these functions do not modify the parameters.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 35399689f0c1..ab6fa8319c79 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -588,7 +588,7 @@ static inline u32 ceph_ino_to_ino32(u64 vino)
  * we do want to set it to something, so that generic vfs code has an
  * appropriate value for tracepoints and the like.
  */
-static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
+static inline ino_t ceph_vino_to_ino_t(const struct ceph_vino vino)
 {
 	if (sizeof(ino_t) == sizeof(u32))
 		return ceph_ino_to_ino32(vino.ino);
@@ -598,12 +598,12 @@ static inline ino_t ceph_vino_to_ino_t(struct ceph_vino vino)
 /* for printf-style formatting */
 #define ceph_vinop(i) ceph_inode(i)->i_vino.ino, ceph_inode(i)->i_vino.snap
 
-static inline u64 ceph_ino(struct inode *inode)
+static inline u64 ceph_ino(const struct inode *inode)
 {
 	return ceph_inode(inode)->i_vino.ino;
 }
 
-static inline u64 ceph_snap(struct inode *inode)
+static inline u64 ceph_snap(const struct inode *inode)
 {
 	return ceph_inode(inode)->i_vino.snap;
 }
@@ -818,7 +818,7 @@ static inline struct ceph_dentry_info *ceph_dentry(const struct dentry *dentry)
 /*
  * caps helpers
  */
-static inline bool __ceph_is_any_real_caps(struct ceph_inode_info *ci)
+static inline bool __ceph_is_any_real_caps(const struct ceph_inode_info *ci)
 {
 	return !RB_EMPTY_ROOT(&ci->i_caps);
 }
@@ -1076,7 +1076,7 @@ void ceph_umount_begin(struct super_block *sb);
  * a cap_snap is "pending" if it is still awaiting an in-progress
  * sync write (that may/may not still update size, mtime, etc.).
  */
-static inline bool __ceph_have_pending_cap_snap(struct ceph_inode_info *ci)
+static inline bool __ceph_have_pending_cap_snap(const struct ceph_inode_info *ci)
 {
 	return !list_empty(&ci->i_cap_snaps) &&
 	       list_last_entry(&ci->i_cap_snaps, struct ceph_cap_snap,
@@ -1173,7 +1173,7 @@ extern int ceph_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int flags);
 void ceph_inode_shutdown(struct inode *inode);
 
-static inline bool ceph_inode_is_shutdown(struct inode *inode)
+static inline bool ceph_inode_is_shutdown(const struct inode *inode)
 {
 	unsigned long flags = READ_ONCE(ceph_inode(inode)->i_ceph_flags);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1357,7 +1357,7 @@ extern int ceph_pool_perm_check(struct inode *inode, int need);
 extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
 int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invalidate);
 
-static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
+static inline bool ceph_has_inline_data(const struct ceph_inode_info *ci)
 {
 	if (ci->i_inline_version == CEPH_INLINE_NONE ||
 	    ci->i_inline_version == 1) /* initial version, no data */
@@ -1432,7 +1432,7 @@ enum quota_get_realm {
 	QUOTA_GET_ANY
 };
 
-static inline bool __ceph_has_quota(struct ceph_inode_info *ci,
+static inline bool __ceph_has_quota(const struct ceph_inode_info *ci,
 				    enum quota_get_realm which)
 {
 	bool has_quota = false;
@@ -1465,7 +1465,7 @@ static inline void __ceph_update_quota(struct ceph_inode_info *ci,
 		ceph_adjust_quota_realms_count(&ci->netfs.inode, has_quota);
 }
 
-static inline int __ceph_sparse_read_ext_count(struct inode *inode, u64 len)
+static inline int __ceph_sparse_read_ext_count(const struct inode *inode, u64 len)
 {
 	int cnt = 0;
 
-- 
2.47.3

