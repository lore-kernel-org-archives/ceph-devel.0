From: Christian Brunner <chb@muc.de>
Subject: [PATCH] ceph.spec.in: avoid striping libcls_rbd.so
Date: Tue, 12 Oct 2010 23:36:01 +0200
Message-ID: <20101012213600.GA1989@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39131 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab0JLTd3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Oct 2010 15:33:29 -0400
Received: by bwz15 with SMTP id 15so2673400bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Oct 2010 12:33:28 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sage,

after setting up a new build system I ran into this, too. I've now
looked at this a bit closer and was able to find a workaround. A patch
for the spec file is attached.

Christian

2010/7/9 Sage Weil <sage@newdream.net>:
>
> There's one other pitfall I ran into with the debs... by default symb=
ols
> are stripped from all binaries, but the libcls_rbd.so shared object n=
eeds
> to _not_ be stripped, or else the class loading doesn't work. =A0I ha=
ve no
> idea where/when/if this is done during the rpmbuild. =A0The version i=
n the
> built package should look like so:
>
> $ nm .libs/libcls_rbd.so
> 000000000000797d T __cls_init
> 000000000020ce50 D __cls_name
> 000000000020ce7c B __cls_name__rbd
> 000000000020ce78 B __cls_ver__1_1
> 000000000020ce48 D __cls_ver_maj
> 000000000020ce4c D __cls_ver_min


---
 ceph.spec.in |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index c92ff9d..ab91f7b 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -75,6 +75,11 @@ mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/ceph/t=
mp/
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/ceph/
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/ceph/stat
=20
+# To avoid that libcls_rbd.so.1.0.0 is beeing stiped by find-debuginfo=
=2Esh
+# we petend that the debug symbols have already been extracted
+mkdir -p $RPM_BUILD_ROOT/usr/lib/debug/%{_libdir}/rados-classes/
+touch $RPM_BUILD_ROOT/usr/lib/debug/%{_libdir}/rados-classes/libcls_rb=
d.so.1.0.0.debug
+
 %clean
 rm -rf $RPM_BUILD_ROOT
=20
--=20
1.7.1


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
