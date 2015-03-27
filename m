From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: tcmalloc issue
Date: Fri, 27 Mar 2015 15:37:35 +0100 (CET)
Message-ID: <250283338.1321814.1427467055129.JavaMail.zimbra@oxygem.tv>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com> <976582620.219210.1427440913479.JavaMail.zimbra@oxygem.tv> <9E914F5BD7F48A4782456CEB550A42281296767B@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47722 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbbC0Ohh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 10:37:37 -0400
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42281296767B@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>Ubuntu Package version info:=20
>>Package: libtcmalloc-minimal4=20
>>Versions:=20
>>2.1-2ubuntu1 (/var/lib/apt/lists/in.archive.ubuntu.com_ubuntu_dists_t=
rusty_main_binary-amd64_Packages)=20

Thanks !

looking at debian,
debian wheezy : libtcmalloc-minimal4 (2.0-2)

Seem to have the bug (I have looked inside debian src package)

debian jessie : libtcmalloc-minimal4 (2.2.1-0.2)
seem to be ok



>>we have not tested this on client nodes though - probably will help t=
here too.=20

I ask about client side, because from my debian client previous bench,=20
I have 4x more cpu on client librbd vs krbd, so maybe it's coming from =
libtcmalloc



----- Mail original -----
De: "Chaitanya Huilgol" <Chaitanya.Huilgol@sandisk.com>
=C3=80: "aderumier" <aderumier@odiso.com>, "Somnath Roy" <Somnath.Roy@s=
andisk.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Vendredi 27 Mars 2015 10:53:30
Objet: RE: tcmalloc issue

Hi,=20

Ubuntu Package version info:=20
Package: libtcmalloc-minimal4=20
Versions:=20
2.1-2ubuntu1 (/var/lib/apt/lists/in.archive.ubuntu.com_ubuntu_dists_tru=
sty_main_binary-amd64_Packages)=20

On the OSD, increasing the thread caches from the default 32M has defin=
itely helped,=20
we have not tested this on client nodes though - probably will help the=
re too.=20

As a temporary non-intrusive workaround with the existing libtcmalloc-m=
inimal4 library,=20
we are explicitly setting the thread cached values via rados-classes. (=
You can actually put this code into the OSD init path too) See patch be=
low.=20

Regards,=20
Chaitanya=20


=46rom cafdbd41bb3492209716516910fa3a0e856ac7b8 Mon Sep 17 00:00:00 200=
1=20
=46rom: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>=20
Date: Fri, 27 Mar 2015 15:16:35 +0530=20
Subject: [PATCH] Set tcmalloc thread cache via rados-class=20

Workaround for bug in tcmalloc (2.1-2ubuntu1)which does not use the exp=
orted=20
thread cache size value via environment variable. Using library init pa=
th=20
to explicitly set this value in tcmalloc. No actual object handlers are=
=20
registered and hence does not affect the data path.=20

Signed-off-by: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>=20
---=20
src/cls/Makefile.am | 5 ++++=20
src/cls/tcmalloc_env/tcmalloc_env.cc | 52 +++++++++++++++++++++++++++++=
+++++++=20
2 files changed, 57 insertions(+)=20
create mode 100644 src/cls/tcmalloc_env/tcmalloc_env.cc=20

diff --git a/src/cls/Makefile.am b/src/cls/Makefile.am=20
index ea44fe7..abcf007 100644=20
--- a/src/cls/Makefile.am=20
+++ b/src/cls/Makefile.am=20
@@ -5,6 +5,11 @@ libcls_hello_la_LIBADD =3D $(PTHREAD_LIBS) $(EXTRALIBS=
)=20
libcls_hello_la_LDFLAGS =3D ${AM_LDFLAGS} -module -avoid-version -share=
d -export-symbols-regex '.*__cls_.*'=20
radoslib_LTLIBRARIES +=3D libcls_hello.la=20

