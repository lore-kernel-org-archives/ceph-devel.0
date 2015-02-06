From: Xavier Roche <roche+kml2@exalead.com>
Subject: Re: flock() on libcephfs ?
Date: Fri, 06 Feb 2015 15:31:45 +0100
Message-ID: <54D4D051.2020608@exalead.com>
References: <54D499D5.3060505@exalead.com> <CAGd4Wr3Yu6OZ__QZAfrQH5zUrNoTgXfUfSyouJ6VX=Z4ma9HKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000603020506080406010603"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mhx-mail-gw.exalead.com ([178.255.215.32]:53549 "EHLO
	exalead.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753666AbbBFObv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Feb 2015 09:31:51 -0500
In-Reply-To: <CAGd4Wr3Yu6OZ__QZAfrQH5zUrNoTgXfUfSyouJ6VX=Z4ma9HKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000603020506080406010603
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi!,

On 02/06/2015 02:44 PM, John Spray wrote:
> You should let the caller pass in the owner ID.  For example, if you
> were using libcephfs to implement a filesystem interface, it would be
> up to that interface to work out the unique ID from the calling layer
> above it.  So you can pass it through libcephfs, no logic needed.

Thanks. I assume the locking depends on the (pid, owner) tuple in this case ?

>> Thanks in advance for any hints! By the way - would this new feature (flock()) make sense ?
> Definitely, the flock support in the userspace client is new, and the
> libcephfs bindings just didn't catch up yet: it was added in October:

Not sure if my patch looks sane enough to be submitted, but here it is. Please advise me if there is a more suitable way than posting patches here :)

[ Note that I did not ran extensive tests now, but this is only an interface to the existing Client interface one, and the very minimalistic test sample below seems to be working fine.
]

////////// Sample test //////////
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cephfs/libcephfs.h>

static bool check(const char *name, int code) {
  if (code >= 0) {
    fprintf(stderr, "%s: OK\n", name);
    return true;
  } else {
    errno = -code;
    perror(name);
    fprintf(stderr, "%s: ERROR\n", name);
    return false;
  }
}

int main(int argc, char **argv) {
  int success = EXIT_FAILURE;
  struct ceph_mount_info *cmount = NULL;

  int fd;
  if (check("ceph_create", ceph_create(&cmount, "admin"))
      && check("ceph_conf_set(keyfile)",
               ceph_conf_set(cmount, "keyfile",
                             "ceph.admin.key"))
      && check("ceph_conf_set(mon_host)",
               ceph_conf_set(cmount, "mon_host", "10.42.42.42"))
      && check("ceph_conf_set(log_to_stderr)",
               ceph_conf_set(cmount, "log_to_stderr", "true"))
      && check("ceph_mount", ceph_mount(cmount, NULL))
      && check("ceph_open",
               fd = ceph_open(cmount, "/test.lock", O_RDWR | O_CREAT,
                              S_IRWXU | S_IRWXG | S_IRWXO))
      ) {
    if (check("ceph_flock", ceph_flock(cmount, fd, LOCK_EX, 42))) {
      success = EXIT_SUCCESS;
    }
    
    fd >= 0 && check("ceph_close", ceph_close(cmount, fd));
  }
  cmount != NULL && check("ceph_unmount", ceph_unmount(cmount));

  return success;
}


--------------000603020506080406010603
Content-Type: text/x-patch;
 name="ceph_flock-ceph_0_91.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph_flock-ceph_0_91.patch"

diff -rudb ceph-0.91.orig/src/client/Client.cc ceph-0.91/src/client/Client.cc
--- ceph-0.91.orig/src/client/Client.cc	2015-01-14 00:42:08.000000000 +0100
+++ ceph-0.91/src/client/Client.cc	2015-02-06 15:18:50.231912657 +0100
@@ -5665,6 +5665,19 @@
   return _setattr(in, &attr, CEPH_SETATTR_MTIME|CEPH_SETATTR_ATIME);
 }
 
+int Client::flock(int fd, int operation, uint64_t owner)
+{
+  Mutex::Locker lock(client_lock);
+  tout(cct) << "flock" << std::endl;
+  tout(cct) << fd << std::endl;
+  tout(cct) << operation << std::endl;
+  Fh *f = get_filehandle(fd);
+  if (!f)
+    return -EBADF;
+
+  return _flock(f, operation, owner, NULL);
+}
+
 int Client::opendir(const char *relpath, dir_result_t **dirpp) 
 {
   Mutex::Locker lock(client_lock);
diff -rudb ceph-0.91.orig/src/client/Client.h ceph-0.91/src/client/Client.h
--- ceph-0.91.orig/src/client/Client.h	2015-01-14 00:42:08.000000000 +0100
+++ ceph-0.91/src/client/Client.h	2015-02-06 14:47:28.894246885 +0100
@@ -813,6 +813,7 @@
   int lchown(const char *path, int uid, int gid);
   int utime(const char *path, struct utimbuf *buf);
   int lutime(const char *path, struct utimbuf *buf);
+  int flock(int fd, int operation, uint64_t owner);
   int truncate(const char *path, loff_t size);
 
   // file ops
diff -rudb ceph-0.91.orig/src/include/cephfs/libcephfs.h ceph-0.91/src/include/cephfs/libcephfs.h
--- ceph-0.91.orig/src/include/cephfs/libcephfs.h	2015-01-14 00:42:04.000000000 +0100
+++ ceph-0.91/src/include/cephfs/libcephfs.h	2015-02-06 14:48:35.013737212 +0100
@@ -684,6 +684,21 @@
 int ceph_utime(struct ceph_mount_info *cmount, const char *path, struct utimbuf *buf);
 
 /**
+ * Apply or remove an advisory lock.
+ *
+ * @param cmount the ceph mount handle to use for performing the utime.
+ * @param fd the open file descriptor to change advisory lock.
+ * @param operation the advisory lock operation to be performed on the file
+ * descriptor among LOCK_SH (shared lock), LOCK_EX (exclusive lock),
+ * or LOCK_UN (remove lock). The LOCK_NB value can be ORed to perform a
+ * non-blocking operation.
+ * @param owner the user-supplied owner identifier
+ * @returns 0 on success or negative error code on failure.
+ */
+int ceph_flock(struct ceph_mount_info *cmount, int fd, int operation,
+	       uint64_t owner);
+
+/**
  * Truncate the file to the given size.  If this operation causes the
  * file to expand, the empty bytes will be filled in with zeros.
  *
diff -rudb ceph-0.91.orig/src/libcephfs.cc ceph-0.91/src/libcephfs.cc
--- ceph-0.91.orig/src/libcephfs.cc	2015-01-14 00:42:04.000000000 +0100
+++ ceph-0.91/src/libcephfs.cc	2015-02-06 14:47:50.626079362 +0100
@@ -718,6 +718,14 @@
   return cmount->get_client()->utime(path, buf);
 }
 
+extern "C" int ceph_flock(struct ceph_mount_info *cmount, int fd, int operation,
+			  uint64_t owner)
+{
+  if (!cmount->is_mounted())
+    return -ENOTCONN;
+  return cmount->get_client()->flock(fd, operation, owner);
+}
+
 extern "C" int ceph_truncate(struct ceph_mount_info *cmount, const char *path,
 			     int64_t size)
 {

--------------000603020506080406010603--
