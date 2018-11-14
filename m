From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 35/59] ceph: quota: fix null pointer dereference in quota check
Date: Wed, 14 Nov 2018 17:23:07 -0500
Message-ID: <20181114222335.99339-35-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Luis Henriques <lhenriques@suse.com>

[ Upstream commit 71f2cc64d027d712f29bf8d09d3e123302d5f245 ]

This patch fixes a possible null pointer dereference in
check_quota_exceeded, detected by the static checker smatch, with the
following warning:

   fs/ceph/quota.c:240 check_quota_exceeded()
    error: we previously assumed 'realm' could be null (see line 188)

Fixes: b7a2921765cf ("ceph: quota: support for ceph.quota.max_files")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/quota.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 242bfa5c0539..47cc6f41d100 100644
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
-- 
2.17.1
