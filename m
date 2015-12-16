From: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Subject: [testing ceph] with gnu stow and NFS
Date: Wed, 16 Dec 2015 12:30:17 +0000
Message-ID: <c7963782093a4064978234cbe905f8d9@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.176]:24354 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932335AbbLPMad convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Dec 2015 07:30:33 -0500
Received: from R01UKEXCASM225.r01.fujitsu.local (ex2k13_225.fs.fujitsu.com [10.182.185.123])
	by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id tBGCSEZY007926
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 12:28:25 GMT
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

H Cephers!

TL;DR
Use NFS server to share binaries and libs (ceph and any other) among yo=
ur cluster. Then link them using  gnu stow from mounted NFS to the root=
 ( / ) directory on every node. Now switching between your custom ceph =
builids (or any other e.g. tcmalloc) on whole cluster will be very fast=
, easy to automate and consistent. Stow will change your ceph version u=
sing symbolic links with two commands only.

Long version:

I want to share with you, one of my concepts that make my life testing =
ceph a little bit easier. Some time ago I wrote a few words about this =
in other thread, but You probably missed them, because of heavy discuss=
ion in that thread.

Main idea was to make easy mechanism to switch between ceph versions: b=
inaries/libs - everything. But the truth was I'm too lazy to reinstall =
it manually on every host and to ignorant to check if I've installed ri=
ght version ;)

What I have at the moment:
- NFS server that exports /home/ceph to all of my cluster nodes
- Several subfolders with ceph builds, e.g. /home/ceph/ceph-0.94.1, /ho=
me/ceph/git/ceph
- and libraries e.g. /home/ceph/tcmalloc/gpertftools-2.4

In /home/ceph/ceph-0.94.1 and /home/ceph/tcmalloc/gpertftools-2.4 I hav=
e additional directory called BIN and everything is installed into it b=
y running

instead of normal install (or building RPMs):
$ make
$ make install

something like:

$ mkdir  BIN
$ make
$ make DESTDIR=3D$PWD/BIN install
$ rm -rf $PWD/BIN/var                           # in case of Ceph we do=
n't want to share this directory on NFS, so we must remove it


DESTDIR will install all package related files into BIN, just like it w=
ould be the root ( / ) directory:
$ tree BIN
BIN
??? etc
?=A0=A0 ??? bash_completion.d
?=A0=A0 ?=A0=A0 ??? ceph
?=A0=A0 ?=A0=A0 ??? rados
?=A0=A0 ?=A0=A0 ??? radosgw-admin
?=A0=A0 ?=A0=A0 ??? rbd
?=A0=A0 ??? ceph
??? sbin
?=A0=A0 ??? mount.ceph
?=A0=A0 ??? mount.fuse.ceph
??? usr
    ??? bin
    ?=A0=A0 ??? ceph
    ?=A0=A0 ??? ceph-authtool
    ?=A0=A0 ??? ceph_bench_log
    ?=A0=A0 ??? ceph-brag
    ?=A0=A0 ??? ceph-client-debug
    ?=A0=A0 ??? ceph-clsinfo

And now it's time for gnu stow: https://www.gnu.org/software/stow/

On every node I run from root:
$ stow -d /home/ceph/ceph-0.94.1  -t/ BIN; ldconfig;

Stow will create symbolic links from every file/directory from BIN into=
 root ( / ) directory on my Linux, and ceph would work just like I'd ma=
ke install it normal way, or using rpms.
$ type ceph
ceph is hashed (/usr/bin/ceph)

$ ls -al /usr/bin/ceph
$ lrwxrwxrwx 1 root root 50 Dec 11 14:33 /usr/bin/ceph -> ../../home/ce=
ph/ceph-0.94.1/BIN/usr/bin/ceph

I can do the same for other libraries as well:
$ stow -d /home/ceph/tcmalloc/gperftools-2.4   -t/ BIN; ldconfig;

If I need to check another ceph/library version I just stop ceph on all=
 nodes, then "unstow":
$ stow -D -d /home/ceph/ceph-0.94.1  -t/ BIN; ldconfig;

and "stow" again to different version
$ stow -D -d /home/ceph/ceph-0.94.1_my_custom_build  -t/ BIN; ldconfig;

=3D=3D Exception =3D=3D
/etc/init.d/ceph should be copied into / because when you "unstow" ceph=
, "service ceph start" won't be working.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Then I just start ceph on all nodes and that's all.

Quite fast isn't it?

NFS+stow concept could be used not only for "builds" (compilation, make=
, make install), but from RPMs too (precompiled binaries). You need to =
unpack RPM into BIN folder and run stow, it will work just like you wou=
ld install this rpm in a standard way, into root ( / ).

Placing binaries/libs on NFS does not impact performance on ceph at run=
time, it could in fact cause some delay during processes start, when th=
ey are loaded from file system. Of course NFS will be SPOF, but for tes=
ts that I made this doesn't matter, I test only application behavior an=
d infrastructure is untouched.

This idea is a time-saver at the day, and easy automation during night =
tests.

Regards,
Igor.


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
