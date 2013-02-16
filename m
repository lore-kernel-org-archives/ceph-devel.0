From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Unit testing questions for FileStore::_detect_fs
Date: Sat, 16 Feb 2013 10:33:48 -0600
Message-ID: <CAKMAVE-73wjRn=pDAUXeJUXmELNoDFjTxN_-phh+-uS5OvrFUQ@mail.gmail.com>
References: <511243A9.8060804@dachary.org>
	<alpine.DEB.2.00.1302060844200.10508@cobra.newdream.net>
	<51177836.4050201@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38524 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3BPQds convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:33:48 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so4548405obc.18
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:33:48 -0800 (PST)
In-Reply-To: <51177836.4050201@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Feb 10, 2013 at 4:36 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> On 02/06/2013 05:47 PM, Sage Weil wrote:
>> On Wed, 6 Feb 2013, Loic Dachary wrote:
>>> Hi,
>>>
>>> The patch below adds unit tests for FileStore::_detect_fs, but it n=
eeds to run
>>> as root in order to mount the ext3, ext4 and btrfs file systems cre=
ated for test purposes.
>>>
>>> Is there a way to mount filesystems without root privileges ?
>>
>> Not that I know of.
>>
>> There are several other tests that are meant ot be run separate from=
 the
>> build environment that use gtest (test_filejournal, the api function=
al
>> tests, etc.).  As long as this is built to a separate binary, I don'=
t
>> think it's a problem.  We should converge on unittest_* for the stuf=
f
>> 'make check' runs and test_* for stuff that is meant to run elsewher=
e.
>> Having our normal qa harness be root is not a problem.
>
> If I understand correctly, these test_* binaries can then be included=
 in scripts found in ceph/qa/workunits and used by teuthology. The simp=
lest example being https://github.com/ceph/ceph/blob/master/qa/workunit=
s/rbd/test_librbd.sh

Yep that's right.  Note that the test_* binaries were recently renamed
to ceph_test_*
-sam

