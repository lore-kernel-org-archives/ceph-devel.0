From: Loic Dachary <loic@dachary.org>
Subject: Unit testing questions for FileStore::_detect_fs
Date: Wed, 06 Feb 2013 12:51:05 +0100
Message-ID: <511243A9.8060804@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD52FD1A048B0A6E548385E22"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:50777 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab3BFLvJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:51:09 -0500
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 6741726396
	for <ceph-devel@vger.kernel.org>; Wed,  6 Feb 2013 12:51:06 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD52FD1A048B0A6E548385E22
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The patch below adds unit tests for FileStore::_detect_fs, but it needs t=
o run
as root in order to mount the ext3, ext4 and btrfs file systems created f=
or test purposes.

Is there a way to mount filesystems without root privileges ?

configure.ac does not detect the presence of commands such as
mkfs.ext4 or mkfs.btrfs. The patch below does not add
AC_CHECK_TOOL([BTRFS], [mkfs.btrfs], ...)  because it has no use
except for unit testing. Instead, the TEST_F(StoreTest, _detect_fs)
function checks if /sbin/mkfs.btrfs is an executable. If it is not,
"SKIP btrfs because /sbin/mkfs.btrfs is not executable" is displayed
and nothing is done.

The drawback is that it is quite difficult to figure out what tools
must be installed to maximize test coverage.

How would you implement unit test tools detection ?

The error returned when ext4 is mounted without user_xattr is the same
as the error returned when ext4 is is mounted with user_xattr but
without the filestore_xattr_use_omap option : -ENOTSUP. From the point
of view of the unit tests, they cannot be distinguished, except by
parsing the messages sent to derr which show

Extended attributes don't appear to work.

or

limited size xattrs -- enable filestore_xattr_use_omap

Is parsing the output a good practice to assert success or failure during=
 unit testing ?

Cheers

diff --git a/src/test/filestore/store_test.cc b/src/test/filestore/store_=
test.cc
index c98ffb0..7ba38e2 100644
--- a/src/test/filestore/store_test.cc
+++ b/src/test/filestore/store_test.cc
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <iostream>
 #include <time.h>
+#include <sys/mount.h>
 #include "os/FileStore.h"
 #include "include/Context.h"
 #include "common/ceph_argparse.h"
@@ -38,6 +39,7 @@ public:

   StoreTest() : store(0) {}
   virtual void SetUp() {
+    ::system("rm -fr store_test_temp_dir store_test_temp_journal");
     ::mkdir("store_test_temp_dir", 0777);
     ObjectStore *store_ =3D new FileStore(string("store_test_temp_dir"),=
 string("store_test_temp_journal"));
     store.reset(store_);
@@ -823,6 +825,95 @@ TEST_F(StoreTest, ColSplitTest3) {
 }
 #endif

+TEST_F(StoreTest, _detect_fs) {
+  if (getuid() !=3D 0) {
+    cerr << "SKIP because it does not run as root" << std::endl;
+    return;
+  }
+
+  if (access("/dev/zero", R_OK) !=3D 0) {
+    cerr << "SKIP because /dev/zero is not a readable file" << std::endl=
;
+    return;
+  }
+
+  const string mnt("/tmp/test_filestore");
+  ::mkdir(mnt.c_str(), 0755);
+  ::umount(mnt.c_str());
+  const string disk(mnt + ".disk");
+  ::unlink(disk.c_str());
+  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " bs=3D1 =
count=3D0 seek=3D1G").c_str()), 0);
+
+  const string dir("store_test_temp_dir");
+  const string journal("store_test_temp_journal");
+
+  const string mkfs_ext4("/sbin/mkfs.ext4");
+  if (::access(mkfs_ext4.c_str(), X_OK) =3D=3D 0) {
+
+    ASSERT_EQ(::system((mkfs_ext4 + " -q -F " + disk).c_str()), 0);
+    //
+    // without user_xattr, ext4 fails
+    //
+    {
+      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "true")=
;
+      ASSERT_EQ(::system((string("mount -o loop,nouser_xattr ") + disk +=
 " " + mnt).c_str()), 0);
+      ASSERT_EQ(::chdir(mnt.c_str()), 0);
+      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
+      FileStore store(dir, journal);
+      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
+      ASSERT_EQ(::chdir("/tmp"), 0);
+      ASSERT_EQ(::umount(mnt.c_str()), 0);
+    }
+    //
+    // mounted with user_xattr, ext4 fails if filestore_xattr_use_omap i=
s false
+    //
+    {
+      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "false"=
);
+      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + disk + "=
 " + mnt).c_str()), 0);
+      ASSERT_EQ(::chdir(mnt.c_str()), 0);
+      FileStore store(dir, journal);
+      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
+      ASSERT_EQ(::chdir("/tmp"), 0);
+      ASSERT_EQ(::umount(mnt.c_str()), 0);
+    }
+    //
+    // mounted with user_xattr, ext4 succeeds if filestore_xattr_use_oma=
p is true
+    //
+    {
+      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "true")=
;
+      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + disk + "=
 " + mnt).c_str()), 0);
+      ASSERT_EQ(::chdir(mnt.c_str()), 0);
+      FileStore store(dir, journal);
+      ASSERT_EQ(store._detect_fs(), 0);
+      ASSERT_EQ(::chdir("/tmp"), 0);
+      ASSERT_EQ(::umount(mnt.c_str()), 0);
+    }
+  } else {
+    cerr << "SKIP ext4 because " << mkfs_ext4 << " is not executable" <<=
 std::endl;
+  }
+
+  g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "false");
+  ASSERT_EQ(::unlink(disk.c_str()), 0);
+  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " bs=3D1 =
count=3D0 seek=3D1G").c_str()), 0);
+  const string mkfs_btrfs("/sbin/mkfs.btrfs");
+  if (::access(mkfs_btrfs.c_str(), X_OK) =3D=3D 0) {
+    ASSERT_EQ(::system((mkfs_btrfs + " " + disk).c_str()), 0);
+    //
+    // btrfs succeeds
+    //
+    {
+      ASSERT_EQ(::system((string("mount -o loop ") + disk + " " + mnt).c=
_str()), 0);
+      ASSERT_EQ(::chdir(mnt.c_str()), 0);
+      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
+      FileStore store(dir, journal);
+      ASSERT_EQ(store._detect_fs(), 0);
+      ASSERT_EQ(::chdir("/tmp"), 0);
+      ASSERT_EQ(::umount(mnt.c_str()), 0);
+    }
+  } else {
+    cerr << "SKIP btrfs because " << mkfs_btrfs << " is not executable" =
<< std::endl;
+  }
+}
+

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigD52FD1A048B0A6E548385E22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlESQ6oACgkQ8dLMyEl6F208rQCgt/nbHmpw4un2f9loYkTwLpiZ
V9UAmwZRW8h5iD72WLa0sEDflNlVMpSW
=SlMj
-----END PGP SIGNATURE-----

--------------enigD52FD1A048B0A6E548385E22--
