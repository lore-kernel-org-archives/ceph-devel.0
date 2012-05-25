From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Problem building RPM from spec file
Date: Fri, 25 May 2012 16:07:17 +0200
Message-ID: <2244126.L98NqaTFBF@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:60819 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab2EYOHW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 May 2012 10:07:22 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 49E2610C866
	for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 16:07:21 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I keep having problems getting ceph built as an RPM. Now the install phase 
fails with these messages:

 /usr/bin/install -c -m 644 ceph-osd.8 ceph-mds.8 ceph-mon.8 mkcephfs.8 ceph-
fuse.8 ceph-syn.8 crushtool.8 osdmaptool.8 monmaptool.8 ceph-conf.8 ceph-run.8 
ceph.8 mount.ceph.8 radosgw.8 radosgw-admin.8 ceph-authtool.8 rados.8 
librados-config.8 rbd.8 ceph-clsinfo.8 ceph-debugpack.8 cephfs.8 ceph-
dencoder.8 ceph-rbdnamer.8 
'/home/guido/rpmbuild/BUILDROOT/ceph-0.47.2-6.fc16.x86_64/usr/share/man/man8'
make[2]: Leaving directory `/home/guido/rpmbuild/BUILD/ceph-0.47.2/man'
make[1]: Leaving directory `/home/guido/rpmbuild/BUILD/ceph-0.47.2/man'
+ rmdir /home/guido/rpmbuild/BUILDROOT/ceph-0.47.2-6.fc16.x86_64/bin
rmdir: failed to remove 
`/home/guido/rpmbuild/BUILDROOT/ceph-0.47.2-6.fc16.x86_64/bin': No such file 
or directory
error: Bad exit status from /var/tmp/rpm-tmp.VEjzUO (%install)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.VEjzUO (%install)

I managed to get it to build after all with this:

--- ceph.spec.old       2012-05-25 16:03:37.763942616 +0200
+++ ceph.spec   2012-05-25 15:54:17.016000363 +0200
@@ -233,9 +233,9 @@
 
 %install
 make DESTDIR=$RPM_BUILD_ROOT install
-rmdir $RPM_BUILD_ROOT/bin
-rmdir $RPM_BUILD_ROOT/lib
-rmdir $RPM_BUILD_ROOT/include
+test -d $RPM_BUILD_ROOT/bin && rmdir $RPM_BUILD_ROOT/bin
+test -d $RPM_BUILD_ROOT/lib && rmdir $RPM_BUILD_ROOT/lib
+test -d $RPM_BUILD_ROOT/include && rmdir $RPM_BUILD_ROOT/include
 find $RPM_BUILD_ROOT -type f -name "*.la" -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name "*.a" -exec rm -f {} ';'
 install -D src/init-ceph $RPM_BUILD_ROOT%{_initrddir}/ceph

, but I don't understand the situation enough to say whether or not this is 
really an appropriate solution.

This is on a fresh Fedora 16 minimal install, by the way.

Regards,
	Guido

