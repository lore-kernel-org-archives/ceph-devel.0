From: Loic Dachary <loic@dachary.org>
Subject: Re: Unit testing questions for FileStore::_detect_fs
Date: Sun, 10 Feb 2013 11:36:38 +0100
Message-ID: <51177836.4050201@dachary.org>
References: <511243A9.8060804@dachary.org> <alpine.DEB.2.00.1302060844200.10508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB8DADCBE6730608215F82DAD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47153 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab3BJKgm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 05:36:42 -0500
In-Reply-To: <alpine.DEB.2.00.1302060844200.10508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8DADCBE6730608215F82DAD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/06/2013 05:47 PM, Sage Weil wrote:
> On Wed, 6 Feb 2013, Loic Dachary wrote:
>> Hi,
>>
>> The patch below adds unit tests for FileStore::_detect_fs, but it need=
s to run
>> as root in order to mount the ext3, ext4 and btrfs file systems create=
d for test purposes.
>>
>> Is there a way to mount filesystems without root privileges ?
>=20
> Not that I know of.
>=20
> There are several other tests that are meant ot be run separate from th=
e
> build environment that use gtest (test_filejournal, the api functional =

> tests, etc.).  As long as this is built to a separate binary, I don't=20
> think it's a problem.  We should converge on unittest_* for the stuff=20
> 'make check' runs and test_* for stuff that is meant to run elsewhere. =
=20
> Having our normal qa harness be root is not a problem.

If I understand correctly, these test_* binaries can then be included in =
scripts found in ceph/qa/workunits and used by teuthology. The simplest e=
xample being https://github.com/ceph/ceph/blob/master/qa/workunits/rbd/te=
st_librbd.sh

Cheers
=20
>> configure.ac does not detect the presence of commands such as
>> mkfs.ext4 or mkfs.btrfs. The patch below does not add
>> AC_CHECK_TOOL([BTRFS], [mkfs.btrfs], ...)  because it has no use
>> except for unit testing. Instead, the TEST_F(StoreTest, _detect_fs)
>> function checks if /sbin/mkfs.btrfs is an executable. If it is not,
>> "SKIP btrfs because /sbin/mkfs.btrfs is not executable" is displayed
>> and nothing is done.
>>
>> The drawback is that it is quite difficult to figure out what tools
>> must be installed to maximize test coverage.
>>
>> How would you implement unit test tools detection ?
>>
>> The error returned when ext4 is mounted without user_xattr is the same=

>> as the error returned when ext4 is is mounted with user_xattr but
>> without the filestore_xattr_use_omap option : -ENOTSUP. From the point=

