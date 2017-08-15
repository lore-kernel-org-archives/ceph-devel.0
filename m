From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 1/1] fs/ceph: More accurate statfs
Date: Tue, 15 Aug 2017 14:54:51 -0400
Message-ID: <04d1b74e1f90539a5bea9d737710ab71039e5eab.1502823001.git.dfuller@redhat.com>
References: <cover.1502823001.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:38780 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdHOSzL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Aug 2017 14:55:11 -0400
Received: by mail-qk0-f177.google.com with SMTP id x191so8928868qka.5
        for <ceph-devel@vger.kernel.org>; Tue, 15 Aug 2017 11:55:11 -0700 (PDT)
Received: from localhost.localdomain (96-38-113-238.dhcp.jcsn.tn.charter.com. [96.38.113.238])
        by smtp.gmail.com with ESMTPSA id q127sm6640631qkf.9.2017.08.15.11.55.09
        for <ceph-devel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 11:55:09 -0700 (PDT)
In-Reply-To: <cover.1502823001.git.dfuller@redhat.com>
In-Reply-To: <cover.1502823001.git.dfuller@redhat.com>
References: <cover.1502823001.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Improve accuracy of statfs reporting for Ceph filesystems comprising
exactly one data pool. In this case, the Ceph monitor can now report
the space usage for the single data pool instead of the global data
for the entire Ceph cluster. Include support for this message in
mon_client and leverage it in ceph/super.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 fs/ceph/super.c                 | 9 ++++++++-
 include/linux/ceph/ceph_fs.h    | 2 ++
 include/linux/ceph/mon_client.h | 2 +-
 net/ceph/mon_client.c           | 6 +++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 1deb8810d7c7..75facee8b6d1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -49,9 +49,16 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct ceph_statfs st;
 	u64 fsid;
 	int err;
+	__le64 data_pool;
+
+	if (fsc->mdsc->mdsmap->m_num_data_pg_pools == 1) {
+		data_pool = fsc->mdsc->mdsmap->m_data_pg_pools[0];
+	} else {
+		data_pool = CEPH_NOPOOL;
+	}
 
 	dout("statfs\n");
-	err = ceph_monc_do_statfs(&fsc->client->monc, &st);
+	err = ceph_monc_do_statfs(&fsc->client->monc, data_pool, &st);
 	if (err < 0)
 		return err;
 
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d1642a4b4c5e..b422170b791a 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -167,6 +167,8 @@ struct ceph_mon_request_header {
 struct ceph_mon_statfs {
 	struct ceph_mon_request_header monhdr;
 	struct ceph_fsid fsid;
+	__u8 contains_data_pool;
+	__le64 data_pool;
 } __attribute__ ((packed));
 
 struct ceph_statfs {
diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index d5a3ecea578d..bd4650ab1248 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -133,7 +133,7 @@ void ceph_monc_renew_subs(struct ceph_mon_client *monc);
 extern int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
 				 unsigned long timeout);
 
-extern int ceph_monc_do_statfs(struct ceph_mon_client *monc,
+extern int ceph_monc_do_statfs(struct ceph_mon_client *monc, __le64 data_pool,
 			       struct ceph_statfs *buf);
 
 int ceph_monc_get_version(struct ceph_mon_client *monc, const char *what,
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 875675765531..5ef21986074e 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -676,7 +676,8 @@ static void handle_statfs_reply(struct ceph_mon_client *monc,
 /*
  * Do a synchronous statfs().
  */
-int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
+int ceph_monc_do_statfs(struct ceph_mon_client *monc, __le64 data_pool,
+			struct ceph_statfs *buf)
 {
 	struct ceph_mon_generic_request *req;
 	struct ceph_mon_statfs *h;
@@ -696,6 +697,7 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
 		goto out;
 
 	req->u.st = buf;
+	req->request->hdr.version = 2;
 
 	mutex_lock(&monc->mutex);
 	register_generic_request(req);
@@ -705,6 +707,8 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
 	h->monhdr.session_mon = cpu_to_le16(-1);
 	h->monhdr.session_mon_tid = 0;
 	h->fsid = monc->monmap->fsid;
+	h->contains_data_pool = (data_pool != CEPH_NOPOOL);
+	h->data_pool = data_pool;
 	send_generic_request(monc, req);
 	mutex_unlock(&monc->mutex);
 
-- 
2.11.0 (Apple Git-81)

