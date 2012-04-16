From: Jan Kara <jack@suse.cz>
Subject: [PATCH 03/27] ceph: Push file_update_time() into ceph_page_mkwrite()
Date: Mon, 16 Apr 2012 18:13:41 +0200
Message-ID: <1334592845-22862-4-git-send-email-jack@suse.cz>
References: <1334592845-22862-1-git-send-email-jack@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334592845-22862-1-git-send-email-jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dchinner@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

CC: Sage Weil <sage@newdream.net>
CC: ceph-devel@vger.kernel.org
Acked-by: Sage Weil <sage@newdream.net>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ceph/addr.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 173b1d2..12b139f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1181,6 +1181,9 @@ static int ceph_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf)
 	loff_t size, len;
 	int ret;
 
+	/* Update time before taking page lock */
+	file_update_time(vma->vm_file);
+
 	size = i_size_read(inode);
 	if (off + PAGE_CACHE_SIZE <= size)
 		len = PAGE_CACHE_SIZE;
-- 
1.7.1
