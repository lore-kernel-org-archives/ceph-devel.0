From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH ] fs/ceph: Remove the useless judgement.
Date: Mon, 17 Aug 2015 08:46:17 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C1D19FC1F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22730 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbbHQIqc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 04:46:32 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sage@redhat.com" <sage@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "zyan@redhat.com" <zyan@redhat.com>


For ret != 0, it already handle. So skip this.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5ecd3dc..17cc357 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -276,7 +276,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
        if (err)
                goto out_req;

-       if (err == 0 && (flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
+       if ((flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
                err = ceph_handle_notrace_create(dir, dentry);

        if (d_unhashed(dentry)) {
--
2.4.3

