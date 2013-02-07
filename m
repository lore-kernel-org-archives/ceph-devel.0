From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 04/15] fuse_ll.cc: fix -Wgnu-designator
Date: Thu,  7 Feb 2013 20:41:52 +0100
Message-ID: <1360266123-28972-5-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33801 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932215Ab3BGTmK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:10 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix 'const static struct fuse_lowlevel_ops fuse_ll_oper' related
-Wgnu-designator warning from clang(++):

client/fuse_ll.cc:537:2: warning: use of GNU old-style field
  designator extension [-Wgnu-designator]

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/client/fuse_ll.cc | 68 +++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/src/client/fuse_ll.cc b/src/client/fuse_ll.cc
index 3e14bc0..a73442a 100644
--- a/src/client/fuse_ll.cc
+++ b/src/client/fuse_ll.cc
@@ -534,40 +534,40 @@ static void do_init(void *data, fuse_conn_info *bar)
 }
 
 const static struct fuse_lowlevel_ops fuse_ll_oper = {
- init: do_init,
- destroy: 0,
- lookup: fuse_ll_lookup,
- forget: fuse_ll_forget,
- getattr: fuse_ll_getattr,
- setattr: fuse_ll_setattr,
- readlink: fuse_ll_readlink,
- mknod: fuse_ll_mknod,
- mkdir: fuse_ll_mkdir,
- unlink: fuse_ll_unlink,
- rmdir: fuse_ll_rmdir,
- symlink: fuse_ll_symlink,
- rename: fuse_ll_rename,
- link: fuse_ll_link,
- open: fuse_ll_open,
- read: fuse_ll_read,
- write: fuse_ll_write,
- flush: fuse_ll_flush,
- release: fuse_ll_release,
- fsync: fuse_ll_fsync,
- opendir: fuse_ll_opendir,
- readdir: fuse_ll_readdir,
- releasedir: fuse_ll_releasedir,
- fsyncdir: 0,
- statfs: fuse_ll_statfs,
- setxattr: fuse_ll_setxattr,
- getxattr: fuse_ll_getxattr,
- listxattr: fuse_ll_listxattr,
- removexattr: fuse_ll_removexattr,
- access: 0,
- create: fuse_ll_create,
- getlk: 0,
- setlk: 0,
- bmap: 0
+ .init = do_init,
+ .destroy = 0,
+ .lookup = fuse_ll_lookup,
+ .forget = fuse_ll_forget,
+ .getattr = fuse_ll_getattr,
+ .setattr = fuse_ll_setattr,
+ .readlink = fuse_ll_readlink,
+ .mknod = fuse_ll_mknod,
+ .mkdir = fuse_ll_mkdir,
+ .unlink = fuse_ll_unlink,
+ .rmdir = fuse_ll_rmdir,
+ .symlink = fuse_ll_symlink,
+ .rename = fuse_ll_rename,
+ .link = fuse_ll_link,
+ .open = fuse_ll_open,
+ .read = fuse_ll_read,
+ .write = fuse_ll_write,
+ .flush = fuse_ll_flush,
+ .release = fuse_ll_release,
+ .fsync = fuse_ll_fsync,
+ .opendir = fuse_ll_opendir,
+ .readdir = fuse_ll_readdir,
+ .releasedir = fuse_ll_releasedir,
+ .fsyncdir = 0,
+ .statfs = fuse_ll_statfs,
+ .setxattr = fuse_ll_setxattr,
+ .getxattr = fuse_ll_getxattr,
+ .listxattr = fuse_ll_listxattr,
+ .removexattr = fuse_ll_removexattr,
+ .access = 0,
+ .create = fuse_ll_create,
+ .getlk = 0,
+ .setlk = 0,
+ .bmap = 0
 };
 
 
-- 
1.8.1.2

