Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26E37C91B;
	Tue, 29 Sep 2026 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650499; cv=none; b=dGY57WPwxzXStWzC0YBw7t50xrJItbKr3XdHtb6rjLLME7s6zGZrDqGQMCCCwFUUtJVxybXaLTASvB5ks5EpnT0hqQ3aCTK4EEYyZSwwgia+QDHp0H/O/If0QVO+QYOkb8W7kRdOe85ObU20et/tiaByEI5zi6cnoZ38KdxNMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650499; c=relaxed/simple;
	bh=WetBIv07kj4HSY3PA6HBn0ZpqDr40wPwX0vbEiUMf9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTBO3KSeITDHWxTzve7JAdAEn3qN25MTWGC/vA8qiEzDgUMCIsj/lTyjCiRAbOSNSkmBxPjSnZb8OkVgqyXuN0MnHwgUjhVHGoGDFdgeO6CXRIgS/irqjf2s2MULL6XuczpRpq/7IZYyy8WXxn09dXbHa3Zn1mgGfRVbsg/H0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=J+u7Uq+a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N50iWtpH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="J+u7Uq+a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N50iWtpH"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 430311D00127;
	Mon, 28 Sep 2026 22:54:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 22:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790650495;
	 x=1790736895; bh=R8hK1XSNd2V0OzsR2NxKTzT6rlsWcPEn004hSf1pKFk=; b=
	J+u7Uq+a4RsXc0bniVOhn+c1j3dTdaaxRY5r6C+/yi9c1iOY4B4/gqrMkj6NJgBI
	YaoyliKGN8uUNqylAbaxzrfCT1cmd9wynzR6bWyWzNhzAAnMbJ0L2oAiqZhPiz0k
	Y6Cs/YsZRfYhH6jNsdtswWau4CLTsymR7Q2F9Vf/IOrS9Anx1hvsrHqL+3OD7yEo
	KfM+H5POMmyDaIejJIUGN6euXfNZ9jImaScpWaNX4TbGxLOmXxAZVhKslIcqmdhY
	Ackl8IDnGHE3wdRy9mLfSy59GYYLWGIx6I5ETOYRNCI0VzDiXcZay+fixgyuKZru
	BGAD/0v3gXDEtouu2wvkcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790650495; x=1790736895; bh=R
	8hK1XSNd2V0OzsR2NxKTzT6rlsWcPEn004hSf1pKFk=; b=N50iWtpHhf2M8ZS1Z
	bcK0NnB3KgZ1YG6obc85Y1UDi8qPd5R6kjlm/iEwqSs62YiZ/Fz+6VAeDJD3NLy5
	9tyjtHzpC1UOB2ZAcIK5qMAYsCRYOVa4B7ey/6o0GrZPV4xi6sDn3JkAH0Wyy13R
	+GWMbkiSfSsxgaMHGJoVw/2K5eCmDIV34ASKgcTSYYnoJW056CHIu2Hv79lytba+
	WTEgZpB+6zUPn/pMmaVEZAMF3EM2tVTUjH6erxlyChQHpASStV3BStoLqCVegKrb
	NIwb1vdcpPVpkuHsLfYimOXrSluLZYf1XX1IBnYJKsZy3Ql/eZAsXsMLl5B4goJT
	WCfPQ==
X-ME-Sender: <xms:fii7al5kyfg8ctf82e79L7O_E1rbeTksbd09ygGpYbqm5gjQrI-vfw>
    <xme:fii7ahK2DEsvDn_U3bZX08v6Z_Tog3HSSDYoy_sqIH_uyyUUksbLJiJy93rtQDojs
    okcNtN4hXSb99_RsO43oXnTggv0x-PJCo4LGiz2QNORDbARX2A>
X-ME-Received: <xmr:fii7alz148tk2xD8QOMjnN96ybANLYipX3Rembq2J6rqZIy-JSmjQipjXHdRpg6H2p8W8aebbT7yOzVaSnv1nLTjk0ulAIs>
X-ME-Proxy-Cause: dmFkZTFKYCqEexP321uWghjOpW93sfMhbvfA1cxtQil5/LaoWYPKzQMb0JC9utbFplf0s3
    HCVAVWNTDp6w22LqKwfBm3b4T592iz5cYik89g1rioSKCyOBtn6sVLVkZFXvDPI7mjgnFU
    QEx3JN2QCBhEaiq2mDwjfBZ2pBewTbIY5OoCfCVeHwr/svYMqrisr9su+amzPf26UxL97O
    SixFjakEUswZwmBvrx8T+tlXkDN2+NarAEDkOps9f7n1P8K+5jugve3LX9poopqrBppLST
    oEtVfrAjH7fJo/vT4RrVddauLeJ5fQh9p/R52F41ioJ55PMFeqbtCvLGFp/tCvBFBrDJR2
    JzZN7+qEhfPVTuZLmQLqKxZ3FVx+PSA3uVasGn7pu6an+X2HpjrEO9tESSnJqRc4dNv7Bm
    E/iHbdai7Ex01GnatO+8ixQD+WWVf23X58ERpSDq4McGVDEsVL+G1QXJDV404Nsai7uYH+
    f36DNynLXZyezqVUxVpVoLSXJyQkfmD4IpATnTaxAWzTnqvcsdF7v3W+54NqkWcX15Bwbk
    IWtmxyUxKHnKzooj06sUaP7BROg5aE2Fc9LZjyk659r7BJfsIZHctc4gEL+lXPcwfjnndc
    PCRns05Ocn/NWj9Xo1dlrJkEx7k95r1oUz4fmv51KcZ+RDS82VnnoUVARxzw
