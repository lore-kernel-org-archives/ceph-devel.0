From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 84/99] ceph: handle the case where a dentry has been renamed on outstanding req
Date: Tue,  7 May 2019 01:32:18 -0400
Message-ID: <20190507053235.29900-84-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 4b8222870032715f9d995f3eb7c7acd8379a275d ]

It's possible for us to issue a lookup to revalidate a dentry
concurrently with a rename. If done in the right order, then we could
end up processing dentry info in the reply that no longer reflects the
state of the dentry.

If req->r_dentry->d_name differs from the one in the trace, then just
ignore the trace in the reply. We only need to do this however if the
parent's i_rwsem is not held.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9d1f34d46627..5880ee20ada4 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1152,6 +1152,19 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
 	return 0;
 }
 
+static int d_name_cmp(struct dentry *dentry, const char *name, size_t len)
+{
+	int ret;
+
+	/* take d_lock to ensure dentry->d_name stability */
+	spin_lock(&dentry->d_lock);
+	ret = dentry->d_name.len - len;
+	if (!ret)
+		ret = memcmp(dentry->d_name.name, name, len);
+	spin_unlock(&dentry->d_lock);
+	return ret;
+}
+
 /*
  * Incorporate results into the local cache.  This is either just
  * one inode, or a directory, dentry, and possibly linked-to inode (e.g.,
@@ -1401,7 +1414,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		err = splice_dentry(&req->r_dentry, in);
 		if (err < 0)
 			goto done;
-	} else if (rinfo->head->is_dentry) {
+	} else if (rinfo->head->is_dentry &&
+		   !d_name_cmp(req->r_dentry, rinfo->dname, rinfo->dname_len)) {
 		struct ceph_vino *ptvino = NULL;
 
 		if ((le32_to_cpu(rinfo->diri.in->cap.caps) & CEPH_CAP_FILE_SHARED) ||
-- 
2.20.1
