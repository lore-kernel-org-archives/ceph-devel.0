From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] libceph, ceph: use struct_size() in kmalloc()
Date: Tue, 15 Jan 2019 13:41:53 -0600
Message-ID: <20190115194153.GA9565@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: ceph-devel.vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/ceph/osdmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 98c0ff3d6441..48a31dc9161c 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -495,9 +495,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 			  / sizeof(struct crush_rule_step))
 			goto bad;
 #endif
-		r = c->rules[i] = kmalloc(sizeof(*r) +
-					  yes*sizeof(struct crush_rule_step),
-					  GFP_NOFS);
+		r = kmalloc(struct_size(r, steps, yes), GFP_NOFS);
+		c->rules[i] = r;
 		if (r == NULL)
 			goto badmem;
 		dout(" rule %d is at %p\n", i, r);
-- 
2.20.1
