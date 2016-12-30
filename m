From: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Subject: [PATCH] ceph: set io_pages bdi hint
Date: Fri, 30 Dec 2016 06:37:03 +0100
Message-ID: <1483076488-2690-1-git-send-email-andreas.gerstmayr@catalysts.cc>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from exchange.catalysts.cc ([81.10.172.115]:10467 "EHLO
        mail01-vie.catalysts.cc" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750918AbcL3F6A (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Dec 2016 00:58:00 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: andreas.gerstmayr@gmail.com, Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

This patch sets the io_pages bdi hint based on the rsize mount option.
Without this patch large buffered reads (request size > max readahead)
are processed sequentially in chunks of the readahead size (i.e. read
requests are sent out up to the readahead size, then the
do_generic_file_read() function waits until the first page is received).

This patch removes this cap and enables parallel reads up to the
specified maximum read size mount option (rsize).

Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
---

Feedback is appreciated. Maybe we should apply a sensible default value
for rsize instead of unlimited?

Please note: This patch depends on commit #9491ae4, which is not yet
merged in the testing branch of the ceph-client repository (this commit
is included in kernel version 4.10-rc1).


 fs/ceph/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 6bd20d7..3c50477 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -952,6 +952,13 @@ static int ceph_register_bdi(struct super_block *sb,
 		fsc->backing_dev_info.ra_pages =
 			VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
 
+	if (fsc->mount_options->rsize)
+		fsc->backing_dev_info.io_pages =
+			(fsc->mount_options->rsize + PAGE_SIZE - 1)
+			>> PAGE_SHIFT;
+	else
+		fsc->backing_dev_info.io_pages = ULONG_MAX;
+
 	err = bdi_register(&fsc->backing_dev_info, NULL, "ceph-%ld",
 			   atomic_long_inc_return(&bdi_seq));
 	if (!err)
-- 
1.8.3.1

