From: GabrieleB <gabriele.bozzi@kaukana.be>
Subject: ceph messenger compile error on old backport (2.6.32)
Date: Sat, 19 Feb 2011 13:34:47 +0000 (UTC)
Message-ID: <loom.20110219T141159-409@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41819 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517Ab1BSNkJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 19 Feb 2011 08:40:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Pqn2c-0003Iu-Mv
	for ceph-devel@vger.kernel.org; Sat, 19 Feb 2011 14:40:06 +0100
Received: from 89.235-240-81.adsl-dyn.isp.belgacom.be ([81.240.235.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Feb 2011 14:40:06 +0100
Received: from gabriele.bozzi by 89.235-240-81.adsl-dyn.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Feb 2011 14:40:06 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Apologizes if this is not relevant.

I tried to compile Ceph client against a Lucid Ubuntu (Ubuntu 2.6.32-24=
-server),
the master backport does not compile complaining for a missing definiti=
on of
WQ_NON_REENTRANT.
Not an expert of Kernel workqueues but I understand that this mechanism=
 was
introduced in a post subversion of current Ubuntu stable.
Am I wrong assuming that the backport should not use Concurrency-manage=
d
workqueues? Is there a workaround for this?

Again, sorry if this is not relevant.=20

Dump of the error:

make -C libceph
make: Entering directory `/home/gabriele/ceph-client-standalone/libceph=
'
make -C /lib/modules/2.6.32-24-server/build
M=3D/home/gabriele/ceph-client-standalone/libceph CONFIG_CEPH_LIB=3Dm m=
odules
make[1]: Entering directory `/usr/src/linux-headers-2.6.32-24-server'
  CC [M]  /home/gabriele/ceph-client-standalone/libceph/messenger.o
/home/gabriele/ceph-client-standalone/libceph/messenger.c: In function
=E2=80=98ceph_msgr_init=E2=80=99:
/home/gabriele/ceph-client-standalone/libceph/messenger.c:99: error: im=
plicit
declaration of function =E2=80=98alloc_workqueue=E2=80=99
/home/gabriele/ceph-client-standalone/libceph/messenger.c:99: error:
=E2=80=98WQ_NON_REENTRANT=E2=80=99 undeclared (first use in this functi=
on)
/home/gabriele/ceph-client-standalone/libceph/messenger.c:99: error: (E=
ach
undeclared identifier is reported only once
/home/gabriele/ceph-client-standalone/libceph/messenger.c:99: error: fo=
r each
function it appears in.)
make[2]: *** [/home/gabriele/ceph-client-standalone/libceph/messenger.o=
] Error 1
make[1]: *** [_module_/home/gabriele/ceph-client-standalone/libceph] Er=
ror 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-24-server'
make: *** [all] Error 2
make: Leaving directory `/home/gabriele/ceph-client-standalone/libceph'

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
