From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 19/20] fs/ceph: Use kzalloc
Date: Thu, 13 May 2010 22:07:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005132207120.6282@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Use kzalloc rather than the combination of kmalloc and memset.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,size,flags;
statement S;
@@

-x = kmalloc(size,flags);
+x = kzalloc(size,flags);
 if (x == NULL) S
-memset(x, 0, size);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 fs/ceph/mon_client.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -u -p a/fs/ceph/mon_client.c b/fs/ceph/mon_client.c
--- a/fs/ceph/mon_client.c
+++ b/fs/ceph/mon_client.c
@@ -481,11 +481,10 @@ int ceph_monc_do_statfs(struct ceph_mon_
 	struct ceph_mon_statfs *h;
 	int err;
 
-	req = kmalloc(sizeof(*req), GFP_NOFS);
+	req = kzalloc(sizeof(*req), GFP_NOFS);
 	if (!req)
 		return -ENOMEM;
 
-	memset(req, 0, sizeof(*req));
 	kref_init(&req->kref);
 	req->buf = buf;
 	init_completion(&req->completion);
