From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/4] rbd: make ceph_parse_options() return a pointer
Date: Tue, 28 Feb 2012 19:35:09 -0800
Message-ID: <4F4D9CED.5050809@dreamhost.com>
References: <4F4D9BF6.5070102@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51009 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030688Ab2B2DfK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:35:10 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 41CD924318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:10 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1B91F24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:10 -0800 (PST)
In-Reply-To: <4F4D9BF6.5070102@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ceph_parse_options() takes the address of a pointer as an argument
and uses it to return the address of an allocated structure if
successful.  With this interface is not evident at call sites that
the pointer is always initialized.  Change the interface to return
the address instead (or a pointer-coded error code) to make the
validity of the returned pointer obvious.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c          |    6 ++++--
  fs/ceph/super.c              |    6 ++++--
  include/linux/ceph/libceph.h |    2 +-
  net/ceph/ceph_common.c       |   16 ++++++++--------
  4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7c8c07a..0430642 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -371,11 +371,13 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,

  	rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;

-	ret = ceph_parse_options(&opt, options, mon_addr,
+	opt = ceph_parse_options(options, mon_addr,
  				mon_addr + strlen(mon_addr),
  				parse_rbd_opts_token, rbd_opts);
-	if (ret < 0)
+	if (IS_ERR(opt)) {
+		ret = PTR_ERR(opt);
  		goto done_err;
+	}

  	spin_lock(&node_lock);
  	rbdc = __rbd_client_find(opt);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index e6325f0..1d325bc 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -324,10 +324,12 @@ static int parse_mount_options(struct 
ceph_mount_options **pfsopt,
  	*path += 2;
  	dout("server path '%s'\n", *path);

-	err = ceph_parse_options(popt, options, dev_name, dev_name_end,
+	*popt = ceph_parse_options(options, dev_name, dev_name_end,
  				 parse_fsopt_token, (void *)fsopt);
-	if (err)
+	if (IS_ERR(*popt)) {
+		err = PTR_ERR(*popt);
  		goto out;
+	}

  	/* success */
  	*pfsopt = fsopt;
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 95bd850..92eef7c 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -207,7 +207,7 @@ extern struct kmem_cache *ceph_cap_cachep;
  extern struct kmem_cache *ceph_dentry_cachep;
  extern struct kmem_cache *ceph_file_cachep;

-extern int ceph_parse_options(struct ceph_options **popt, char *options,
+extern struct ceph_options *ceph_parse_options(char *options,
  			      const char *dev_name, const char *dev_name_end,
  			      int (*parse_extra_token)(char *c, void *private),
  			      void *private);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 761ad9d..621c322 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -277,10 +277,11 @@ out:
  	return err;
  }

-int ceph_parse_options(struct ceph_options **popt, char *options,
-		       const char *dev_name, const char *dev_name_end,
-		       int (*parse_extra_token)(char *c, void *private),
-		       void *private)
+struct ceph_options *
+ceph_parse_options(char *options, const char *dev_name,
+			const char *dev_name_end,
+			int (*parse_extra_token)(char *c, void *private),
+			void *private)
  {
  	struct ceph_options *opt;
  	const char *c;
@@ -289,7 +290,7 @@ int ceph_parse_options(struct ceph_options **popt, 
char *options,

  	opt = kzalloc(sizeof(*opt), GFP_KERNEL);
  	if (!opt)
-		return err;
+		return ERR_PTR(-ENOMEM);
  	opt->mon_addr = kcalloc(CEPH_MAX_MON, sizeof(*opt->mon_addr),
  				GFP_KERNEL);
  	if (!opt->mon_addr)
@@ -412,12 +413,11 @@ int ceph_parse_options(struct ceph_options **popt, 
char *options,
  	}

  	/* success */
-	*popt = opt;
-	return 0;
+	return opt;

  out:
  	ceph_destroy_options(opt);
-	return err;
+	return ERR_PTR(err);
  }
  EXPORT_SYMBOL(ceph_parse_options);

-- 
1.7.5.4

