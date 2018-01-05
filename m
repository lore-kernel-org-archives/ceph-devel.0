From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v4 6/6] ceph: quota: add quotas to the in-tree cephfs documentation
Date: Fri,  5 Jan 2018 10:47:23 +0000
Message-ID: <20180105104723.16202-7-lhenriques@suse.com>
References: <20180105104723.16202-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeAEKrl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 05:47:41 -0500
In-Reply-To: <20180105104723.16202-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

Update documentation to include a high-level description of ceph quotas.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 Documentation/filesystems/ceph.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.txt
index 0b302a11718a..094772481263 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.txt
@@ -62,6 +62,18 @@ subdirectories, and a summation of all nested file sizes.  This makes
 the identification of large disk space consumers relatively quick, as
 no 'du' or similar recursive scan of the file system is required.
 
+Finally, Ceph also allows quotas to be set on any directory in the system.
+The quota can restrict the number of bytes or the number of files stored
+beneath that point in the directory hierarchy.  Quotas can be set using
+extended attributes 'ceph.quota.max_files' and 'ceph.quota.max_bytes', eg:
+
+ setfattr -n ceph.quota.max_bytes -v 100000000 /some/dir
+ getfattr -n ceph.quota.max_bytes /some/dir
+
+A limitation of the current quotas implementation is that it relies on the
+cooperation of the client mounting the file system to stop writers when a
+limit is reached.  A modified or adversarial client cannot be prevented
+from writing as much data as it needs.
 
 Mount Syntax
 ============
