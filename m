From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: quota: fix null pointer dereference in quota check
Date: Mon,  5 Nov 2018 11:00:52 +0000
Message-ID: <20181105110052.31759-1-lhenriques@suse.com>
References: <20181101065318.2cylxol6d444nzeu@kili.mountain>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101065318.2cylxol6d444nzeu@kili.mountain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

This patch fixes a possible null pointer dereference in
check_quota_exceeded, detected by the static checker smatch, with the
following warning:

    fs/ceph/quota.c:240 check_quota_exceeded()
     error: we previously assumed 'realm' could be null (see line 188)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lkml.kernel.org/n/20181101065318.2cylxol6d444nzeu@kili.mountain
Fixes: b7a2921765cf ("ceph: quota: support for ceph.quota.max_files")
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/quota.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 32d4f13784ba..03f4d24db8fe 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -237,7 +237,8 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		ceph_put_snap_realm(mdsc, realm);
 		realm = next;
 	}
-	ceph_put_snap_realm(mdsc, realm);
+	if (realm)
+		ceph_put_snap_realm(mdsc, realm);
 	up_read(&mdsc->snap_rwsem);
 
 	return exceeded;
