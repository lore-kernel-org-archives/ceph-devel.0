From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH 0/4] ceph.spec.in: fixes and additions for the rpm spec file
Date: Fri, 24 Sep 2010 20:50:04 +0200
Message-ID: <AANLkTinG-3x8STo4kMgYjvNL1UZ8z3aCce0s9JX7OnhZ@mail.gmail.com>
References: <20100709091116.GB29300@bambus>
	<Pine.LNX.4.64.1007090939160.5826@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47367 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab0IXSuF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Sep 2010 14:50:05 -0400
Received: by yxp4 with SMTP id 4so1056870yxp.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Sep 2010 11:50:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1007090939160.5826@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

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

After setting up a new build system I ran into this, too. I've now
looked at this a bit closer and was able to find a workaround. A patch
for the spec file is attached.

Christian

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

+# To avoid that libcls_rbd.so.1.0.0 is being striped by find-debuginfo=
=2Esh
+# we pretend that the debug symbols have already been extracted
+mkdir -p $RPM_BUILD_ROOT/usr/lib/debug/%{_libdir}/rados-classes/
+touch $RPM_BUILD_ROOT/usr/lib/debug/%{_libdir}/rados-classes/libcls_rb=
d.so.1.0.0.debug
+
 %clean
 rm -rf $RPM_BUILD_ROOT

--
1.7.1
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
