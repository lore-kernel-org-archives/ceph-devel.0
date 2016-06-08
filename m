From: Muminul Islam Russell <misla011@fiu.edu>
Subject: Jewel build for CentOS 6
Date: Tue, 7 Jun 2016 17:13:12 -0700
Message-ID: <CAK=B8ybVb0=Z7FM1LOPA-Dp1kGZjPn3nBbDg1hf+SkC50ir+Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35773 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbcFHANN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 20:13:13 -0400
Received: by mail-qk0-f171.google.com with SMTP id p22so50057797qka.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2016 17:13:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Cephers,

I was trying to build Jewel for Centos 6 for personal purpose. I fixed
couple of things and at the end I got the following error. Please let
me know if anyone have any idea how to fix this issue.

-------
writing... rbd-mirror.8 { } rbdmap.8 { } ceph-detect-init.8 { }
ceph-rest-api.8 { } osdmaptool.8 { } ceph-rbdnamer.8 { }
ceph-create-keys.8 { } ceph-disk.8 { } cephfs.8 { } ceph.8 { }
monmaptool.8 { } ceph-deploy.8 { } ceph-debugpack.8 { }
ceph-dencoder.8 { } rbd-nbd.8 { } mount.ceph.8 { } radosgw-admin.8 { }
ceph-fuse.8 { } ceph-authtool.8 { } ceph-run.8 { } librados-config.8 {
} ceph-clsinfo.8 { } ceph-post-file.8 { } ceph-mds.8 { } ceph-osd.8 {
} ceph-syn.8 { } crushtool.8 { } rbd-fuse.8 { } radosgw.8 { }
ceph-conf.8 { } ceph-mon.8 { } rados.8 { } rbd-replay-many.8 { }
rbd-replay-prep.8 { } rbd.8 { } rbd-replay.8 { }
build succeeded.
make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/man'
Making all in doc
make[1]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/doc'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/doc'
Making all in systemd
make[1]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/systemd'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/systemd'
Making all in selinux
make[1]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
make -j1 -f /usr/share/selinux/devel/Makefile ceph.pp
make[2]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
make[2]: warning: -jN forced in submake: disabling jobserver mode.
Compiling targeted ceph module
/usr/bin/checkmodule:  loading policy configuration from tmp/ceph.tmp
ceph.te":109:ERROR 'syntax error' at token 'fsadm_manage_pid' on line 15485:

fsadm_manage_pid(ceph_t)
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make[2]: *** [tmp/ceph.mod] Error 1
make[2]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
make[1]: *** [ceph.pp] Error 2
make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
make: *** [all-recursive] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.pInRWe (%build

--
Russell
