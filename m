Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209404;
	b=MX3p7Ikh8tbdYJuavhJckt36vf8ZxGVfMw2SCTyipaD8egrX8I84++400tubRFqlYEr8
	 TXUPt8h1MjmAu1KitaUk3v6EwXGkzsKUzN7BYJBaEms5MF6biFs/L9RLEETSfzGPHmfM0
	 yTQ7wNKZIVpNBMRvSrP4bCwCu1G8J8yD2+LKZEcTaYiMFvHcKyL46dEHU/H1jA9oDVn6h
	 BtTjjXkdthyNkirvazCSLD4JqqYEmXgBXpjvNkq9tbX5i17Cp2XYywBjzWqrgy2jqAUZ1
	 19GMZzHED+W4kwlZDAnYq6QCctZbTSyUVb2v1PmX9HSHbL1OqURqeBrVMAQ071c966w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209404;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=y4XXizAsEXauZ8xNy3Uvk2MUwvg11466f+qVHEdRMkA=;
	b=YA7bFut2dHchcl64X4o+XPtv1cza35PINbSfxvzfm2REm+ptisfAO3SpwDdWerUqZLX4
	 vBYjjSaGFGlM/TPOCapFIR58+8CQ79Eeblc6K51I7WEsE1m8V/kV1rFBCVKMr8Y+I7SBH
	 veXkaKvqm2QMueI3UTzoQjXCF1B9fYMnC8kv135oMl/O9u/i8BhIdA3IQf9JSeVhQh1ag
	 Ew5fGJu4VsN7KrG1puqa3BE17si4HL0MalE7ImT3BFkJJWfqtozRsSFqqZMITiFYpNC7q
	 u9IkDtbo3RLl8onkXHYUcHH7ix9wWQF5SMqQNYhMkTASHADeF57TxwqhFXNU9EZoYjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43C606A325;
	Mon,  9 Nov 2026 07:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B43C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jNLys3BPKz22sb;
	Mon, 09 Nov 2026 15:29:57 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Xiubo Li <xiubli@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlzhangak@isoftstone.com
Subject: [PATCH v2] ceph: revalidate dentries under snapdir to drop stale snapshots
Date: Mon,  9 Nov 2026 15:29:57 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAOuZWzx7eg1bNzyoY+kTP2CB4NqwwC23K1RC-etdWW1VyF01fA@mail.gmail.com>
References: <CAOuZWzx7eg1bNzyoY+kTP2CB4NqwwC23K1RC-etdWW1VyF01fA@mail.gmail.com>
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 09 Nov 2026 15:29:57 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AF17675.001 by FangMail milter!
X-FangMail-Envelope: 1794209397/4jNLys3BPKz22sb/6AF17675.001/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794209397.6AF17675.001
X-FangMail-Outinfo: 1794209397/6AF17675.001/4jNLys3BPKz22sb/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794209399.6AF17675.001.4jNLys3BPKz22sb@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF17675.001/4jNLys3BPKz22sb

When a snapshot is deleted on one client node, its corresponding
'.snap/<snapname>' dentry cached in the VFS dcache on other client nodes
never gets invalidated. As a result, on another client node:
- recreating a snapshot with the same name fails with -EEXIST;
- removing the already deleted snapshot fails with -ENOENT while leaving
  the stale positive dentry in the dcache;
- if the deleted snapshot is recreated with the same name on the remote
  node, the local client still reads the file contents of the old
  snapshot;
- a removed ancestor snapshot stays visible as '.snap/_<name>_<ino>' in
  child directories.

Since commit 2817b000b02c ("ceph: directory operations"),
ceph_d_revalidate() has unconditionally trusted all dentries whose
parent directory has ceph_snap(dir) != CEPH_NOSNAP (later written as
ceph_in_snap(dir)). Because that condition matches both immutable
snapped directories (ceph_snap(dir) <= CEPH_MAXSNAP) and the mutable
virtual '.snap' directory itself (ceph_snap(dir) == CEPH_SNAPDIR), it
unconditionally sets valid = 1 when dir is CEPH_SNAPDIR, rendering the
CEPH_MDS_OP_LOOKUPSNAP revalidation path added in commit 200fd27c8fa2
("ceph: use lookup request to revalidate dentry") unreachable.

However, simply falling back to CEPH_MDS_OP_LOOKUPSNAP for every dentry
under CEPH_SNAPDIR would cause every path walk through '.snap/<name>' to
send a synchronous LOOKUPSNAP request to the MDS, because the MDS issues
no lease for dentries under '.snap', the snapdir only has CEPH_CAP_PIN,
and a snapped inode has no real caps.

