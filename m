From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: stripping of ceph class objects
Date: Fri, 17 Dec 2010 11:49:02 +0100
Message-ID: <1292582942.3920.273.camel@julia.gcs.org.hu>
References: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-m66f4DKKRxTiEaajP/T8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:60856 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683Ab0LQKtY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Dec 2010 05:49:24 -0500
In-Reply-To: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>


--=-m66f4DKKRxTiEaajP/T8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Yehuda,

On Thu, 2010-12-16 at 15:35 -0800, Yehuda Sadeh Weinraub wrote:
>  we just installed the latest ceph debian packages and it seems that
> the class objects (that are installed in /usr/lib/rados-classes/) are
> stripped. [...] Our regular
> automake resulted binaries keeps those symbols, but I guess that the
> debian packaging strips them.
 Indeed, the packaging stripped them. The attached patch fixes this
issue. Also ceph.lintian should be ceph.lintian-overrides .
I'm a bit confused, why ceph should depend explicitly on binutils? I may
understand libedit2 as ceph build depends on its -dev counterpart; but I
couldn't find a binary that is linked with it.

Sage, is it OK if I commit this patch?

Cheers,
Laszlo/GCS

--=-m66f4DKKRxTiEaajP/T8
Content-Disposition: attachment; filename="ceph-packaging.diff"
Content-Type: text/x-patch; name="ceph-packaging.diff"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/debian/ceph.lintian-overrides b/debian/ceph.lintian-overrides
index 6463e89..566fc33 100644
--- a/debian/ceph.lintian-overrides
+++ b/debian/ceph.lintian-overrides
@@ -1,4 +1,5 @@
 #
 # the rados classes should NOT be stripped.
 #
-ceph binary: unstripped-binary-or-object ./usr/lib/rados-classes/libcls_rbd.so.1.0.0
+ceph: unstripped-binary-or-object ./usr/lib/rados-classes/libcls_rbd.so.1.0.0
+
diff --git a/debian/control b/debian/control
index bc1247f..d3dc2bf 100644
--- a/debian/control
+++ b/debian/control
@@ -11,7 +11,7 @@ Standards-Version: 3.9.1
 
 Package: ceph
 Architecture: any
-Depends: ${shlibs:Depends}, ${misc:Depends}, libedit2, hdparm, binutils
+Depends: ${shlibs:Depends}, ${misc:Depends}, hdparm
 Recommends: ceph-client-tools, ceph-fuse, libceph1, librados1, libcrush1, btrfs-tools
 Description: distributed storage and file system
  Ceph is a distributed storage and network file system designed to provide
diff --git a/debian/rules b/debian/rules
index 5b99834..1941750 100755
--- a/debian/rules
+++ b/debian/rules
@@ -61,14 +61,13 @@ binary-arch: build install
 	dh_lintian
 	dh_link
 
-	dh_strip -pceph --dbg-package=ceph-dbg
+	dh_strip -pceph --dbg-package=ceph-dbg -k --exclude=libcls_
 	dh_strip -pceph-fuse --dbg-package=ceph-fuse-dbg
 	dh_strip -pceph-client-tools --dbg-package=ceph-client-tools-dbg
 	dh_strip -plibcrush1 --dbg-package=libcrush1-dbg
 	dh_strip -plibrados1 --dbg-package=librados1-dbg
 	dh_strip -plibceph1 --dbg-package=libceph1-dbg
 	dh_strip -pradosgw --dbg-package=radosgw-dbg
-#	dh_strip -k --exclude=libcls_
 
 	dh_compress
 	dh_fixperms

--=-m66f4DKKRxTiEaajP/T8--

