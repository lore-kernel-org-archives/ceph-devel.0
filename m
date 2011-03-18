From: Steena Monteiro <steena.m@aggiemail.usu.edu>
Subject: Building the Ceph client on Lucid Lynx
Date: Fri, 18 Mar 2011 22:23:37 +0000 (UTC)
Message-ID: <loom.20110318T232227-447@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47236 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932616Ab1CRWaJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Mar 2011 18:30:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q0iBI-0008Bg-Sn
	for ceph-devel@vger.kernel.org; Fri, 18 Mar 2011 23:30:05 +0100
Received: from 129.123.7.74 ([129.123.7.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2011 23:30:04 +0100
Received: from steena.m by 129.123.7.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2011 23:30:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to build the Ceph client on Ubuntu 10.04.2 with kernel
2.6.32-28-generic.  make -C install gives:

make: Entering directory `/usr/src/ceph-client-standalone/ceph'
make -C /lib/modules/2.6.32-28-generic/build
M=3D/usr/src/ceph-client-standalone/ceph CONFIG_CEPH_FS=3Dm modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.32-28-generic'
  CC [M]  /usr/src/ceph-client-standalone/ceph/super.o
/usr/src/ceph-client-standalone/ceph/super.c:585: warning: initializati=
on from
incompatible pointer type
/usr/src/ceph-client-standalone/ceph/super.c:870: error: unknown field =
=E2=80=98mount=E2=80=99
specified in initializer
/usr/src/ceph-client-standalone/ceph/super.c:870: warning: initializati=
on makes
integer from pointer without a cast
make[2]: *** [/usr/src/ceph-client-standalone/ceph/super.o] Error 1
make[1]: *** [_module_/usr/src/ceph-client-standalone/ceph] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-28-generic'
make: *** [all] Error 2
make: Leaving directory `/usr/src/ceph-client-standalone/ceph'

I'd appreciate some insight into solving this.

Thanks in advance,
Steena


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
