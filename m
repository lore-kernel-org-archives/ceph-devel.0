Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5826FA6F;
	Sun,  1 Mar 2026 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328461; cv=none; b=aPYnkAiH9TowIRxVtVp7oOY0/Hl5Z1uMwbyGAGlG+v/VC/e40JxKrJMEBIDI7ixwcIeQsBA3GA3sxb3U9PYiL2zlQLRE21qnA7XxjogyQaYtuT57TKAA+qblElBA/Y/sLaVJA357VBSzSgIjJlECJw6UlnQm2r18Wqeyuu9fNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328461; c=relaxed/simple;
	bh=1ZJRjYgyx2humti33PEWz3PkHazKvMUh0JGZWPrhEZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUQxgEIQmbUvpJrjFtsUGQcdkJsZodYsMaCNb2LOmxfSHXcf6tbRUxKD5d3re4IX1h40mGfnOd+8gh0FcfJdlf9gzVqXnGWcmKxKuVVN19/w6MTfP+mr4+k9lmKQWwrSLG0bnzPOq1aeoga8rvj9wkZvVrjtmxBq3EdtZHoq71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLNQt1Gn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLNQt1Gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BC5C19421;
	Sun,  1 Mar 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328461;
	bh=1ZJRjYgyx2humti33PEWz3PkHazKvMUh0JGZWPrhEZM=;
	h=From:To:Cc:Subject:Date:From;
	b=VLNQt1GnaEytH7mG4jFPUhAtEBpFlDGMjkAVkusFCqwa7gLa+9HJRt/uE8H9W/4JG
	 1vYdrC1M4PjDufDz9/OGXO/0iSCXeGgN6xyOvRTAGrCx952MTP8CFwefUAaw0J5PcX
	 pnK7IKrOmfgmExKh9itDkD9UCY69TyiI/okZz2rAvIFBmgsHb9dSAQ+QYqAcGmRfIO
	 0KjKaoPM7pHQOmUWa23EmAGxLx3mz4XH0uTMniP4yRUOdqC3rmSQKpAFQZ/gVoBgKe
	 aTLD6AiNRR1CGC6SPHuba9a4V8KaT6130nyQ9kOd4Wxc0GyCDnijmJf1n56/ud3+uq
	 2nQUtl3N+7/OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ethanwu@synology.com
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: FAILED: Patch "ceph: supply snapshot context in ceph_zero_partial_object()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:39 -0500
Message-ID: <20260301012740.1685213-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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




