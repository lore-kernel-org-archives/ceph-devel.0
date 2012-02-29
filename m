From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 5/6] ceph: avoid repeatedly computing the size of constant
 vxattr names
Date: Tue, 28 Feb 2012 19:21:51 -0800
Message-ID: <4F4D99CF.9020507@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38156 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030698Ab2B2DVw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:21:52 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 38A1E24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:52 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 2D4B624314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:52 -0800 (PST)
In-Reply-To: <4F4D98D5.1010506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All names defined in the directory and file virtual extended
attribute tables are constant, and the size of each is known at
compile time.  So there's no need to compute their length every
time any file's attribute is listed.

Record the length of each string and use it when needed to determine
the space need to represent them.  In addition, compute the
aggregate size of strings in each table just once at initialization
time.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/super.c |    3 ++
  fs/ceph/super.h |    2 +
  fs/ceph/xattr.c |   56 
++++++++++++++++++++++++++++++++++++++++++++++++++----
  3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b48f15f..e6325f0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -906,6 +906,7 @@ static int __init init_ceph(void)
  	if (ret)
  		goto out;

+	ceph_xattr_init();
  	ret = register_filesystem(&ceph_fs_type);
  	if (ret)
  		goto out_icache;
@@ -915,6 +916,7 @@ static int __init init_ceph(void)
  	return 0;

  out_icache:
+	ceph_xattr_exit();
  	destroy_caches();
  out:
  	return ret;
@@ -924,6 +926,7 @@ static void __exit exit_ceph(void)
  {
  	dout("exit_ceph\n");
  	unregister_filesystem(&ceph_fs_type);
+	ceph_xattr_exit();
  	destroy_caches();
  }

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5f00e82..4be2dc4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -732,6 +732,8 @@ extern ssize_t ceph_listxattr(struct dentry *, char 
*, size_t);
  extern int ceph_removexattr(struct dentry *, const char *);
  extern void __ceph_build_xattrs_blob(struct ceph_inode_info *ci);
  extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
+extern void __init ceph_xattr_init(void);
+extern void ceph_xattr_exit(void);

  /* caps.c */
  extern const char *ceph_cap_string(int c);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 83366f9..984c863 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -26,6 +26,7 @@ static bool ceph_is_valid_xattr(const char *name)
   */
  struct ceph_vxattr {
  	char *name;
+	size_t name_size;	/* strlen(name) + 1 (for '\0') */
  	size_t (*getxattr_cb)(struct ceph_inode_info *ci, char *val,
  			      size_t size);
  	bool readonly;
@@ -87,6 +88,7 @@ static size_t ceph_vxattrcb_dir_rctime(struct 
ceph_inode_info *ci, char *val,
  #define XATTR_NAME_CEPH(_type, _name) \
  		{ \
  			.name = CEPH_XATTR_NAME(_type, _name), \
+			.name_size = sizeof CEPH_XATTR_NAME(_type, _name), \
  			.getxattr_cb = ceph_vxattrcb_ ## _type ## _ ## _name, \
  			.readonly = true, \
  		}
@@ -102,6 +104,7 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
  	XATTR_NAME_CEPH(dir, rctime),
  	{ 0 }	/* Required table terminator */
  };
+static size_t ceph_dir_vxattrs_name_size;	/* total size of all names */

  /* files */

@@ -127,11 +130,13 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
  	/* The following extended attribute name is deprecated */
  	{
  		.name = XATTR_CEPH_PREFIX "layout",
+		.name_size = sizeof XATTR_CEPH_PREFIX "layout",
  		.getxattr_cb = ceph_vxattrcb_file_layout,
  		.readonly = true,
  	},
  	{ 0 }	/* Required table terminator */
  };
+static size_t ceph_file_vxattrs_name_size;	/* total size of all names */

  static struct ceph_vxattr *ceph_inode_vxattrs(struct inode *inode)
  {
@@ -142,6 +147,46 @@ static struct ceph_vxattr 
*ceph_inode_vxattrs(struct inode *inode)
  	return NULL;
  }

+static size_t ceph_vxattrs_name_size(struct ceph_vxattr *vxattrs)
+{
+	if (vxattrs == ceph_dir_vxattrs)
+		return ceph_dir_vxattrs_name_size;
+	if (vxattrs == ceph_file_vxattrs)
+		return ceph_file_vxattrs_name_size;
+	BUG();
+
+	return 0;
+}
+
+/*
+ * Compute the aggregate size (including terminating '\0') of all
+ * virtual extended attribute names in the given vxattr table.
+ */
+static size_t __init vxattrs_name_size(struct ceph_vxattr *vxattrs)
+{
+	struct ceph_vxattr *vxattr;
+	size_t size = 0;
+
+	for (vxattr = vxattrs; vxattr->name; vxattr++)
+		size += vxattr->name_size;
+
+	return size;
+}
+
+/* Routines called at initialization and exit time */
+
+void __init ceph_xattr_init(void)
+{
+	ceph_dir_vxattrs_name_size = vxattrs_name_size(ceph_dir_vxattrs);
+	ceph_file_vxattrs_name_size = vxattrs_name_size(ceph_file_vxattrs);
+}
+
+void ceph_xattr_exit(void)
+{
+	ceph_dir_vxattrs_name_size = 0;
+	ceph_file_vxattrs_name_size = 0;
+}
+
  static struct ceph_vxattr *ceph_match_vxattr(struct inode *inode,
  						const char *name)
  {
@@ -614,11 +659,12 @@ ssize_t ceph_listxattr(struct dentry *dentry, char 
*names, size_t size)
  		goto out;

  list_xattr:
-	vir_namelen = 0;
-	/* include virtual dir xattrs */
-	if (vxattrs)
-		for (i = 0; vxattrs[i].name; i++)
-			vir_namelen += strlen(vxattrs[i].name) + 1;
+	/*
+	 * Start with virtual dir xattr names (if any) (including
+	 * terminating '\0' characters for each).
+	 */
+	vir_namelen = ceph_vxattrs_name_size(vxattrs);
+
  	/* adding 1 byte per each variable due to the null termination */
  	namelen = vir_namelen + ci->i_xattrs.names_size + ci->i_xattrs.count;
  	err = -ERANGE;
-- 
1.7.5.4

