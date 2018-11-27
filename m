From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH V2] libceph: fix use after free
Date: Tue, 27 Nov 2018 17:21:12 +0800
Message-ID: <1543310472-31861-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: ceph-devel.vger.kernel.org

The function ceph_monc_handle_map calls kfree(old) to free the old
monitor map, old points to monc->monmap. However, after that, it reads
monc->monmap->epoch and passes it to __ceph_monc_got_map. This will 
result in a use-after-free bug. The patch moves the free operation after
the call to __ceph_monc_got_map.

Fixes: 82dcabad750 ("libceph: revamp subs code, switch to SUBSCRIBE2 protocol")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
V2: correct the format of the tag Fixes
---
 net/ceph/mon_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 18deb3d..05ef5aa 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -478,9 +478,10 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 	}
 
 	client->monc.monmap = monmap;
-	kfree(old);
 
 	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
+	kfree(old);
+
 	client->have_fsid = true;
 
 out:
-- 
2.7.4
