From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Wed, 7 Mar 2012 10:02:30 -0800
Message-ID: <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
References: <4F516A20.8060901@cs.ucsc.edu> <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:37110 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050Ab2CGSCd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Mar 2012 13:02:33 -0500
In-Reply-To: <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


On Mar 7, 2012, at 9:37 AM, Sage Weil wrote:

> Hey Noah-
>=20
> This looks great!  I'd love to merge this for v0.44, but need your=20
> Signed-off-by: on the patches.  Also, if you want to switch to com.ce=
ph=20
> while you're at it, that'd be good too.
>=20
> I have a trivial makefile fix in wip-java you might want to look at.

Sounds great. I'll fold in your patches, fix-up the com.ceph path, and =
add the sign-off. When are you shipping v0.44? I'd like to include some=
 more unit tests...

> Has any of the hadoop side work been done to use this yet?  Is there=20
> anything we can do help get that in a state where we can send it upst=
ream?

I've kept an eye on how much things are deviating from the current impl=
ementation and its pretty minimal, so I think producing a new version t=
o use the generic libcephfs interface will happen quickly.

As for producing an upstream patch, I think the two biggest concerns ar=
e:

1. Reporting hostname/racks rather than IPs for object location.
2. Address (or at least document) the time synchronization issue.

These are largely orthogonal to getting the code ready for upstream, bu=
t may be a "political" road block? I can put together the details of th=
ese two issues in a separate thread=85

Thanks,
Noah

>=20
> Thanks!
> sage
>=20
>=20
> On Fri, 2 Mar 2012, Noah Watkins wrote:
>=20
>> Generic libcephfs Java wrappers.
>>=20
>> This is the first of a patch series that can eventually replace the =
current Java wrappers that are Hadoop specific. This group implements e=
nough of the libcephfs API to support Hadoop functionality, includes De=
bian packaging, autoconf magics that look for default Java installation=
s, and some basic JUnit tests.
>>=20
>> The patches are available in the git repository at:
>>=20
>>  git://github.com/noahdesu/ceph.git wip/java-cephfs
>>=20
>> Noah Watkins (3):
>>  java: add Java and C++ source files
>>  java: setup autotools to build cephfs-java
>>  debian: add libcephfs-java package
>>=20
>> configure.ac                                       |   74 ++
>> debian/.gitignore                                  |    1 +
>> debian/control                                     |    8 +-
>> debian/libceph1-java.install                       |    2 +
>> debian/rules                                       |    1 +
>> src/Makefile.am                                    |   15 +-
>> src/java/.gitignore                                |    4 +
>> src/java/Makefile.am                               |   49 +
>> src/java/README                                    |   43 +
>> src/java/build.xml                                 |   67 ++
>> .../java/net/newdream/ceph/fs/CephConstants.java   |   38 +
>> .../java/net/newdream/ceph/fs/CephDirectory.java   |   84 ++
>> .../java/net/newdream/ceph/fs/CephException.java   |   21 +
>> .../ceph/fs/CephInvalidStateException.java         |   11 +
>> src/java/java/net/newdream/ceph/fs/CephMount.java  |  360 +++++++
>> .../net/newdream/ceph/fs/CephNativeLoader.java     |   16 +
>> src/java/java/net/newdream/ceph/fs/CephProxy.java  |  217 ++++
>> src/java/java/net/newdream/ceph/fs/CephStat.java   |   15 +
>> .../java/net/newdream/ceph/fs/CephStatVFS.java     |   14 +
>> src/java/java/net/newdream/ceph/fs/CephStruct.java |   33 +
>> src/java/native/libcephfs_jni.cc                   | 1037 ++++++++++=
++++++++++
>> src/java/test/CephMountCreateTest.java             |   76 ++
>> src/java/test/CephMountTest.java                   |   72 ++
>> 23 files changed, 2256 insertions(+), 2 deletions(-)
>> create mode 100644 debian/libceph1-java.install
>> create mode 100644 src/java/.gitignore
>> create mode 100644 src/java/Makefile.am
>> create mode 100644 src/java/README
>> create mode 100644 src/java/build.xml
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephConstants.=
java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephDirectory.=
java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephException.=
java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephInvalidSta=
teException.java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephMount.java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephNativeLoad=
er.java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephProxy.java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephStat.java
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephStatVFS.ja=
va
>> create mode 100644 src/java/java/net/newdream/ceph/fs/CephStruct.jav=
a
>> create mode 100644 src/java/native/libcephfs_jni.cc
>> create mode 100644 src/java/test/CephMountCreateTest.java
>> create mode 100644 src/java/test/CephMountTest.java
>>=20
>> --=20
>> 1.7.5.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
