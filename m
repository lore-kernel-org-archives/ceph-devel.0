From: Thomas Mueller <thomas@chaschperli.ch>
Subject: client-standalone/master-backport: "CEPH_VERSION" redefined
Date: Fri, 30 Jul 2010 08:47:58 +0000 (UTC)
Message-ID: <i2u3ju$hnt$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44542 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851Ab0G3IsK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jul 2010 04:48:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OelGB-0000or-8O
	for ceph-devel@vger.kernel.org; Fri, 30 Jul 2010 10:48:07 +0200
Received: from zux221-125-110.adsl.green.ch ([81.221.125.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 10:48:07 +0200
Received: from thomas by zux221-125-110.adsl.green.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 10:48:07 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

client-standalone/master-backport seems to be broken right now.

and the unstable-backport seems to be behind master-backport (missing d=
kms).
what is the worklfow in client-standalone - not unstable to master? whi=
ch=20
one should be used for testing?


# make
make -C /lib/modules/2.6.34/build M=3D/usr/src/ceph-client-standalone C=
ONFIG_CEPH_FS=3Dm modules
make[1]: Entering directory `/usr/src/redhat/BUILD/kernel-2.6.34'
  CC [M]  /usr/src/ceph-client-standalone/super.o
In file included from /usr/src/ceph-client-standalone/super.c:1087:
/usr/src/ceph-client-standalone/upstream_version.h:10:1: warning: "CEPH=
_VERSION" redefined
In file included from /usr/src/ceph-client-standalone/types.h:10,
                 from /usr/src/ceph-client-standalone/decode.h:7,
                 from /usr/src/ceph-client-standalone/super.c:17:
/usr/src/ceph-client-standalone/ceph_fs.h:29:1: warning: this is the lo=
cation of the previous definition
  CC [M]  /usr/src/ceph-client-standalone/inode.o
  CC [M]  /usr/src/ceph-client-standalone/dir.o
/usr/src/ceph-client-standalone/dir.c:1220: warning: initialization fro=
m incompatible pointer type
  CC [M]  /usr/src/ceph-client-standalone/file.o
/usr/src/ceph-client-standalone/file.c: In function =E2=80=98ceph_aio_w=
rite=E2=80=99:
/usr/src/ceph-client-standalone/file.c:847: warning: passing argument 2=
 of =E2=80=98vfs_fsync_range=E2=80=99 makes pointer from integer withou=
t a cast
/usr/src/ceph-client-standalone/file.c:847: error: too few arguments to=
 function =E2=80=98vfs_fsync_range=E2=80=99
/usr/src/ceph-client-standalone/file.c: At top level:
/usr/src/ceph-client-standalone/file.c:932: warning: initialization fro=
m incompatible pointer type
make[2]: *** [/usr/src/ceph-client-standalone/file.o] Error 1
make[1]: *** [_module_/usr/src/ceph-client-standalone] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.6.34'
make: *** [all] Error 2

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
