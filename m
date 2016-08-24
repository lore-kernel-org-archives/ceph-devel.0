From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 07/16] libceph: rename ceph_client_id() -> ceph_client_gid()
Date: Wed, 24 Aug 2016 15:18:31 +0200
Message-ID: <1472044720-29116-8-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36520 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yb0-f195.google.com with SMTP id f60so443591ybi.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:18:59 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.18.58
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:18:58 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c          | 2 +-
 include/linux/ceph/libceph.h | 2 +-
 net/ceph/ceph_common.c       | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6c6519f6492a..e0585e9040f1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3758,7 +3758,7 @@ static ssize_t rbd_client_id_show(struct device *dev,
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
 
 	return sprintf(buf, "client%lld\n",
-			ceph_client_id(rbd_dev->rbd_client->client));
+		       ceph_client_gid(rbd_dev->rbd_client->client));
 }
 
 static ssize_t rbd_pool_show(struct device *dev,
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 83fc1fff7061..b4cffff70e44 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -264,7 +264,7 @@ extern struct ceph_client *ceph_create_client(struct ceph_options *opt,
 					      void *private,
 					      u64 supported_features,
 					      u64 required_features);
-extern u64 ceph_client_id(struct ceph_client *client);
+u64 ceph_client_gid(struct ceph_client *client);
 extern void ceph_destroy_client(struct ceph_client *client);
 extern int __ceph_open_session(struct ceph_client *client,
 			       unsigned long started);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index bddfcf6f09c2..8a7921767308 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -566,11 +566,11 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
 }
 EXPORT_SYMBOL(ceph_print_client_options);
 
-u64 ceph_client_id(struct ceph_client *client)
+u64 ceph_client_gid(struct ceph_client *client)
 {
 	return client->monc.auth->global_id;
 }
-EXPORT_SYMBOL(ceph_client_id);
+EXPORT_SYMBOL(ceph_client_gid);
 
 /*
  * create a fresh client instance
@@ -685,7 +685,8 @@ int __ceph_open_session(struct ceph_client *client, unsigned long started)
 			return client->auth_err;
 	}
 
-	pr_info("client%llu fsid %pU\n", ceph_client_id(client), &client->fsid);
+	pr_info("client%llu fsid %pU\n", ceph_client_gid(client),
+		&client->fsid);
 	ceph_debugfs_client_init(client);
 
 	return 0;
-- 
2.4.3

