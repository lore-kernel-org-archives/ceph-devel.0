From: Loic Dachary <loic@dachary.org>
Subject: Re: Unit testing questions for FileStore::_detect_fs
Date: Sat, 16 Feb 2013 19:54:54 +0100
Message-ID: <511FD5FE.3060701@dachary.org>
References: <511243A9.8060804@dachary.org> <alpine.DEB.2.00.1302060844200.10508@cobra.newdream.net> <51177836.4050201@dachary.org> <CAKMAVE-73wjRn=pDAUXeJUXmELNoDFjTxN_-phh+-uS5OvrFUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0270DF2608A169B071E1EB78"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47052 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab3BPSy6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 13:54:58 -0500
In-Reply-To: <CAKMAVE-73wjRn=pDAUXeJUXmELNoDFjTxN_-phh+-uS5OvrFUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0270DF2608A169B071E1EB78
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/16/2013 05:33 PM, Sam Lang wrote:
> On Sun, Feb 10, 2013 at 4:36 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi,
>>
>> On 02/06/2013 05:47 PM, Sage Weil wrote:
>>> On Wed, 6 Feb 2013, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> The patch below adds unit tests for FileStore::_detect_fs, but it ne=
eds to run
>>>> as root in order to mount the ext3, ext4 and btrfs file systems crea=
ted for test purposes.
>>>>
>>>> Is there a way to mount filesystems without root privileges ?
>>>
>>> Not that I know of.
>>>
>>> There are several other tests that are meant ot be run separate from =
the
>>> build environment that use gtest (test_filejournal, the api functiona=
l
>>> tests, etc.).  As long as this is built to a separate binary, I don't=

>>> think it's a problem.  We should converge on unittest_* for the stuff=

>>> 'make check' runs and test_* for stuff that is meant to run elsewhere=
=2E
>>> Having our normal qa harness be root is not a problem.
>>
>> If I understand correctly, these test_* binaries can then be included =
in scripts found in ceph/qa/workunits and used by teuthology. The simples=
t example being https://github.com/ceph/ceph/blob/master/qa/workunits/rbd=
/test_librbd.sh
>=20
> Yep that's right.  Note that the test_* binaries were recently renamed
> to ceph_test_*

Thanks for the hint. Now that I'm done with unit testing buffer.{h,cc} ( =
https://github.com/dachary/ceph/commit/9e22d60eda488195337ed533448c679bf8=
d43639 ) I was about to work on improving ceph_test_filestore and run it =
on various file systems with teuthology. Let me know if my time would be =
better used working on something else ;-)

Cheers

> -sam
>=20
>>
>> Cheers
>>
>>>> configure.ac does not detect the presence of commands such as
>>>> mkfs.ext4 or mkfs.btrfs. The patch below does not add
>>>> AC_CHECK_TOOL([BTRFS], [mkfs.btrfs], ...)  because it has no use
>>>> except for unit testing. Instead, the TEST_F(StoreTest, _detect_fs)
>>>> function checks if /sbin/mkfs.btrfs is an executable. If it is not,
>>>> "SKIP btrfs because /sbin/mkfs.btrfs is not executable" is displayed=

