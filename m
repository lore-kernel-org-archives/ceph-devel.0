From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] libceph: NULL deref on crush_decode() error path
Date: Tue, 23 May 2017 17:25:10 +0300
Message-ID: <20170523142430.GA28152@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

If there is not enough space then ceph_decode_32_safe() does a goto bad.
We need to return an error code in that situation.  The current code
returns ERR_PTR(0) which is NULL.  The callers are not expecting that
and it results in a NULL dereference.

Fixes: f24e9980eb86 ("ceph: OSD client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index ffe9e904d4d1..55e3a477f92d 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -317,6 +317,7 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		u32 yes;
 		struct crush_rule *r;
 
+		err = -EINVAL;
 		ceph_decode_32_safe(p, end, yes, bad);
 		if (!yes) {
 			dout("crush_decode NO rule %d off %x %p to %p\n",