>> of view of the unit tests, they cannot be distinguished, except by
>> parsing the messages sent to derr which show
>>
>> Extended attributes don't appear to work.
>>
>> or
>>
>> limited size xattrs -- enable filestore_xattr_use_omap
>>
>> Is parsing the output a good practice to assert success or failure dur=
ing unit testing ?
>=20
> I'm not sure it is worth the complexity.  IMO it would be better to cha=
nge=20
> the return value (suggestions?) or not both distinguishing between the =
two=20
> cases in the test.
>=20
> sage
>=20
>>
>> Cheers
>>
>> diff --git a/src/test/filestore/store_test.cc b/src/test/filestore/sto=
re_test.cc
>> index c98ffb0..7ba38e2 100644
>> --- a/src/test/filestore/store_test.cc
>> +++ b/src/test/filestore/store_test.cc
>> @@ -16,6 +16,7 @@
>>  #include <string.h>
>>  #include <iostream>
>>  #include <time.h>
>> +#include <sys/mount.h>
>>  #include "os/FileStore.h"
>>  #include "include/Context.h"
>>  #include "common/ceph_argparse.h"
>> @@ -38,6 +39,7 @@ public:
>>
>>    StoreTest() : store(0) {}
>>    virtual void SetUp() {
>> +    ::system("rm -fr store_test_temp_dir store_test_temp_journal");
>>      ::mkdir("store_test_temp_dir", 0777);
>>      ObjectStore *store_ =3D new FileStore(string("store_test_temp_dir=
"), string("store_test_temp_journal"));
>>      store.reset(store_);
>> @@ -823,6 +825,95 @@ TEST_F(StoreTest, ColSplitTest3) {
>>  }
>>  #endif
>>
>> +TEST_F(StoreTest, _detect_fs) {
>> +  if (getuid() !=3D 0) {
>> +    cerr << "SKIP because it does not run as root" << std::endl;
>> +    return;
>> +  }
>> +
>> +  if (access("/dev/zero", R_OK) !=3D 0) {
>> +    cerr << "SKIP because /dev/zero is not a readable file" << std::e=
ndl;
>> +    return;
>> +  }
>> +
>> +  const string mnt("/tmp/test_filestore");
>> +  ::mkdir(mnt.c_str(), 0755);
>> +  ::umount(mnt.c_str());
>> +  const string disk(mnt + ".disk");
>> +  ::unlink(disk.c_str());
>> +  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " bs=3D=
1 count=3D0 seek=3D1G").c_str()), 0);
>> +
>> +  const string dir("store_test_temp_dir");
>> +  const string journal("store_test_temp_journal");
>> +
>> +  const string mkfs_ext4("/sbin/mkfs.ext4");
>> +  if (::access(mkfs_ext4.c_str(), X_OK) =3D=3D 0) {
>> +
>> +    ASSERT_EQ(::system((mkfs_ext4 + " -q -F " + disk).c_str()), 0);
>> +    //
>> +    // without user_xattr, ext4 fails
>> +    //
>> +    {
>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "tru=
e");
>> +      ASSERT_EQ(::system((string("mount -o loop,nouser_xattr ") + dis=
k + " " + mnt).c_str()), 0);
>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>> +      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
>> +      FileStore store(dir, journal);
>> +      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>> +    }
>> +    //
>> +    // mounted with user_xattr, ext4 fails if filestore_xattr_use_oma=
p is false
>> +    //
>> +    {
>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "fal=
se");
>> +      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + disk =
+ " " + mnt).c_str()), 0);
>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>> +      FileStore store(dir, journal);
>> +      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>> +    }
>> +    //
>> +    // mounted with user_xattr, ext4 succeeds if filestore_xattr_use_=
omap is true
>> +    //
>> +    {
>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "tru=
e");
>> +      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + disk =
+ " " + mnt).c_str()), 0);
>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>> +      FileStore store(dir, journal);
>> +      ASSERT_EQ(store._detect_fs(), 0);
>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>> +    }
>> +  } else {
>> +    cerr << "SKIP ext4 because " << mkfs_ext4 << " is not executable"=
 << std::endl;
>> +  }
>> +
>> +  g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "false")=
;
>> +  ASSERT_EQ(::unlink(disk.c_str()), 0);
>> +  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " bs=3D=
1 count=3D0 seek=3D1G").c_str()), 0);
>> +  const string mkfs_btrfs("/sbin/mkfs.btrfs");
>> +  if (::access(mkfs_btrfs.c_str(), X_OK) =3D=3D 0) {
>> +    ASSERT_EQ(::system((mkfs_btrfs + " " + disk).c_str()), 0);
>> +    //
>> +    // btrfs succeeds
>> +    //
>> +    {
>> +      ASSERT_EQ(::system((string("mount -o loop ") + disk + " " + mnt=
).c_str()), 0);
>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>> +      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
>> +      FileStore store(dir, journal);
>> +      ASSERT_EQ(store._detect_fs(), 0);
>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>> +    }
>> +  } else {
>> +    cerr << "SKIP btrfs because " << mkfs_btrfs << " is not executabl=
e" << std::endl;
>> +  }
>> +}
>> +
>>
>> --=20
>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigB8DADCBE6730608215F82DAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEXeDcACgkQ8dLMyEl6F2140gCePcZkrIkUQZQQ45mgNVk2lPms
IMMAnA3ZptaTxrdzAgDQGV9ry4GrwLkD
=RX3t
-----END PGP SIGNATURE-----

--------------enigB8DADCBE6730608215F82DAD--
