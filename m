From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ceph: checking for IS_ERR instead of NULL
Date: Tue, 26 Jan 2016 12:24:44 +0300
Message-ID: <20160126092444.GB15717@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

ceph_osdc_alloc_request() returns NULL on error, it never returns error
pointers.

Fixes: 5be0389dac66 ('ceph: re-send AIO write request when getting -EOLDSNAP error')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d37efdd..a52cf9b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -698,8 +698,8 @@ static void ceph_aio_retry_work(struct work_struct *work)
 
 	req = ceph_osdc_alloc_request(orig_req->r_osdc, snapc, 2,
 			false, GFP_NOFS);
-	if (IS_ERR(req)) {
-		ret = PTR_ERR(req);
+	if (!req) {
+		ret = -ENOMEM;
 		req = orig_req;
 		goto out;
 	}
