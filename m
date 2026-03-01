Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351B2E54A2;
	Sun,  1 Mar 2026 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330118; cv=none; b=GkLPHVdCLy+mKgCpQdc0f5hXvviH/cUqGCktRL4LvCGKrIwX0HSvMnaEZ7TeoDSErWVF+twUEyFQuEaGlrwdMsJqjigTgEdLE43DnSsYXZw4Psb3lBI/THtulbHhk1bYRLxnBqNBFsOcF/aPzmw9g2Em/xjAojmvBgu+kUqATj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330118; c=relaxed/simple;
	bh=77NvPrtCl+OSMd8rz2msW/Z24AvO1ImBkDPqGF2X/gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbA8nTiY7rOBQJbkT3pOZBVjXS/DWToImSSazk+E4RMURO+sRUOlH46GxkcwkhyC8TvQfAY75Hg5DuD/eGC65X8C/0KmPCjiHuXNIvzJZcP6PZ53IxB07XPu8t2G+63dQMRgi2Q1EgwAcmOuwTlBXrBAGbxC3/dlYzLq5b6IfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfoqrOip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfoqrOip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91578C19421;
	Sun,  1 Mar 2026 01:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330118;
	bh=77NvPrtCl+OSMd8rz2msW/Z24AvO1ImBkDPqGF2X/gI=;
	h=From:To:Cc:Subject:Date:From;
	b=YfoqrOipgTESMNdvdwA7xI2JhebEIyIBqE4dKwLQ7Zp3Or2UzeYrZCz12mUm/5bHp
	 KlfSoJ6wuYLwNcq+mzUZADhvmkgVUYKoT6cxphfYoCd++WtGPNvFvGNFlTUyLtiXR4
	 jI4MsERr0WpTBwvb72rIEJSG65CQKLvIOdXGpZVGDxcZr0lWO6W/auL0kAhDVkfDXn
	 hH+dDXpKb3lzPi3FNnD5I0BPY0Rc3/hU9oDFWrbAtxRB+UMkL4+mHwmbPrXev83bOi
	 kFAW0Aw9vRzOfQmfbvXqQHd384i/3nwrz+PTTS97BcfzgTmVmS+RBTeG3bqlDNzRIj
	 RVk8Ka+gf/jMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ethanwu@synology.com
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: FAILED: Patch "ceph: supply snapshot context in ceph_zero_partial_object()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:16 -0500
Message-ID: <20260301015516.1722446-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f16bd3fa74a2084ee7e16a8a2be7e7399b970907 Mon Sep 17 00:00:00 2001
From: ethanwu <ethanwu@synology.com>
Date: Thu, 25 Sep 2025 18:42:05 +0800
Subject: [PATCH] ceph: supply snapshot context in ceph_zero_partial_object()

The ceph_zero_partial_object function was missing proper snapshot
context for its OSD write operations, which could lead to data
inconsistencies in snapshots.

Reproducer:
../src/vstart.sh --new -x --localhost --bluestore
./bin/ceph auth caps client.fs_a mds 'allow rwps fsname=a' mon 'allow r fsname=a' osd 'allow rw tag cephfs data=a'
mount -t ceph fs_a@.a=/ /mnt/mycephfs/ -o conf=./ceph.conf
dd if=/dev/urandom of=/mnt/mycephfs/foo bs=64K count=1
mkdir /mnt/mycephfs/.snap/snap1
md5sum /mnt/mycephfs/.snap/snap1/foo
fallocate -p -o 0 -l 4096 /mnt/mycephfs/foo
echo 3 > /proc/sys/vm/drop/caches
md5sum /mnt/mycephfs/.snap/snap1/foo # get different md5sum!!

Cc: stable@vger.kernel.org
Fixes: ad7a60de882ac ("ceph: punch hole support")
Signed-off-by: ethanwu <ethanwu@synology.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/file.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 983390069f737..9152b47227101 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2568,6 +2568,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
+	struct ceph_snap_context *snapc;
 	int ret = 0;
 	loff_t zero = 0;
 	int op;
@@ -2582,12 +2583,25 @@ static int ceph_zero_partial_object(struct inode *inode,
 		op = CEPH_OSD_OP_ZERO;
 	}
 
+	spin_lock(&ci->i_ceph_lock);
+	if (__ceph_have_pending_cap_snap(ci)) {
+		struct ceph_cap_snap *capsnap =
+				list_last_entry(&ci->i_cap_snaps,
+						struct ceph_cap_snap,
+						ci_item);
+		snapc = ceph_get_snap_context(capsnap->context);
+	} else {
+		BUG_ON(!ci->i_head_snapc);
+		snapc = ceph_get_snap_context(ci->i_head_snapc);
+	}
+	spin_unlock(&ci->i_ceph_lock);
+
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 					ceph_vino(inode),
 					offset, length,
 					0, 1, op,
 					CEPH_OSD_FLAG_WRITE,
-					NULL, 0, 0, false);
+					snapc, 0, 0, false);
 	if (IS_ERR(req)) {
 		ret = PTR_ERR(req);
 		goto out;
@@ -2601,6 +2615,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 	ceph_osdc_put_request(req);
 
 out:
+	ceph_put_snap_context(snapc);
 	return ret;
 }
 
-- 
2.51.0