>
> Cheers
>
>>> configure.ac does not detect the presence of commands such as
>>> mkfs.ext4 or mkfs.btrfs. The patch below does not add
>>> AC_CHECK_TOOL([BTRFS], [mkfs.btrfs], ...)  because it has no use
>>> except for unit testing. Instead, the TEST_F(StoreTest, _detect_fs)
>>> function checks if /sbin/mkfs.btrfs is an executable. If it is not,
>>> "SKIP btrfs because /sbin/mkfs.btrfs is not executable" is displaye=
d
>>> and nothing is done.
>>>
>>> The drawback is that it is quite difficult to figure out what tools
>>> must be installed to maximize test coverage.
>>>
>>> How would you implement unit test tools detection ?
>>>
>>> The error returned when ext4 is mounted without user_xattr is the s=
ame
>>> as the error returned when ext4 is is mounted with user_xattr but
>>> without the filestore_xattr_use_omap option : -ENOTSUP. From the po=
int
>>> of view of the unit tests, they cannot be distinguished, except by
>>> parsing the messages sent to derr which show
>>>
>>> Extended attributes don't appear to work.
>>>
>>> or
>>>
>>> limited size xattrs -- enable filestore_xattr_use_omap
>>>
>>> Is parsing the output a good practice to assert success or failure =
during unit testing ?
>>
>> I'm not sure it is worth the complexity.  IMO it would be better to =
change
>> the return value (suggestions?) or not both distinguishing between t=
he two
>> cases in the test.
>>
>> sage
>>
>>>
>>> Cheers
>>>
>>> diff --git a/src/test/filestore/store_test.cc b/src/test/filestore/=
store_test.cc
>>> index c98ffb0..7ba38e2 100644
>>> --- a/src/test/filestore/store_test.cc
>>> +++ b/src/test/filestore/store_test.cc
>>> @@ -16,6 +16,7 @@
>>>  #include <string.h>
>>>  #include <iostream>
>>>  #include <time.h>
>>> +#include <sys/mount.h>
>>>  #include "os/FileStore.h"
>>>  #include "include/Context.h"
>>>  #include "common/ceph_argparse.h"
>>> @@ -38,6 +39,7 @@ public:
>>>
>>>    StoreTest() : store(0) {}
>>>    virtual void SetUp() {
>>> +    ::system("rm -fr store_test_temp_dir store_test_temp_journal")=
;
>>>      ::mkdir("store_test_temp_dir", 0777);
>>>      ObjectStore *store_ =3D new FileStore(string("store_test_temp_=
dir"), string("store_test_temp_journal"));
>>>      store.reset(store_);
>>> @@ -823,6 +825,95 @@ TEST_F(StoreTest, ColSplitTest3) {
>>>  }
>>>  #endif
>>>
>>> +TEST_F(StoreTest, _detect_fs) {
>>> +  if (getuid() !=3D 0) {
>>> +    cerr << "SKIP because it does not run as root" << std::endl;
>>> +    return;
>>> +  }
>>> +
>>> +  if (access("/dev/zero", R_OK) !=3D 0) {
>>> +    cerr << "SKIP because /dev/zero is not a readable file" << std=
::endl;
>>> +    return;
>>> +  }
>>> +
>>> +  const string mnt("/tmp/test_filestore");
>>> +  ::mkdir(mnt.c_str(), 0755);
>>> +  ::umount(mnt.c_str());
>>> +  const string disk(mnt + ".disk");
>>> +  ::unlink(disk.c_str());
>>> +  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " b=
s=3D1 count=3D0 seek=3D1G").c_str()), 0);
>>> +
>>> +  const string dir("store_test_temp_dir");
>>> +  const string journal("store_test_temp_journal");
>>> +
>>> +  const string mkfs_ext4("/sbin/mkfs.ext4");
>>> +  if (::access(mkfs_ext4.c_str(), X_OK) =3D=3D 0) {
>>> +
>>> +    ASSERT_EQ(::system((mkfs_ext4 + " -q -F " + disk).c_str()), 0)=
;
>>> +    //
>>> +    // without user_xattr, ext4 fails
>>> +    //
>>> +    {
>>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "=
true");
>>> +      ASSERT_EQ(::system((string("mount -o loop,nouser_xattr ") + =
disk + " " + mnt).c_str()), 0);
>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>> +      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
>>> +      FileStore store(dir, journal);
>>> +      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>> +    }
>>> +    //
>>> +    // mounted with user_xattr, ext4 fails if filestore_xattr_use_=
omap is false
>>> +    //
>>> +    {
>>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "=
false");
>>> +      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + di=
sk + " " + mnt).c_str()), 0);
>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>> +      FileStore store(dir, journal);
>>> +      ASSERT_EQ(store._detect_fs(), -ENOTSUP);
>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>> +    }
>>> +    //
>>> +    // mounted with user_xattr, ext4 succeeds if filestore_xattr_u=
se_omap is true
>>> +    //
>>> +    {
>>> +      g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "=
true");
>>> +      ASSERT_EQ(::system((string("mount -o loop,user_xattr ") + di=
sk + " " + mnt).c_str()), 0);
>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>> +      FileStore store(dir, journal);
>>> +      ASSERT_EQ(store._detect_fs(), 0);
>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>> +    }
>>> +  } else {
>>> +    cerr << "SKIP ext4 because " << mkfs_ext4 << " is not executab=
le" << std::endl;
>>> +  }
>>> +
>>> +  g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "fals=
e");
>>> +  ASSERT_EQ(::unlink(disk.c_str()), 0);
>>> +  ASSERT_EQ(::system(string("dd if=3D/dev/zero of=3D" + disk + " b=
s=3D1 count=3D0 seek=3D1G").c_str()), 0);
>>> +  const string mkfs_btrfs("/sbin/mkfs.btrfs");
>>> +  if (::access(mkfs_btrfs.c_str(), X_OK) =3D=3D 0) {
>>> +    ASSERT_EQ(::system((mkfs_btrfs + " " + disk).c_str()), 0);
>>> +    //
>>> +    // btrfs succeeds
>>> +    //
>>> +    {
>>> +      ASSERT_EQ(::system((string("mount -o loop ") + disk + " " + =
mnt).c_str()), 0);
>>> +      ASSERT_EQ(::chdir(mnt.c_str()), 0);
>>> +      ASSERT_EQ(::mkdir(dir.c_str(), 0755), 0);
>>> +      FileStore store(dir, journal);
>>> +      ASSERT_EQ(store._detect_fs(), 0);
>>> +      ASSERT_EQ(::chdir("/tmp"), 0);
>>> +      ASSERT_EQ(::umount(mnt.c_str()), 0);
>>> +    }
>>> +  } else {
>>> +    cerr << "SKIP btrfs because " << mkfs_btrfs << " is not execut=
able" << std::endl;
>>> +  }
>>> +}
>>> +
>>>
>>> --
>>> Lo?c Dachary, Artisan Logiciel Libre
>>>
>>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
