From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Sun, 20 Dec 2015 19:38:03 -0700
Message-ID: <CA+9C14bj8A0NbQjrdyGJ5AMKmtoax9VJjEN3a9iXdtfJHueiTw@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
	<CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
	<CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
	<CAAM7YAnktfNvd-EXU+1Eok4kUafWwnvj+CCGocF7ffTcAt-dsA@mail.gmail.com>
	<CA+9C14bbtBjgOD0hpSfapRrsx+Eg_dYyFfV+uXvgB5X7eRidDg@mail.gmail.com>
	<CA+9C14bMs1u80P3g1D4QsDHHzLy5YUvB+KWmcrKa0o5aX9W38g@mail.gmail.com>
	<CAAM7YAm2r+LVPMpE_GbWCJmE-bdi-uXHyzqAR1JgPMXCSx55pQ@mail.gmail.com>
	<CA+9C14bVgWKMxxOe04qiLW6U+baA_TGbFt9RNjY+wPNMiW_R3w@mail.gmail.com>
	<CAAM7YAkTA9skmSxyEPVnEWAyykg4hsoLwxxjFp2nJgMbJAC8VQ@mail.gmail.com>
	<00b601d13954$5d4a94e0$17dfbea0$@samsung.com>
	<CA+9C14aAAVaaLtjDCjLkc9TSmU=aMh-2iq0xKOb-KEcc9vcuMQ@mail.gmail.com>
	<CAAM7YAky6409uw-hyDOJFE+3ftm46cDXpWG7RHznbZtQXcneCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36220 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbLUCiE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Dec 2015 21:38:04 -0500
Received: by mail-yk0-f179.google.com with SMTP id x184so118702895yka.3
        for <ceph-devel@vger.kernel.org>; Sun, 20 Dec 2015 18:38:04 -0800 (PST)
In-Reply-To: <CAAM7YAky6409uw-hyDOJFE+3ftm46cDXpWG7RHznbZtQXcneCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Chao Yu <chao2.yu@samsung.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Dec 18, 2015 at 12:18 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Fri, Dec 18, 2015 at 2:23 PM, Eric Eastman
> <eric.eastman@keepertech.com> wrote:
>>> Hi Yan Zheng, Eric Eastman
>>>
>>> Similar bug was reported in f2fs, btrfs, it does affect 4.4-rc4, the fixing
>>> patch was merged into 4.4-rc5, dfd01f026058 ("sched/wait: Fix the signal
>>> handling fix").
>>>
>>> Related report & discussion was here:
>>> https://lkml.org/lkml/2015/12/12/149
>>>
>>> I'm not sure the current reported issue of ceph was related to that though,
>>> but at least try testing with an upgraded or patched kernel could verify it.
>>> :)
>>>
>>> Thanks,

>
> please try rc5 kernel without patches and DEBUG_VM=y
>
> Regards
> Yan, Zheng


The latest test with 4.4rc5 with CONFIG_DEBUG_VM=y has ran for over 36
hours with no ERRORS or WARNINGS.  My plan is to install the 4.4rc6
kernel from the Ubuntu kernel-ppa site once it is available, and rerun
the tests.

Before running this test I had to rebuild the Ceph File System as
after the last logged errors on Friday using the 4.4rc4 kernel, the
Ceph File system hung accessing the exported image file.  After
rebooting my iSCSI gateway using the Ceph File System, from / using
command: strace du -a cephfs, the mount point, the hang happened on
the newfsstatat call on my image file:

write(1, "0\tcephfs/ctdb/.ctdb.lock\n", 250 cephfs/ctdb/.ctdb.lock
) = 25
close(5)                                = 0
write(1, "0\tcephfs/ctdb\n", 140 cephfs/ctdb
)        = 14
newfstatat(4, "iscsi", {st_mode=S_IFDIR|0755, st_size=993814480896,
...}, AT_SYMLINK_NOFOLLOW) = 0
openat(4, "iscsi", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_DIRECTORY|O_NOFOLLOW) = 3
fcntl(3, F_GETFD)                       = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
fstat(3, {st_mode=S_IFDIR|0755, st_size=993814480896, ...}) = 0
fcntl(3, F_GETFL)                       = 0x38800 (flags
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_NOFOLLOW)
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
newfstatat(4, "iscsi", {st_mode=S_IFDIR|0755, st_size=993814480896,
...}, AT_SYMLINK_NOFOLLOW) = 0
fcntl(3, F_DUPFD, 3)                    = 5
fcntl(5, F_GETFD)                       = 0
fcntl(5, F_SETFD, FD_CLOEXEC)           = 0
getdents(3, /* 8 entries */, 65536)     = 288
getdents(3, /* 0 entries */, 65536)     = 0
close(3)                                = 0
newfstatat(5, "iscsi900g.img", ^C
^C^C^C
^Z
I could not break out with a ^C, and had to background the process to
get my prompt back. The process would not die so I had to hard reset
the system.

This same hang happened on 2 other kernel mounted systems using a 4.3.0 kernel.

On a separate system, I fuse mounted the file system and a du -a
cephfs hung at the same point. Once again I could not break out of the
hang, and had to hard reset the system.

Restarting the MDS and Monitors did not clear the issue. Taking a
quick look at the dumpcache showed it was large

# ceph mds tell 0 dumpcache /tmp/dump.txt
ok
# wc /tmp/dump.txt
  370556  5002449 59211054 /tmp/dump.txt
# tail /tmp/dump.txt
[inode 10000259276 [...c4,head] ~mds0/stray0/10000259276/ auth v977593
snaprealm=0x561339e3fb00 f(v0 m2015-12-12 00:51:04.345614) n(v0
rc2015-12-12 00:51:04.345614 1=0+1) (iversion lock) 0x561339c66228]
[inode 1000020c1ba [...a6,head] ~mds0/stray0/1000020c1ba/ auth v742016
snaprealm=0x56133ad19600 f(v0 m2015-12-10 18:25:55.880167) n(v0
rc2015-12-10 18:25:55.880167 1=0+1) (iversion lock) 0x56133a5e0d88]
[inode 100000d0088 [...77,head] ~mds0/stray6/100000d0088/ auth v292336
snaprealm=0x5613537673c0 f(v0 m2015-12-08 19:23:20.269283) n(v0
rc2015-12-08 19:23:20.269283 1=0+1) (iversion lock) 0x56134c2f7378]

I tried one more thing:

ceph daemon mds.0 flush journal

and restarted the MDS. Accessing the file system still locked up, but
a du -a cephfs did not even get to the iscsi900g.img file. As I was
running on a broken rc kernel, with snapshots turned on, when this
corruption happened, I decided to recreated the file system and
restarted the ESXi iSCSI test.

Regards,
Eric