+libcls_tcmalloc_env_la_SOURCES =3D cls/tcmalloc_env/tcmalloc_env.cc=20
+libcls_tcmalloc_env_la_LIBADD =3D $(PTHREAD_LIBS) $(EXTRALIBS)=20
+libcls_tcmalloc_env_la_LDFLAGS =3D ${AM_LDFLAGS} -module -avoid-versio=
n -shared -export-symbols-regex '.*__cls_.*'=20
+radoslib_LTLIBRARIES +=3D libcls_tcmalloc_env.la=20
+=20
libcls_rbd_la_SOURCES =3D cls/rbd/cls_rbd.cc=20
libcls_rbd_la_LIBADD =3D $(PTHREAD_LIBS) $(EXTRALIBS)=20
libcls_rbd_la_LDFLAGS =3D ${AM_LDFLAGS} -module -avoid-version -shared =
-export-symbols-regex '.*__cls_.*'=20
diff --git a/src/cls/tcmalloc_env/tcmalloc_env.cc b/src/cls/tcmalloc_en=
v/tcmalloc_env.cc=20
new file mode 100644=20
index 0000000..0907183=20
--- /dev/null=20
+++ b/src/cls/tcmalloc_env/tcmalloc_env.cc=20
@@ -0,0 +1,52 @@=20
+/*=20
+ * rados-classes based plugin to set TCmalloc environment variable=20
+ * 'TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES' as the existing tcmalloc=20
+ * library in ubuntu 14.04 LTS and centos 7.0 has a bug which does=20
+ * not honor this env=20
+ */=20
+#include <cstdlib>=20
+#ifdef HAVE_GPERFTOOLS_HEAP_PROFILER_H=20
+#include <gperftools/heap-profiler.h>=20
+#else=20
+#include <google/heap-profiler.h>=20
+#endif=20
+=20
+#ifdef HAVE_GPERFTOOLS_MALLOC_EXTENSION_H=20
+#include <gperftools/malloc_extension.h>=20
+#else=20
+#include <google/malloc_extension.h>=20
+#endif=20
+#include "objclass/objclass.h"=20
+=20
+CLS_VER (1, 0) CLS_NAME (tcmalloc_env)=20
+#define DEFAULT_CACHE_SIZE (32 * 1024 * 1024)=20
+=20
+void=20
+__cls_init ()=20
+{=20
+ size_t result;=20
+ size_t cache_sz;=20
+ char *env_cache_sz_str;=20
+=20
+ CLS_LOG (0, "TCMALLOC-ENV: Search");=20
+ env_cache_sz_str =3D getenv ("TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES")=
;=20
+ if (env_cache_sz_str) {=20
+ cache_sz =3D strtoul (env_cache_sz_str, NULL, 0);=20
+ CLS_LOG(0, "TCMALLOC-ENV: Found: %lu\n", cache_sz);=20
+ if (cache_sz > DEFAULT_CACHE_SIZE) {=20
+ MallocExtension::instance ()->=20
+ SetNumericProperty ("tcmalloc.max_total_thread_cache_bytes", cache_sz=
);=20
+ result =3D 0;=20
+ MallocExtension::instance ()->=20
+ GetNumericProperty ("tcmalloc.max_total_thread_cache_bytes", &result)=
;=20
+ CLS_LOG (0, "TCMALLOC-ENV:Verify: max_total_thread_cache_bytes=3D%lu\=
n",=20
+ (unsigned long) result);=20
+ } else {=20
+ CLS_LOG (0, "TCMALLOC-ENV: Exported CacheSz=3D%lu <=3D Default=3D%lu =
- Ignored\n",=20
+ (unsigned long) cache_sz, (unsigned long) DEFAULT_CACHE_SIZE);=20
+ }=20
+ } else {=20
+ CLS_LOG(0, "TCMALLOC-ENV: Not Found\n");=20
+ }=20
+}=20
+/* EOF */=20
--=20
1.9.1=20

----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER=20
Sent: Friday, March 27, 2015 12:52 PM=20
To: Somnath Roy=20
Cc: ceph-devel=20
Subject: Re: tcmalloc issue=20

Hi Sommath,=20

is it only on osds ?=20

or also clients ?=20

What is the tmalloc version on ubuntu ? (I would like to known if the p=
roblem exist also on debian)=20

Regards,=20

Alexandre=20
----- Mail original -----=20
De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Vendredi 27 Mars 2015 00:18:57=20
Objet: tcmalloc issue=20

Sage,=20
Here is the tcmalloc issue I was talking in the performance meeting.=20

http://code.google.com/p/gperftools/issues/detail?id=3D585=20

The tcmalloc is consuming lot of cpus (and eventually slowing down the =
performance) with the following perf top trace.=20

25.73% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::FetchFromSpa=
ns()=20
12.52% libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentral=
Cache(tcmalloc::ThreadCache::FreeList*, unsigned long, int) 11.62% libt=
cmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseToSpans(void*)=20
1.56% [kernel] [k] __copy_user_nocache=20
1.44% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::RemoveRange(v=
oid*, void*, int) 1.39% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeL=
ist::ReleaseListToSpans(void*)=20
0.89% libtcmalloc.so.4.1.2 [.] operator new(unsigned long)=20


The TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is alleviating that but the e=
nv variable setting for this is a noop in the binary we are having in U=
buntu 14.04. It is fixed in gperftools-2.1.90 release.=20
See the following link.=20

http://code.google.com/p/gperftools/=20

We can request Ubuntu guys to incorporate this version or the latest tc=
malloc version which is gperftools-2.4.=20

It will be really helpful if you can push them to incorporate this in 1=
4.04 updates.=20

Thanks & Regards=20
Somnath=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
