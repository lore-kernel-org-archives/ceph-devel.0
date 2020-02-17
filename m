From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 09/44] docs: filesystems: convert ceph.txt to ReST
Date: Mon, 17 Feb 2020 17:11:55 +0100
Message-ID: <df2f142b5ca5842e030d8209482dfd62dcbe020f.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{ceph.txt => ceph.rst}        | 26 +++++++++++--------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)
 rename Documentation/filesystems/{ceph.txt => ceph.rst} (91%)

diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.rst
similarity index 91%
rename from Documentation/filesystems/ceph.txt
rename to Documentation/filesystems/ceph.rst
index b19b6a03f91c..b46a7218248f 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
 Ceph Distributed File System
 ============================
 
@@ -15,6 +18,7 @@ Basic features include:
  * Easy deployment: most FS components are userspace daemons
 
 Also,
+
  * Flexible snapshots (on any directory)
  * Recursive accounting (nested files, directories, bytes)
 
@@ -63,7 +67,7 @@ no 'du' or similar recursive scan of the file system is required.
 Finally, Ceph also allows quotas to be set on any directory in the system.
 The quota can restrict the number of bytes or the number of files stored
 beneath that point in the directory hierarchy.  Quotas can be set using
-extended attributes 'ceph.quota.max_files' and 'ceph.quota.max_bytes', eg:
+extended attributes 'ceph.quota.max_files' and 'ceph.quota.max_bytes', eg::
 
  setfattr -n ceph.quota.max_bytes -v 100000000 /some/dir
  getfattr -n ceph.quota.max_bytes /some/dir
@@ -76,7 +80,7 @@ from writing as much data as it needs.
 Mount Syntax
 ============
 
-The basic mount syntax is:
+The basic mount syntax is::
 
  # mount -t ceph monip[:port][,monip2[:port]...]:/[subdir] mnt
 
@@ -84,7 +88,7 @@ You only need to specify a single monitor, as the client will get the
 full list when it connects.  (However, if the monitor you specify
 happens to be down, the mount won't succeed.)  The port can be left
 off if the monitor is using the default.  So if the monitor is at
-1.2.3.4,
+1.2.3.4::
 
  # mount -t ceph 1.2.3.4:/ /mnt/ceph
 
@@ -163,14 +167,14 @@ Mount Options
 	available modes are "no" and "clean". The default is "no".
 
 	* no: never attempt to reconnect when client detects that it has been
-	blacklisted. Operations will generally fail after being blacklisted.
+	  blacklisted. Operations will generally fail after being blacklisted.
 
 	* clean: client reconnects to the ceph cluster automatically when it
-	detects that it has been blacklisted. During reconnect, client drops
-	dirty data/metadata, invalidates page caches and writable file handles.
-	After reconnect, file locks become stale because the MDS loses track
-	of them. If an inode contains any stale file locks, read/write on the
-	inode is not allowed until applications release all stale file locks.
+	  detects that it has been blacklisted. During reconnect, client drops
+	  dirty data/metadata, invalidates page caches and writable file handles.
+	  After reconnect, file locks become stale because the MDS loses track
+	  of them. If an inode contains any stale file locks, read/write on the
+	  inode is not allowed until applications release all stale file locks.
 
 More Information
 ================
@@ -179,8 +183,8 @@ For more information on Ceph, see the home page at
 	https://ceph.com/
 
 The Linux kernel client source tree is available at
-	https://github.com/ceph/ceph-client.git
-	git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
+	- https://github.com/ceph/ceph-client.git
+	- git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
 
 and the source for the full system is at
 	https://github.com/ceph/ceph.git
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index dae862cf167e..ddd8f7b2bb25 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -55,6 +55,7 @@ Documentation for filesystem implementations.
    befs
    bfs
    btrfs
+   ceph
    fuse
    overlayfs
    virtiofs
-- 
2.24.1
