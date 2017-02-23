From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ceph: tidy some white space in get_nonsnap_parent()
Date: Thu, 23 Feb 2017 13:39:59 +0300
Message-ID: <20170223103852.GA27418@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45810 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdBWKkr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 05:40:47 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

The white space here seems slightly messed up.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index fdbc3544e41c..c681762d76e6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -679,8 +679,9 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
  * working with them. Once we hit a candidate dentry, we attempt to take a
  * reference to it, and return that as the result.
  */
-static struct inode *get_nonsnap_parent(struct dentry *dentry) { struct inode
-	*inode = NULL;
+static struct inode *get_nonsnap_parent(struct dentry *dentry)
+{
+	struct inode *inode = NULL;
 
 	while (dentry && !IS_ROOT(dentry)) {
 		inode = d_inode_rcu(dentry);
