From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Wed, 7 Mar 2012 09:37:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
References: <4F516A20.8060901@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49911 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab2CGRh7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Mar 2012 12:37:59 -0500
In-Reply-To: <4F516A20.8060901@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

Hey Noah-

This looks great!  I'd love to merge this for v0.44, but need your 
Signed-off-by: on the patches.  Also, if you want to switch to com.ceph 
while you're at it, that'd be good too.

I have a trivial makefile fix in wip-java you might want to look at.

Has any of the hadoop side work been done to use this yet?  Is there 
anything we can do help get that in a state where we can send it upstream?

Thanks!
sage


On Fri, 2 Mar 2012, Noah Watkins wrote:

> Generic libcephfs Java wrappers.
> 
> This is the first of a patch series that can eventually replace the current Java wrappers that are Hadoop specific. This group implements enough of the libcephfs API to support Hadoop functionality, includes Debian packaging, autoconf magics that look for default Java installations, and some basic JUnit tests.
> 
> The patches are available in the git repository at:
> 
>   git://github.com/noahdesu/ceph.git wip/java-cephfs
> 
> Noah Watkins (3):
>   java: add Java and C++ source files
>   java: setup autotools to build cephfs-java
>   debian: add libcephfs-java package
> 
>  configure.ac                                       |   74 ++
>  debian/.gitignore                                  |    1 +
>  debian/control                                     |    8 +-
>  debian/libceph1-java.install                       |    2 +
>  debian/rules                                       |    1 +
>  src/Makefile.am                                    |   15 +-
>  src/java/.gitignore                                |    4 +
>  src/java/Makefile.am                               |   49 +
>  src/java/README                                    |   43 +
>  src/java/build.xml                                 |   67 ++
>  .../java/net/newdream/ceph/fs/CephConstants.java   |   38 +
>  .../java/net/newdream/ceph/fs/CephDirectory.java   |   84 ++
>  .../java/net/newdream/ceph/fs/CephException.java   |   21 +
>  .../ceph/fs/CephInvalidStateException.java         |   11 +
>  src/java/java/net/newdream/ceph/fs/CephMount.java  |  360 +++++++
>  .../net/newdream/ceph/fs/CephNativeLoader.java     |   16 +
>  src/java/java/net/newdream/ceph/fs/CephProxy.java  |  217 ++++
>  src/java/java/net/newdream/ceph/fs/CephStat.java   |   15 +
>  .../java/net/newdream/ceph/fs/CephStatVFS.java     |   14 +
>  src/java/java/net/newdream/ceph/fs/CephStruct.java |   33 +
>  src/java/native/libcephfs_jni.cc                   | 1037 ++++++++++++++++++++
>  src/java/test/CephMountCreateTest.java             |   76 ++
>  src/java/test/CephMountTest.java                   |   72 ++
>  23 files changed, 2256 insertions(+), 2 deletions(-)
>  create mode 100644 debian/libceph1-java.install
>  create mode 100644 src/java/.gitignore
>  create mode 100644 src/java/Makefile.am
>  create mode 100644 src/java/README
>  create mode 100644 src/java/build.xml
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephConstants.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephDirectory.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephException.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephInvalidStateException.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephMount.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephNativeLoader.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephProxy.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephStat.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephStatVFS.java
>  create mode 100644 src/java/java/net/newdream/ceph/fs/CephStruct.java
>  create mode 100644 src/java/native/libcephfs_jni.cc
>  create mode 100644 src/java/test/CephMountCreateTest.java
>  create mode 100644 src/java/test/CephMountTest.java
> 
> -- 
> 1.7.5.4
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
