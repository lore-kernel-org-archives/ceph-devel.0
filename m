From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] ceph: Check memory allocation result
Date: Fri, 26 Jan 2018 14:54:43 +0800
Message-ID: <1516949683-127606-1-git-send-email-cgxu519@icloud.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, davem@davemloft.net, idryomov@gmail.com, netdev@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>
List-Id: ceph-devel.vger.kernel.org

Should check result of kstrndup() in case of memory allocation failure.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 net/ceph/ceph_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 5c036d2..1e492ef 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -421,6 +421,10 @@ struct ceph_options *
 			opt->name = kstrndup(argstr[0].from,
 					      argstr[0].to-argstr[0].from,
 					      GFP_KERNEL);
+			if (!opt->name) {
+				err = -ENOMEM;
+				goto out;
+			}
 			break;
 		case Opt_secret:
 		        opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
-- 
1.8.3.1
