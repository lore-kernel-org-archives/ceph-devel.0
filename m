From: xiubli@redhat.com
Subject: [RFC PATCH] ceph: fix description of some mount options
Date: Tue, 11 Feb 2020 10:31:20 -0500
Message-ID: <20200211153120.21369-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, Xiubo Li <xiubli@redhat.com>
List-Id: ceph-devel.vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Based on the latest code, the default value for wsize/rsize is
64MB and the default value for the mount_timeout is 60 seconds.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

Checked the history of the code, I am a little confused about the
default values for wsize/rsize, there never been 16MB as the default,
and for the mount_timeout, never seen 30 as default.

So did I miss something important about this ?


 Documentation/filesystems/ceph.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesyste=
ms/ceph.txt
index b19b6a03f91c..92ffc9b3b018 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.txt
@@ -103,17 +103,17 @@ Mount Options
 	address its connection to the monitor originates from.
=20
   wsize=3DX
-	Specify the maximum write size in bytes.  Default: 16 MB.
+	Specify the maximum write size in bytes.  Default: 64 MB.
=20
   rsize=3DX
-	Specify the maximum read size in bytes.  Default: 16 MB.
+	Specify the maximum read size in bytes.  Default: 64 MB.
=20
   rasize=3DX
 	Specify the maximum readahead size in bytes.  Default: 8 MB.
=20
   mount_timeout=3DX
 	Specify the timeout value for mount (in seconds), in the case
-	of a non-responsive Ceph file system.  The default is 30
+	of a non-responsive Ceph file system.  The default is 60
 	seconds.
=20
   caps_max=3DX
--=20
2.21.0
