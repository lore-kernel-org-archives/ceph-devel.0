From: Sage Weil <sage@inktank.com>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Thu, 6 Sep 2012 08:42:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54778 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756847Ab2IFPmT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 11:42:19 -0400
In-Reply-To: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>, gcs@debian.hu
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 5 Sep 2012, Noah Watkins wrote:
> Latest version of Java bindings. There is ~full coverage of the
> libcephfs API, and nearly a complete set of unit tests covering
> success, and common failure cases. In addition to the basic review, I
> think the Debian integration needs review.
> 
> Patches are here:
> 
>   git://github.com/noahdesu/ceph.git wip-java-cephfs

The debian bits look okay to my untrained eye.  Laszlo, do you mind taking 
a quick look?

Also, I noticed the automake patch removes CephException.java, added in 
the previous patch... probably an accident?

Can't wait to pull this in!  BTW, Noah, do you know if this is still an 
issue?

	http://tracker.newdream.net/issues/2778

Thanks!
sage

> 
> ----------------------------------------------------------------
> Noah Watkins (4):
>       libcephfs: return error when not mounted
>       java: add Java and C++ source files
>       automake: setup autotools to build cephfs-java
>       debian: add libcephfs-java package
> 
> Sage Weil (2):
>       do_autogen.sh: add -j flag to enable java stuff
>       Makefile: add src/include to #include path for libcephfs_jni_la
> 
>  configure.ac                                       |   74 +
>  debian/.gitignore                                  |    1 +
>  debian/control                                     |    7 +-
>  debian/libceph1-java.install                       |    2 +
>  debian/rules                                       |    1 +
>  do_autogen.sh                                      |    5 +-
>  src/Makefile.am                                    |   15 +-
>  src/common/config_opts.h                           |    1 +
>  src/include/cephfs/libcephfs.h                     |    7 +
>  src/java/.gitignore                                |    4 +
>  src/java/Makefile.am                               |   43 +
>  src/java/README                                    |   48 +
>  src/java/build.xml                                 |   67 +
>  src/java/java/com/ceph/fs/CephMount.java           |  645 ++++++
>  src/java/java/com/ceph/fs/CephNativeLoader.java    |   35 +
>  .../java/com/ceph/fs/CephNotMountedException.java  |   42 +
>  src/java/java/com/ceph/fs/CephStat.java            |   45 +
>  src/java/java/com/ceph/fs/CephStatVFS.java         |   33 +
>  src/java/native/libcephfs_jni.cc                   | 2383 ++++++++++++++++++++
>  src/java/test/CephMountCreateTest.java             |   88 +
>  src/java/test/CephMountTest.java                   |  797 +++++++
>  src/java/test/CephUnmountedTest.java               |  143 ++
>  src/libcephfs.cc                                   |  134 +-
>  23 files changed, 4614 insertions(+), 6 deletions(-)
>  create mode 100644 debian/libceph1-java.install
>  create mode 100644 src/java/.gitignore
>  create mode 100644 src/java/Makefile.am
>  create mode 100644 src/java/README
>  create mode 100644 src/java/build.xml
>  create mode 100644 src/java/java/com/ceph/fs/CephMount.java
>  create mode 100644 src/java/java/com/ceph/fs/CephNativeLoader.java
>  create mode 100644 src/java/java/com/ceph/fs/CephNotMountedException.java
>  create mode 100644 src/java/java/com/ceph/fs/CephStat.java
>  create mode 100644 src/java/java/com/ceph/fs/CephStatVFS.java
>  create mode 100644 src/java/native/libcephfs_jni.cc
>  create mode 100644 src/java/test/CephMountCreateTest.java
>  create mode 100644 src/java/test/CephMountTest.java
>  create mode 100644 src/java/test/CephUnmountedTest.java
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
