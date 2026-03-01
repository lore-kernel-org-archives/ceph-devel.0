Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E892D8767;
	Sun,  1 Mar 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329113; cv=none; b=AJaSHmq5Vy9Tu7JHyaxPd7hZoF5Dy2Y4v/JWhUPamRlPc6nn8gRjnmN4Qy90nXpZ6FwLqFVTNNYP5y65CLsQeO4eWvLxg/8ub4idR7thiygDLXyKoaBNp1cXMqF/3zvgyLkCA4KFoyTKviGuHpCkQzr3n01SGZgF75NYsYUz+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329113; c=relaxed/simple;
	bh=9Hm/bulQ7bNqMxcM3LTaZdC9gWHLe5JI3tcPzwRc1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkJ1nYygQTfOItbWuyUQ4NV6u7zyaFBfd6I2AcxbB8q7fUT66x828dQCYSquOs9HVWduk41QBcBpKdpgpYUlSF1IExegCnJaBHfhkpjETlAYVTnx8RlkkBdRuNTyVfLf8Ig8s9bNwFN1mUnNt4oGdzqLspBZTvuWF21j9JNmTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCtLmXlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCtLmXlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226CCC19421;
	Sun,  1 Mar 2026 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329112;
	bh=9Hm/bulQ7bNqMxcM3LTaZdC9gWHLe5JI3tcPzwRc1tM=;
	h=From:To:Cc:Subject:Date:From;
	b=QCtLmXlhM1EpOSOp1/sTYoiaXgbqLnqyrkMo4Q/trbvHjBQwkf+yrwAiJlxiFVmzz
	 j5U7+vJhM/WqM7ipBuBiNlZ2aZ+iZdIeJo2Swzvj6MC66Nm+HeK/Ks3JLJncdw40CR
	 X2Yf/Zsqu8g0be28Wg38cU53WAIjCqlGUmWeDE8cPxm614CAVv/VT5UPm9AIm0Yiyn
	 OlgGa6E/CVa1YqdN7unZ98+Du82bwaSCx8OkmfeKPu6fyYS3BhjHRhVBgN/6btbFC/
	 NkEFuka04YJ6QZ/eqq2qIC1Mcwvi7mwGsaCEn0WZNK0b+iQ8jotKN978AATpdGYoNI
	 k0bClSD6P9EYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cfsworks@gmail.com
Cc: Sam Edwards <CFSworks@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: FAILED: Patch "ceph: fix write storm on fscrypted files" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:30 -0500
Message-ID: <20260301013831.1698969-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cac190c7674fea71620d754ffcdaaeed7c551dbc Mon Sep 17 00:00:00 2001
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 25 Jan 2026 18:30:53 -0800
Subject: [PATCH] ceph: fix write storm on fscrypted files

CephFS stores file data across multiple RADOS objects. An object is the
atomic unit of storage, so the writeback code must clean only folios
that belong to the same object with each OSD request.

CephFS also supports RAID0-style striping of file contents: if enabled,
each object stores multiple unbroken "stripe units" covering different
portions of the file; if disabled, a "stripe unit" is simply the whole
object. The stripe unit is (usually) reported as the inode's block size.

Though the writeback logic could, in principle, lock all dirty folios
belonging to the same object, its current design is to lock only a
single stripe unit at a time. Ever since this code was first written,
it has determined this size by checking the inode's block size.
However, the relatively-new fscrypt support needed to reduce the block
size for encrypted inodes to the crypto block size (see 'fixes' commit),
which causes an unnecessarily high number of write operations (~1024x as
many, with 4MiB objects) and correspondingly degraded performance.

Fix this (and clarify intent) by using i_layout.stripe_unit directly in
ceph_define_write_size() so that encrypted inodes are written back with
the same number of operations as if they were unencrypted.

This patch depends on the preceding commit ("ceph: do not propagate page
array emplacement errors as batch errors") for correctness. While it
applies cleanly on its own, applying it alone will introduce a
regression. This dependency is only relevant for kernels where
ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method") has
been applied; stable kernels without that commit are unaffected.

Cc: stable@vger.kernel.org
Fixes: 94af0470924c ("ceph: add some fscrypt guardrails")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3cfe3df6e6a22..c6c853748942b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1000,7 +1000,8 @@ unsigned int ceph_define_write_size(struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	unsigned int wsize = i_blocksize(inode);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	unsigned int wsize = ci->i_layout.stripe_unit;
 
 	if (fsc->mount_options->wsize < wsize)
 		wsize = fsc->mount_options->wsize;
-- 
2.51.0




