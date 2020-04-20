From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH] ceph: Fix potential ceph_osd_request refcnt leak
Date: Mon, 20 Apr 2020 13:40:43 +0800
Message-ID: <1587361243-83431-1-git-send-email-xiyuyang19@fudan.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>
List-Id: ceph-devel.vger.kernel.org

ceph_writepages_start() invokes ceph_osdc_start_request(), which
increases the refcount of the ceph_osd_request object "req" and then
submit the request.

When ceph_writepages_start() returns or a new object is assigned to
"req", the original local reference of "req" becomes invalid, so the
refcount should be decreased to keep refcount balanced.

The reference counting issue happens in a normal path of
ceph_writepages_start(). Before NULL assigned to "req", the function
forgets to decrease its refcnt increased by ceph_osdc_start_request()
and will cause a refcnt leak.

Fix this issue by calling ceph_osdc_put_request() before the original
object pointed by "req" becomes invalid.

Fixes: 1d3576fd10f0 ("ceph: address space operations")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/ceph/addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7ab616601141..b02c050a3418 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1126,6 +1126,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		req->r_mtime = inode->i_mtime;
 		rc = ceph_osdc_start_request(&fsc->client->osdc, req, true);
 		BUG_ON(rc);
+		ceph_osdc_put_request(req);
 		req = NULL;
 
 		wbc->nr_to_write -= i;
-- 
2.7.4
