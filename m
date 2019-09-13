From: Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [coreutils PATCH v2 1/2] stat: move struct statx to struct stat
 conversion routines to new header
Date: Fri, 13 Sep 2019 06:58:04 -0400
Message-ID: <20190913105805.24669-2-jlayton@kernel.org>
References: <20190913105805.24669-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <coreutils-bounces+gcgcg-coreutils=m.gmane.org-mXXj517/zsQ@public.gmane.org>
In-Reply-To: <20190913105805.24669-1-jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/coreutils>,
 <mailto:coreutils-request-mXXj517/zsQ@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/coreutils>
List-Post: <mailto:coreutils-mXXj517/zsQ@public.gmane.org>
List-Help: <mailto:coreutils-request-mXXj517/zsQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/coreutils>,
 <mailto:coreutils-request-mXXj517/zsQ@public.gmane.org?subject=subscribe>
Errors-To: coreutils-bounces+gcgcg-coreutils=m.gmane.org-mXXj517/zsQ@public.gmane.org
Sender: "coreutils" <coreutils-bounces+gcgcg-coreutils=m.gmane.org-mXXj517/zsQ@public.gmane.org>
To: coreutils-mXXj517/zsQ@public.gmane.org
Cc: adilger-m1MBpc4rdrD3fQ9qLvQP4Q@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

* move statx_timestamp_to_timespec and statx_to_stat to a new header
---
 src/stat.c  | 32 +------------------------------
 src/statx.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 31 deletions(-)
 create mode 100644 src/statx.h

diff --git a/src/stat.c b/src/stat.c
index ee68f1682bc8..f2bf0dcb7901 100644
--- a/src/stat.c
+++ b/src/stat.c
@@ -73,6 +73,7 @@
 #include "strftime.h"
 #include "find-mount-point.h"
 #include "xvasprintf.h"
+#include "statx.h"
=20
 #if HAVE_STATX && defined STATX_INO
 # define USE_STATX 1
@@ -1245,37 +1246,6 @@ static bool dont_sync;
 static bool force_sync;
=20
 #if USE_STATX
-/* Much of the format printing requires a struct stat or timespec */
-static struct timespec
-statx_timestamp_to_timespec (struct statx_timestamp tsx)
-{
-  struct timespec ts;
-
-  ts.tv_sec =3D tsx.tv_sec;
-  ts.tv_nsec =3D tsx.tv_nsec;
-  return ts;
-}
-
-static void
-statx_to_stat (struct statx *stx, struct stat *stat)
-{
-  stat->st_dev =3D makedev (stx->stx_dev_major, stx->stx_dev_minor);
-  stat->st_ino =3D stx->stx_ino;
-  stat->st_mode =3D stx->stx_mode;
-  stat->st_nlink =3D stx->stx_nlink;
-  stat->st_uid =3D stx->stx_uid;
-  stat->st_gid =3D stx->stx_gid;
-  stat->st_rdev =3D makedev (stx->stx_rdev_major, stx->stx_rdev_minor);
-  stat->st_size =3D stx->stx_size;
-  stat->st_blksize =3D stx->stx_blksize;
-/* define to avoid sc_prohibit_stat_st_blocks.  */
-# define SC_ST_BLOCKS st_blocks
-  stat->SC_ST_BLOCKS =3D stx->stx_blocks;
-  stat->st_atim =3D statx_timestamp_to_timespec (stx->stx_atime);
-  stat->st_mtim =3D statx_timestamp_to_timespec (stx->stx_mtime);
-  stat->st_ctim =3D statx_timestamp_to_timespec (stx->stx_ctime);
-}
-
 static unsigned int
 fmt_to_mask (char fmt)
 {
diff --git a/src/statx.h b/src/statx.h
new file mode 100644
index 000000000000..a98ec10de380
--- /dev/null
+++ b/src/statx.h
@@ -0,0 +1,54 @@
+/* statx -> stat conversion functions for coreutils
+   Copyright (C) 2019 Free Software Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation, either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <https://www.gnu.org/licenses/>=
.  */
+
+#ifndef COREUTILS_STATX_H
+# define COREUTILS_STATX_H
+
+#include <sys/stat.h>
+
+#if HAVE_STATX && defined STATX_INO
+/* Much of the format printing requires a struct stat or timespec */
+static inline struct timespec
+statx_timestamp_to_timespec (struct statx_timestamp tsx)
+{
+  struct timespec ts;
+
+  ts.tv_sec =3D tsx.tv_sec;
+  ts.tv_nsec =3D tsx.tv_nsec;
+  return ts;
+}
+
+static inline void
+statx_to_stat (struct statx *stx, struct stat *stat)
+{
+  stat->st_dev =3D makedev (stx->stx_dev_major, stx->stx_dev_minor);
+  stat->st_ino =3D stx->stx_ino;
+  stat->st_mode =3D stx->stx_mode;
+  stat->st_nlink =3D stx->stx_nlink;
+  stat->st_uid =3D stx->stx_uid;
+  stat->st_gid =3D stx->stx_gid;
+  stat->st_rdev =3D makedev (stx->stx_rdev_major, stx->stx_rdev_minor);
+  stat->st_size =3D stx->stx_size;
+  stat->st_blksize =3D stx->stx_blksize;
+/* define to avoid sc_prohibit_stat_st_blocks.  */
+# define SC_ST_BLOCKS st_blocks
+  stat->SC_ST_BLOCKS =3D stx->stx_blocks;
+  stat->st_atim =3D statx_timestamp_to_timespec (stx->stx_atime);
+  stat->st_mtim =3D statx_timestamp_to_timespec (stx->stx_mtime);
+  stat->st_ctim =3D statx_timestamp_to_timespec (stx->stx_ctime);
+}
+#endif /* HAVE_STATX && defined STATX_INO */
+#endif /* COREUTILS_STATX_H */
--=20
2.21.0