X-ME-Proxy: <xmx:fii7ahLzNI5gFeQJZ5CXty1fJTlWJ3uA9lOeGT0lfzfP7v1bqukpkQ>
    <xmx:fyi7asXFUJ9HwaEdHL02bvGSuyDMim_jO_ZzaiCDFdYd2MbHJ4QKEQ>
    <xmx:fyi7asad4EvyYNFiqsBXe8_OG1k2FERDrjdVmUnU02nctfXxK671NA>
    <xmx:fyi7arxKPAs6erESwJ8t5f79C9SkSuIgAcsO1VtnXXp0fIu-gLfw3Q>
    <xmx:fyi7asu0EWF3NZ-NrUxI07NwxeX0dnpISyellD4PpKBRMtVEdox_UiEB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:54:51 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cephfs: Use d_alloc_trylock() in ceph_readdir_prepopulate()
Date: Tue, 29 Sep 2026 12:47:39 +1000
Message-ID: <20260929025331.1436824-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929025331.1436824-1-neilb@ownmail.net>
References: <20260929025331.1436824-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

cephfs uses the results of readdir to prime the dcache.
ceph_readdir() is called with an exclusive lock on the directory
so it currently cannot race with any lookup which allocates a dentry.
So it is safe to simply d_alloc() a new dentry and then d_splice_alias()
to install it in the dcache.

After we lift d_alloc_parallel() out of the parent lock this won't be
safe.

The safe interface to use here is d_alloc_trylock() which will handle
any races and can fail if there is a concurrent lookup which is working
on an in-look dentry.  In the rare case that this does fail there is
little cost in simply skipping the priming of the dcache for this name -
some other thread which owns the dentry will fill those details in soon
enough.

So change to use d_alloc_trylock() and handle -EWOULDBLOCK.  Also use
QSTR_LEN() to initialise dname.  full_name_hash() and d_lookup() are no
longer needed as d_alloc_trylock() includes all that.
Because we use d_alloc_trylock() we need to call d_lookup_done() to
ensure the dentry gets unlocked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/inode.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d52e2b389e0b..74a107b6ef3c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2069,9 +2069,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino tvino;
 
-		dname.name = rde->name;
-		dname.len = rde->name_len;
-		dname.hash = full_name_hash(parent, dname.name, dname.len);
+		dname = QSTR_LEN(rde->name, rde->name_len);
 
 		tvino.ino = le64_to_cpu(rde->inode.in->ino);
 		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
@@ -2087,24 +2085,20 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		}
 
 retry_lookup:
-		dn = d_lookup(parent, &dname);
-		doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
+		dn = d_alloc_trylock(parent, &dname);
+		doutc(cl, "d_alloc_trylock on parent=%p name=%.*s got %p\n",
 		      parent, dname.len, dname.name, dn);
-
-		if (!dn) {
-			dn = d_alloc(parent, &dname);
-			doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
-			      dname.len, dname.name, dn);
-			if (!dn) {
-				doutc(cl, "d_alloc badness\n");
-				err = -ENOMEM;
-				goto out;
-			}
-			if (rde->is_nokey) {
-				spin_lock(&dn->d_lock);
-				dn->d_flags |= DCACHE_NOKEY_NAME;
-				spin_unlock(&dn->d_lock);
-			}
+		if (dn == ERR_PTR(-EWOULDBLOCK)) {
+			/* Some other thread is working on this name */
+			continue;
+		} else if (IS_ERR(dn)) {
+			doutc(cl, "d_alloc_trylock badness\n");
+			err = PTR_ERR(dn);
+			goto out;
+		} else if (d_in_lookup(dn) && rde->is_nokey) {
+			spin_lock(&dn->d_lock);
+			dn->d_flags |= DCACHE_NOKEY_NAME;
+			spin_unlock(&dn->d_lock);
 		} else if (d_really_is_positive(dn) &&
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
@@ -2133,6 +2127,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			in = ceph_get_inode(parent->d_sb, tvino, NULL);
 			if (IS_ERR(in)) {
 				doutc(cl, "new_inode badness\n");
+				d_lookup_done(dn);
 				d_drop(dn);
 				dput(dn);
 				err = PTR_ERR(in);
@@ -2159,7 +2154,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		if (inode_state_read_once(in) & I_NEW)
 			unlock_new_inode(in);
 
-		if (d_really_is_negative(dn)) {
+		if (d_in_lookup(dn) || d_really_is_negative(dn)) {
 			if (ceph_security_xattr_deadlock(in)) {
 				doutc(cl, " skip splicing dn %p to inode %p"
 				      " (security xattr deadlock)\n", dn, in);
@@ -2186,6 +2181,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 				err = ret;
 		}
 next_item:
+		d_lookup_done(dn);
 		dput(dn);
 	}
 out:

base-commit: 3879f51857325da9bf3cfb073280257cd16ae067
-- 
2.50.0.107.gf914562f5916.dirty