>>>> and nothing is done.
>>>>
>>>> The drawback is that it is quite difficult to figure out what tools
>>>> must be installed to maximize test coverage.
>>>>
>>>> How would you implement unit test tools detection ?
>>>>
>>>> The error returned when ext4 is mounted without user_xattr is the sa=
me
>>>> as the error returned when ext4 is is mounted with user_xattr but
>>>> without the filestore_xattr_use_omap option : -ENOTSUP. From the poi=
nt
>>>> of view of the unit tests, they cannot be distinguished, except by
>>>> parsing the messages sent to derr which show
>>>>
>>>> Extended attributes don't appear to work.
>>>>
>>>> or
>>>>
>>>> limited size xattrs -- enable filestore_xattr_use_omap
>>>>
>>>> Is parsing the output a good practice to assert success or failure d=
uring unit testing ?
>>>
>>> I'm not sure it is worth the complexity.  IMO it would be better to c=
hange
>>> the return value (suggestions?) or not both distinguishing between th=
e two
>>> cases in the test.
>>>
>>> sage
>>>
>>>>
>>>> Cheers
>>>>
>>>> diff --git a/src/test/filestore/store_test.cc b/src/test/filestore/s=
tore_test.cc
>>>> index c98ffb0..7ba38e2 100644
>>>> --- a/src/test/filestore/store_test.cc
>>>> +++ b/src/test/filestore/store_test.cc
>>>> @@ -16,6 +16,7 @@
>>>>  #include <string.h>
>>>>  #include <iostream>
>>>>  #include <time.h>
>>>> +#include <sys/mount.h>
>>>>  #include "os/FileStore.h"
>>>>  #include "include/Context.h"
>>>>  #include "common/ceph_argparse.h"
>>>> @@ -38,6 +39,7 @@ public:
>>>>
>>>>    StoreTest() : store(0) {}
>>>>    virtual void SetUp() {
>>>> +    ::system("rm -fr store_test_temp_dir store_test_temp_journal");=

>>>>      ::mkdir("store_test_temp_dir", 0777);
>>>>      ObjectStore *store_ =3D new FileStore(string("store_test_temp_d=
ir"), string("store_test_temp_journal"));
>>>>      store.reset(store_);
>>>> @@ -823,6 +825,95 @@ TEST_F(StoreTest, ColSplitTest3) {
>>>>  }
>>>>  #endif
>>>>
>>>> +TEST_F(StoreTest, _detect_fs) {
>>>> +  if (getuid() !=3D 0) {
>>>> +    cerr << "SKIP because it does not run as root" << std::endl;
>>>> +    return;
>>>> +  }
>>>> +
>>>> +  if (access("/dev/zero", R_OK) !=3D 0) {
>>>> +    cerr << "SKIP because /dev/zero is not a readable file" << std:=
:endl;
>>>> +    return;
>>>> +  }
>>>> +
>>>> +  const string mnt("/tmp/test_filestore");
>>>> +  ::mkdir(mnt.c_str(), 0755);
>>>> +  ::umount(mnt.c_str());
>>>> +  const string disk(mnt + ".disk");
>>>> +  ::unlink(disk.c_str());
>>>> +  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " bs=
=3D1 count=3D0 seek=3D1G").c_str()), 0);
>>>> +
>>>> +  const string dir("store_test_temp_dir");
>>>> +  const string journal("store_test_temp_journal");
>>>> +
>>>> +  const string mkfs_ext4("/sbin/mkfs.ext4");
>>>> +  if (::access(mkfs_ext4.c_str(), X_OK) =3D=3D 0) {
>>>> +
>>>> +    ASSERT_EQ(::system((mkfs_ext4 + " -q -F " + disk).c_str()), 0);=

>>>> +    //
>>>> +    // without user_xattr, ext4 fails
>>>> +    //
>>>> +    {
>>>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "t=
rue");
>>>> +      ASSERT_EQ(::system((string("mount -o loop,nouser_xattr ") + d=
isk + " " + mnt).c_str()), 0);
>>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>>> +      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
>>>> +      FileStore store(dir, journal);
>>>> +      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
>>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>>> +    }
>>>> +    //
>>>> +    // mounted with user_xattr, ext4 fails if filestore_xattr_use_o=
map is false
>>>> +    //
>>>> +    {
>>>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "f=
alse");
>>>> +      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + dis=
k + " " + mnt).c_str()), 0);
>>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>>> +      FileStore store(dir, journal);
>>>> +      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
>>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>>> +    }
>>>> +    //
>>>> +    // mounted with user_xattr, ext4 succeeds if filestore_xattr_us=
e_omap is true
>>>> +    //
>>>> +    {
>>>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "t=
rue");
>>>> +      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + dis=
k + " " + mnt).c_str()), 0);
>>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>>> +      FileStore store(dir, journal);
>>>> +      ASSERT_EQ(store._detect_fs(), 0);
>>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>>> +    }
>>>> +  } else {
>>>> +    cerr << "SKIP ext4 because " << mkfs_ext4 << " is not executabl=
e" << std::endl;
>>>> +  }
>>>> +
>>>> +  g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "false=
");
>>>> +  ASSERT_EQ(::unlink(disk.c_str()), 0);
>>>> +  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " bs=
=3D1 count=3D0 seek=3D1G").c_str()), 0);
>>>> +  const string mkfs_btrfs("/sbin/mkfs.btrfs");
>>>> +  if (::access(mkfs_btrfs.c_str(), X_OK) =3D=3D 0) {
>>>> +    ASSERT_EQ(::system((mkfs_btrfs + " " + disk).c_str()), 0);
>>>> +    //
>>>> +    // btrfs succeeds
>>>> +    //
>>>> +    {
>>>> +      ASSERT_EQ(::system((string("mount -o loop ") + disk + " " + m=
nt).c_str()), 0);
>>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>>> +      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
>>>> +      FileStore store(dir, journal);
>>>> +      ASSERT_EQ(store._detect_fs(), 0);
>>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>>> +    }
>>>> +  } else {
>>>> +    cerr << "SKIP btrfs because " << mkfs_btrfs << " is not executa=
ble" << std::endl;
>>>> +  }
>>>> +}
>>>> +
>>>>
>>>> --
>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>
>>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig0270DF2608A169B071E1EB78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEf1f4ACgkQ8dLMyEl6F20UuACgv+ZR8Gp8CEysmC0MbmDuFnk/
SrsAn3wV3M3mO0qvJfGSZtaWdtl9oaXZ
=PHxp
-----END PGP SIGNATURE-----

--------------enig0270DF2608A169B071E1EB78--
