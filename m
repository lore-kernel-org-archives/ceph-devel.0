From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ceph: remove unnecessary non NULL check for request_key
Date: Tue, 7 Aug 2018 21:02:34 +0800
Message-ID: <20180807130234.5380-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ceph-devel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: ceph-devel.vger.kernel.org

request_key never return NULL,so no need do non-NULL check.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/ceph/ceph_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 584fdbe..9834edc 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -304,7 +304,7 @@ static int get_secret(struct ceph_crypto_key *dst, const char *name) {
 	struct ceph_crypto_key *ckey;
 
 	ukey = request_key(&key_type_ceph, name, NULL);
-	if (!ukey || IS_ERR(ukey)) {
+	if (IS_ERR(ukey)) {
 		/* request_key errors don't map nicely to mount(2)
 		   errors; don't even try, but still printk */
 		key_err = PTR_ERR(ukey);
-- 
2.7.0
