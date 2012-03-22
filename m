From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: leveldb build issues in 0.44
Date: Thu, 22 Mar 2012 16:24:20 -0300
Message-ID: <orfwd0e8wr.fsf@livre.localdomain>
References: <4F6AE7FF02000099000DD5F9@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:42855 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751994Ab2CVTYj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Mar 2012 15:24:39 -0400
In-Reply-To: <4F6AE7FF02000099000DD5F9@collaborate.seakr.com> (Nick Couchman's
	message of "Thu, 22 Mar 2012 08:51:11 -0600")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

--=-=-=

On Mar 22, 2012, "Nick Couchman" <Nick.Couchman@seakr.com> wrote:

> ./db/builder.h:8:28: fatal error: leveldb/status.h: No such file or directory
> compilation terminated.

> This is an RPM build

This patch fixed it for me.


--=-=-=
Content-Type: message/rfc822
Content-Disposition: attachment;
 filename=0003-ceph.spec-don-t-override-CFLAGS.patch

From: Alexandre Oliva <lxoliva@fsfla.org>
Date: Thu, 22 Mar 2012 16:23:02 -0300
Subject: [PATCH 3/3] [ceph.spec] don't override CFLAGS

leveldb adds -I flags to CFLAGS and CXXFLAGS, but if these macros are
overridden in the make command line, the flags are dropped, and the
build fails.  leveldb should probably use AM_CFLAGS instead, but the
spec file can specify the preferred CFLAGS in the configure command
line, and then everything will work as expected.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 ceph.spec.in |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index b8b2d1f..e5df113 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -217,6 +217,8 @@ MY_CONF_OPT="$MY_CONF_OPT --with-gtk2"
 MY_CONF_OPT="$MY_CONF_OPT --without-gtk2"
 %endif
 
+export RPM_OPT_FLAGS=`echo $RPM_OPT_FLAGS | sed -e 's/i386/i486/'`
+
 # be explicit about --with/without-tcmalloc because the
 # autoconf default differs from what's needed for rpm
 %{configure}	--prefix=/usr \
@@ -227,7 +229,8 @@ MY_CONF_OPT="$MY_CONF_OPT --without-gtk2"
 		--without-hadoop \
 		$MY_CONF_OPT \
 		%{?_with_ocf} \
-		%{?with_tcmalloc:--with-tcmalloc} %{!?with_tcmalloc:--without-tcmalloc}
+		%{?with_tcmalloc:--with-tcmalloc} %{!?with_tcmalloc:--without-tcmalloc} \
+		CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
 
 # fix bug in specific version of libedit-devel
 %if 0%{defined suse_version}
@@ -236,9 +239,7 @@ sed -i -e "s/-lcurses/-lncurses/g" src/Makefile
 sed -i -e "s/-lcurses/-lncurses/g" man/Makefile
 %endif
 
-export RPM_OPT_FLAGS=`echo $RPM_OPT_FLAGS | sed -e 's/i386/i486/'`
-
-make -j$(getconf _NPROCESSORS_ONLN) CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
+make -j$(getconf _NPROCESSORS_ONLN)
 
 %install
 make DESTDIR=$RPM_BUILD_ROOT install
-- 
1.7.7.6


--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
