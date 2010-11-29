From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] Re: [PATCH] ceph/rbd block driver for qemu-kvm
 (v8)
Date: Mon, 29 Nov 2010 11:47:34 -0800
Message-ID: <1291060054.1792.88.camel@yehudasa-desktop>
References: <20101117214223.GA31321@sir.home>
	 <AANLkTikLu0OJ3b+Ch7b0nnkOnF9wUGiUqZRcQgGeog73@mail.gmail.com>
	 <AANLkTikpvEQXc5iz-ii74XBshGrt0nNk5bCrHgteNXyA@mail.gmail.com>
	 <AANLkTimwfxz3D+MZQ7TH_DktMNzyN-=Q3AaZVsi+4rdO@mail.gmail.com>
	 <4CF36B79.4000008@redhat.com>  <4CF37A23.8010202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62006 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab0K2TsY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Nov 2010 14:48:24 -0500
In-Reply-To: <4CF37A23.8010202@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Christian Brunner <c.m.brunner@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Mon, 2010-11-29 at 11:02 +0100, Kevin Wolf wrote:
> Am 29.11.2010 09:59, schrieb Kevin Wolf:
> > Am 27.11.2010 08:12, schrieb Stefan Hajnoczi:
> >> On Fri, Nov 26, 2010 at 9:59 PM, Christian Brunner
> >> <c.m.brunner@gmail.com> wrote:
> >>> Thanks for the review. What am I supposed to do now?
> >>
> >> Kevin is the block maintainer.  His review is the next step, I have
> >> CCed him.  After that rbd would be ready to merge.
> > 
> > If I don't find anything really obvious and it doesn't break the build,
> > I'll merge it based on your review.
> 
> Which librados version is this supposed to require? My F12 one seems to
> be too old, however configure still automatically enables it (so the
> build fails in the default configuration for me). I think you need to
> add some check there.
> 
> $ rpm -q ceph-devel
> ceph-devel-0.20.2-1.fc12.x86_64
> 
> $ LANG=C make
>   CC    block/rbd.o
> block/rbd.c: In function 'rbd_register_image':
> block/rbd.c:191: error: 'CEPH_OSD_TMAP_SET' undeclared (first use in
> this function)
> block/rbd.c:191: error: (Each undeclared identifier is reported only once
> block/rbd.c:191: error: for each function it appears in.)
> cc1: warnings being treated as errors
> block/rbd.c: In function 'rbd_set_snapc':
> block/rbd.c:468: error: implicit declaration of function
> 'rados_set_snap_context'
> block/rbd.c:468: error: nested extern declaration of
> 'rados_set_snap_context'
> block/rbd.c: In function 'rbd_snap_create':
> block/rbd.c:844: error: implicit declaration of function
> 'rados_selfmanaged_snap_create'
> block/rbd.c:844: error: nested extern declaration of
> 'rados_selfmanaged_snap_create'
> make: *** [block/rbd.o] Error 1
> 

Right. The CEPH_OSD_TMAP_SET can be fixed and in theory we can get it
compiled without snapshots, but we're not sure that it is really a good
idea at this point. The following patch disables rbd when librados is
too old.

Thanks,
Yehuda

--
From: Yehuda Sadeh <yehuda@hq.newdream.net>
Date: Mon, 29 Nov 2010 10:38:41 -0800
Subject: [PATCH 1/1] rbd: disable rbd in configure if librados is too old

This checks for the existence of the certain function and other
definition.

Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
---
 configure |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 5d8f620..18ae07c 100755
--- a/configure
+++ b/configure
@@ -1770,15 +1770,36 @@ int main(void) { rados_initialize(0, NULL); return 0; }
 EOF
   rbd_libs="-lrados -lcrypto"
   if compile_prog "" "$rbd_libs" ; then
-    rbd=yes
-    libs_tools="$rbd_libs $libs_tools"
-    libs_softmmu="$rbd_libs $libs_softmmu"
+    librados_too_old=no
+    cat > $TMPC <<EOF
+#include <stdio.h>
+#include <rados/librados.h>
+#ifndef CEPH_OSD_TMAP_SET
+#error missing CEPH_OSD_TMAP_SET
+#endif
+int main(void) {
+    int (*func)(const rados_pool_t pool, uint64_t *snapid) = rados_selfmanaged_snap_create;
+    rados_initialize(0, NULL);
+    return 0;
+}
+EOF
+    if compile_prog "" "$rbd_libs" ; then
+      rbd=yes
+      libs_tools="$rbd_libs $libs_tools"
+      libs_softmmu="$rbd_libs $libs_softmmu"
+    else
+      rbd=no
+      librados_too_old=yes
+    fi
   else
     if test "$rbd" = "yes" ; then
       feature_not_found "rados block device"
     fi
     rbd=no
   fi
+  if test "$librados_too_old" = "yes" ; then
+    echo "-> Your librados version is too old - upgrade needed to have rbd support"
+  fi
 fi
 
 ##########################################
-- 
1.5.6.5



