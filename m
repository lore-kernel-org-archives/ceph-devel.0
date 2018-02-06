From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] ceph: avoid memory leak when specifying same option several
 times
Date: Tue, 06 Feb 2018 08:25:55 +0800
Message-ID: <1517876755-46814-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp001.me.com ([17.110.69.252]:20042 "EHLO
        mr11p00im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeBFA0c (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 19:26:32 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp001.me.com by
 mr11p00im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3P00O00CM0K200@mr11p00im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Tue, 06 Feb 2018 00:26:07 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, idryomov@gmail.com, Chengguang Xu <cgxu519@icloud.com>

When parsing string option, in order to avoid memory leak we need to
carefully free it first in case of specifying same option several times.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 fs/ceph/super.c        | 2 ++
 net/ceph/ceph_common.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a62d2a9..bfc85b2 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -225,6 +225,7 @@ static int parse_fsopt_token(char *c, void *private)
 			return -ENOMEM;
 		break;
 	case Opt_mds_namespace:
+		kfree(fsopt->mds_namespace);
 		fsopt->mds_namespace = kstrndup(argstr[0].from,
 						argstr[0].to-argstr[0].from,
 						GFP_KERNEL);
@@ -232,6 +233,7 @@ static int parse_fsopt_token(char *c, void *private)
 			return -ENOMEM;
 		break;
 	case Opt_fscache_uniq:
+		kfree(fsopt->fscache_uniq);
 		fsopt->fscache_uniq = kstrndup(argstr[0].from,
 					       argstr[0].to-argstr[0].from,
 					       GFP_KERNEL);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 5c036d2..cdb5b69 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -418,11 +418,15 @@ struct ceph_options *
 				opt->flags |= CEPH_OPT_FSID;
 			break;
 		case Opt_name:
+			kfree(opt->name);
 			opt->name = kstrndup(argstr[0].from,
 					      argstr[0].to-argstr[0].from,
 					      GFP_KERNEL);
 			break;
 		case Opt_secret:
+			ceph_crypto_key_destroy(opt->key);
+			kfree(opt->key);
+
 		        opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
 			if (!opt->key) {
 				err = -ENOMEM;
@@ -433,6 +437,9 @@ struct ceph_options *
 				goto out;
 			break;
 		case Opt_key:
+			ceph_crypto_key_destroy(opt->key);
+			kfree(opt->key);
+
 		        opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
 			if (!opt->key) {
 				err = -ENOMEM;
-- 
1.8.3.1

