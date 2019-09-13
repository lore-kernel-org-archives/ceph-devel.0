From: Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [coreutils PATCH v2 2/2] ls: use statx instead of stat when available
Date: Fri, 13 Sep 2019 06:58:05 -0400
Message-ID: <20190913105805.24669-3-jlayton@kernel.org>
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

* add wrapper functions for stat/lstat/fstat calls, and add variants for
  when we are only interested in specific info
* add statx-enabled functions and set the request mask based on the
  output format and what values are needed
* for loop detection, use AT_STATX_DONT_SYNC since we're only interested
  in the dev/ino and that should never change
---
 src/ls.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/src/ls.c b/src/ls.c
index 120ce153e340..003a69aaa280 100644
--- a/src/ls.c
+++ b/src/ls.c
@@ -114,6 +114,7 @@
 #include "xgethostname.h"
 #include "c-ctype.h"
 #include "canonicalize.h"
+#include "statx.h"
=20
 /* Include <sys/capability.h> last to avoid a clash of <sys/types.h>
    include guards with some premature versions of libcap.
@@ -1063,6 +1064,97 @@ dired_dump_obstack (const char *prefix, struct obs=
tack *os)
     }
 }
=20
+#if HAVE_STATX && defined STATX_INO
+static unsigned int
+calc_req_mask (void)
+{
+  unsigned int mask =3D STATX_MODE;
+
+  if (print_inode)
+    mask |=3D STATX_INO;
+  if (format =3D=3D long_format) {
+    mask |=3D STATX_NLINK | STATX_SIZE;
+    if (print_owner || print_author)
+      mask |=3D STATX_UID;
+    if (print_group)
+      mask |=3D STATX_GID;
+  }
+  return mask;
+}
+
+static int
+do_statx (int fd, const char *name, struct stat *st, int flags,
+	  unsigned int mask)
+{
+  struct statx stx;
+  int ret =3D statx (fd, name, flags, mask, &stx);
+  if (ret >=3D 0)
+    statx_to_stat (&stx, st);
+  return ret;
+}
+
+static inline int
+do_stat (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, 0, calc_req_mask());
+}
+
+static inline int
+do_lstat (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, AT_SYMLINK_NOFOLLOW, calc_req_mas=
k());
+}
+
+static inline int
+stat_for_mode (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, 0, STATX_MODE);
+}
+
+/* dev+ino should be static, so no need to sync with backing store */
+static inline int
+stat_for_ino (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, AT_STATX_DONT_SYNC, STATX_INO);
+}
+
+static inline int
+fstat_for_ino (int fd, struct stat *st)
+{
+  return do_statx (fd, "", st, AT_EMPTY_PATH|AT_STATX_DONT_SYNC, STATX_I=
NO);
+}
+#else
+static inline int
+do_stat (const char *name, struct stat *st)
+{
+  return stat (name, st);
+}
+
+static inline int
+do_lstat (const char *name, struct stat *st)
+{
+  return lstat (name, st);
+}
+
+static inline int
+stat_for_mode (const char *name, struct stat *st)
+{
+  return stat (name, st);
+}
+
+static inline int
+stat_for_ino (const char *name, struct stat *st)
+{
+  return stat (name, st);
+}
+
+static inline int
+fstat_for_ino (int fd, struct stat *st)
+{
+  return fstat (fd, st);
+}
+#endif
+
 /* Return the address of the first plain %b spec in FMT, or NULL if
    there is no such spec.  %5b etc. do not match, so that user
    widths/flags are honored.  */
@@ -2737,10 +2829,10 @@ print_dir (char const *name, char const *realname=
, bool command_line_arg)
       struct stat dir_stat;
       int fd =3D dirfd (dirp);
=20
-      /* If dirfd failed, endure the overhead of using stat.  */
+      /* If dirfd failed, endure the overhead of stat'ing by path  */
       if ((0 <=3D fd
-           ? fstat (fd, &dir_stat)
-           : stat (name, &dir_stat)) < 0)
+           ? fstat_for_ino (fd, &dir_stat)
+           : stat_for_ino (name, &dir_stat)) < 0)
         {
           file_failure (command_line_arg,
                         _("cannot determine device and inode of %s"), na=
me);
@@ -3202,7 +3294,7 @@ gobble_file (char const *name, enum filetype type, =
ino_t inode,
       switch (dereference)
         {
         case DEREF_ALWAYS:
-          err =3D stat (full_name, &f->stat);
+          err =3D do_stat (full_name, &f->stat);
           do_deref =3D true;
           break;
=20
@@ -3211,7 +3303,7 @@ gobble_file (char const *name, enum filetype type, =
ino_t inode,
           if (command_line_arg)
             {
               bool need_lstat;
-              err =3D stat (full_name, &f->stat);
+              err =3D do_stat (full_name, &f->stat);
               do_deref =3D true;
=20
               if (dereference =3D=3D DEREF_COMMAND_LINE_ARGUMENTS)
@@ -3231,7 +3323,7 @@ gobble_file (char const *name, enum filetype type, =
ino_t inode,
           FALLTHROUGH;
=20
         default: /* DEREF_NEVER */
-          err =3D lstat (full_name, &f->stat);
+          err =3D do_lstat (full_name, &f->stat);
           do_deref =3D false;
           break;
         }
@@ -3320,7 +3412,7 @@ gobble_file (char const *name, enum filetype type, =
ino_t inode,
              they won't be traced and when no indicator is needed.  */
           if (linkname
               && (file_type <=3D indicator_style || check_symlink_mode)
-              && stat (linkname, &linkstats) =3D=3D 0)
+              && stat_for_mode(linkname, &linkstats) =3D=3D 0)
             {
               f->linkok =3D true;
               f->linkmode =3D linkstats.st_mode;
--=20
2.21.0
