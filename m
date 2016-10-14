From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ceph: avoid accessing / when mounting a subpath
Date: Fri, 14 Oct 2016 12:46:04 +0300
Message-ID: <20161014094604.GA25372@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21565 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcJNJqg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2016 05:46:36 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com
Cc: ceph-devel@vger.kernel.org

Hello Yan, Zheng,

The patch ce2728aaa82b: "ceph: avoid accessing / when mounting a
subpath" from Sep 14, 2016, leads to the following static checker
warning:

	fs/ceph/super.c:853 ceph_real_mount()
	error: uninitialized symbol 'root'.

fs/ceph/super.c
   814  static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
   815  {
   816          int err;
   817          unsigned long started = jiffies;  /* note the start time */
   818          struct dentry *root;
   819          int first = 0;   /* first vfsmount for this super_block */
   820  
   821          dout("mount start %p\n", fsc);
   822          mutex_lock(&fsc->client->mount_mutex);
   823  
   824          if (!fsc->sb->s_root) {
   825                  const char *path;
   826                  err = __ceph_open_session(fsc->client, started);
   827                  if (err < 0)
   828                          goto out;
   829  
   830                  if (!fsc->mount_options->server_path) {
   831                          path = "";
   832                          dout("mount opening path \\t\n");
   833                  } else {
   834                          path = fsc->mount_options->server_path + 1;
   835                          dout("mount opening path %s\n", path);
   836                  }
   837                  root = open_root_dentry(fsc, path, started);
   838                  if (IS_ERR(root)) {
   839                          err = PTR_ERR(root);
   840                          goto out;
   841                  }
   842                  fsc->sb->s_root = dget(root);
   843                  first = 1;
   844  
   845                  err = ceph_fs_debugfs_init(fsc);
   846                  if (err < 0)
   847                          goto fail;
   848          }

We should initialize root on the else side.

   849  
   850          fsc->mount_state = CEPH_MOUNT_MOUNTED;
   851          dout("mount success\n");
   852          mutex_unlock(&fsc->client->mount_mutex);
   853          return root;



regards,
dan carpenter
