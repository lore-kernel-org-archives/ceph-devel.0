From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: ceph-mon blocked error
Date: Wed, 09 Nov 2011 15:56:22 -0200
Message-ID: <orhb2drxh5.fsf@livre.localdomain>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
	<CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
	<CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
	<orwrbfu4js.fsf@livre.localdomain>
	<CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
	<orobwqt186.fsf@livre.localdomain>
	<CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
	<CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
	<CAORUGqD0EL4yb-RbrixJPkwjSubPpJD5NKX-2OwK6656bkgjHA@mail.gmail.com>
	<CA+jddaO4H7owZ_byUprBCfvgCUTUC8ceePyPh_7G_SE8c_kKZA@mail.gmail.com>
	<Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:60367 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751285Ab1KIR5I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 12:57:08 -0500
In-Reply-To: <Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net> (Sage
	Weil's message of "Mon, 7 Nov 2011 15:10:35 -0800 (PST)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mandell Degerness <mandell@pistoncloud.com>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

--=-=-=

On Nov  7, 2011, Sage Weil <sage@newdream.net> wrote:

> New kernels (.39+) and new glibc have syncfs(2), which syncs only the
> fs the ceph-osd is serving up.

I haven't seen the current glibc implementation, but the one I have on
my system is a stub that sets errno and returns nonzero.  autoconf
correctly detects it as a stub, but I'm concerned that syncfs might fail
with say ENOSYS and we'd happily go ahead assuming the data is properly
sync()ed.

The patch below fixes this, arranging for us to fallback to sync if
syncfs fails, but to try btrfs sync in between, under the assumption
that the ioctl will fail if fd isn't a btrfs inode.

> http://linux.die.net/man/2/syncfs

The man page is wrong or outdated: syncfs returns int, not void.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=0001-Improve-use-of-syncfs.patch

From 620a767eb0205caf15527f2d91ab7ee50150a494 Mon Sep 17 00:00:00 2001
From: Alexandre Oliva <lxoliva@fsfla.org>
Date: Wed, 9 Nov 2011 15:51:26 -0200
Subject: [PATCH] Improve use of syncfs.

Test syncfs return value and fallback to btrfs sync and then sync.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/common/sync_filesystem.h |   19 ++++++++++++++++---
 src/os/FileStore.cc          |    6 ------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/common/sync_filesystem.h b/src/common/sync_filesystem.h
index 04cfc99..3ad8c9e 100644
--- a/src/common/sync_filesystem.h
+++ b/src/common/sync_filesystem.h
@@ -17,6 +17,13 @@
 
 #include <unistd.h>
 
+#ifndef __CYGWIN__
+# ifndef DARWIN
+#  include <sys/ioctl.h>
+#  include "../os/btrfs_ioctl.h"
+# endif
+#endif
+
 inline int sync_filesystem(int fd)
 {
   /* On Linux, newer versions of glibc have a function called syncfs that
@@ -24,11 +31,17 @@ inline int sync_filesystem(int fd)
    * have to fall back on sync(), which synchronizes every filesystem on the
    * computer. */
 #ifdef HAVE_SYS_SYNCFS
-  return syncfs(fd);
-#else
+  if (syncfs(fd) == 0)
+    return 0;
+#endif
+
+#ifdef BTRFS_IOC_SYNC
+  if (::ioctl(fd, BTRFS_IOC_SYNC) == 0)
+    return 0;
+#endif
+
   sync();
   return 0;
-#endif
 }
 
 #endif
diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index 4550bfc..0076568 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -62,12 +62,6 @@
 #include "common/ceph_crypto.h"
 using ceph::crypto::SHA1;
 
-#ifndef __CYGWIN__
-# ifndef DARWIN
-#  include "btrfs_ioctl.h"
-# endif
-#endif
-
 #include "common/config.h"
 
 #define DOUT_SUBSYS filestore
-- 
1.7.4.4


--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
