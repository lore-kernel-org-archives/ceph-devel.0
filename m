From: Thomas Mueller <thomas@chaschperli.ch>
Subject: 4 new compiler warnings (ceph.git/unstable)
Date: Tue, 27 Jul 2010 19:53:27 +0000 (UTC)
Message-ID: <i2ndfm$ck$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58316 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab0G0Txq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Jul 2010 15:53:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OdqDe-0004oR-WE
	for ceph-devel@vger.kernel.org; Tue, 27 Jul 2010 21:53:43 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 21:53:42 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 21:53:42 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

there are new compiler warnings:

g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT Server.o -MD -MP -MF .de=
ps/Server.Tpo -c -o Server.o `test -f 'mds/Server.cc' || echo './'`mds/=
Server.cc
mv -f .deps/MDS.Tpo .deps/MDS.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT MDCache.o -MD -MP -MF .d=
eps/MDCache.Tpo -c -o MDCache.o `test -f 'mds/MDCache.cc' || echo './'`=
mds/MDCache.cc
mv -f .deps/Server.Tpo .deps/Server.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT Locker.o -MD -MP -MF .de=
ps/Locker.Tpo -c -o Locker.o `test -f 'mds/Locker.cc' || echo './'`mds/=
Locker.cc
=2E/include/encoding.h: In member function =E2=80=98void Locker::issue_=
client_lease(CDentry*, client_t, ceph::bufferlist&, utime_t, Session*)=E2=
=80=99:
 ./include/encoding.h:80: warning: =E2=80=98e.LeaseStat::duration_ms=E2=
=80=99 may be used uninitialized in this function

<snip>

mds/Locker.cc:2251: note: =E2=80=98e.LeaseStat::duration_ms=E2=80=99 wa=
s declared here

<snip>


=2E/include/encoding.h:80: warning: =E2=80=98e.LeaseStat::seq=E2=80=99 =
may be used uninitialized in this function

<snip>

mds/Locker.cc:2251: note: =E2=80=98e.LeaseStat::seq=E2=80=99 was declar=
ed here
 mv -f .deps/Locker.Tpo .deps/Locker.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT Migrator.o -MD -MP -MF .=
deps/Migrator.Tpo -c -o Migrator.o `test -f 'mds/Migrator.cc' || echo '=
=2E/'`mds/Migrator.cc
mv -f .deps/MDCache.Tpo .deps/MDCache.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT MDBalancer.o -MD -MP -MF=
 .deps/MDBalancer.Tpo -c -o MDBalancer.o `test -f 'mds/MDBalancer.cc' |=
| echo './'`mds/MDBalancer.cc
mv -f .deps/Migrator.Tpo .deps/Migrator.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT CDentry.o -MD -MP -MF .d=
eps/CDentry.Tpo -c -o CDentry.o `test -f

- Thomas

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