Instead, introduce snapdir_dentry_is_valid() to validate cached dentries
under CEPH_SNAPDIR against the snapped head directory's snap realm
cached_context. Because the MDS sends a snap update to every client
holding caps in a realm whenever a snapshot in it is created or removed,
we can keep trusting a cached dentry under '.snap' as long as we hold
real caps on the head directory and the snapshot's snapid
(ceph_snap(inode)) is still present in its realm's cached_context, and
only fall back to CEPH_MDS_OP_LOOKUPSNAP when it is not or when no caps
are held on that directory.

Fixes: 2817b000b02c ("ceph: directory operations")
Link: https://tracker.ceph.com/issues/81579
Suggested-by: Xiubo Li <xiubli@kernel.org>
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
Changes in v2:
- Add snapdir_dentry_is_valid() to validate dentries under .snap against
  the head directory's snap realm cached_context when holding caps,
  avoiding unnecessary LOOKUPSNAP round trips on cache hits (Xiubo Li).
- Drop the ceph_unlink() -ENOENT hunk (to be sent separately).
- Update comments in ceph_d_revalidate() and point Fixes: to 2817b000b02c.
- Note: Xiubo, please feel free to change Suggested-by to Co-developed-by
  (with your Signed-off-by) if you prefer.

 fs/ceph/dir.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6eb5b1cb039b..21983e14cb67 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1979,6 +1979,58 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 	return valid;
 }
 
+/*
+ * Check whether a cached dentry under .snap still names an existing snapshot.
+ *
+ * The MDS issues no lease for these dentries, but it sends a snap update to
+ * every client holding caps in a realm when a snapshot in it is created or
+ * removed.  So as long as we hold caps on the snapped directory, its realm's
+ * snap context tells us whether the snapshot still exists.  Without caps we
+ * cannot tell, and the caller has to ask the MDS.
+ */
+static int snapdir_dentry_is_valid(struct inode *dir, struct dentry *dentry,
+				   struct ceph_mds_client *mdsc)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ceph_vino vino = {
+		.ino = ceph_ino(dir),
+		.snap = CEPH_NOSNAP,
+	};
+	struct ceph_snap_context *snapc = NULL;
+	struct ceph_inode_info *pci;
+	struct inode *parent;
+	u32 i;
+	int valid = 0;
+
+	if (!inode || ceph_snap(inode) > CEPH_MAXSNAP)
+		return 0;
+
+	parent = ceph_find_inode(dir->i_sb, vino);
+	if (!parent)
+		return 0;
+	pci = ceph_inode(parent);
+
+	down_read(&mdsc->snap_rwsem);
+	spin_lock(&pci->i_ceph_lock);
+	if (__ceph_is_any_real_caps(pci) && pci->i_snap_realm &&
+	    pci->i_snap_realm->cached_context)
+		snapc = ceph_get_snap_context(pci->i_snap_realm->cached_context);
+	spin_unlock(&pci->i_ceph_lock);
+	up_read(&mdsc->snap_rwsem);
+	iput(parent);
+
+	if (!snapc)
+		return 0;
+	for (i = 0; i < snapc->num_snaps; i++) {
+		if (snapc->snaps[i] == ceph_snap(inode)) {
+			valid = 1;
+			break;
+		}
+	}
+	ceph_put_snap_context(snapc);
+	return valid;
+}
+
 /*
  * Check if cached dentry can be trusted.
  */
@@ -2002,12 +2054,20 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 
 	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
-	/* always trust cached snapped dentries, snapdir dentry */
-	if (ceph_in_snap(dir)) {
+	if (ceph_snap(dir) == CEPH_SNAPDIR) {
+		/* a snapshot under .snap may have been removed by others */
+		if (flags & LOOKUP_RCU)
+			return -ECHILD;
+		valid = snapdir_dentry_is_valid(dir, dentry, mdsc);
+		doutc(cl, "%p '%pd' inode %p under snapdir, valid %d\n",
+		      dentry, dentry, inode, valid);
+	} else if (ceph_in_snap(dir)) {
+		/* snapshots are immutable: trust dentries inside one */
 		doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
 		      dentry, inode);
 		valid = 1;
 	} else if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
+		/* the .snap dentry itself */
 		valid = 1;
 	} else {
 		valid = dentry_lease_is_valid(dentry, flags);
-- 
2.48.1

