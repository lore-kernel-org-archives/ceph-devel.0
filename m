From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Ceph master - build broken unless --enable-debug specified
Date: Sun, 12 Apr 2015 15:42:52 +1200
Message-ID: <5529E9BC.2090203@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:34519 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbbDLDm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Apr 2015 23:42:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id EA1BE33269
	for <ceph-devel@vger.kernel.org>; Sun, 12 Apr 2015 15:42:53 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id heLVv1nB31FY for <ceph-devel@vger.kernel.org>;
	Sun, 12 Apr 2015 15:42:53 +1200 (NZST)
Received: from [192.168.1.64] (122-60-153-193.jetstream.xtra.co.nz [122.60.153.193])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 1B82A32C1D
	for <ceph-devel@vger.kernel.org>; Sun, 12 Apr 2015 15:42:53 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Building without --enable-debug produces:

ceph_fuse.cc: In member function =E2=80=98virtual void* main(int, const=
 char**,=20
const char**)::RemountTest::entry()=E2=80=99:
ceph_fuse.cc:146:15: warning: ignoring return value of =E2=80=98int sys=
tem(const=20
char*)=E2=80=99, declared with attribute warn_unused_result [-Wunused-r=
esult]
     system(buf);
                ^
   CXX      ceph_osd.o
   CXX      ceph_mds.o
make[3]: *** No rule to make target '../src/gmock/lib/libgmock_main.la'=
,=20
needed by 'unittest_librbd'.  Stop.
make[3]: *** Waiting for unfinished jobs....
   CXX      test/erasure-code/ceph_erasure_code_non_regression.o
make[3]: Leaving directory '/home/markir/develop/c/ceph/src'
Makefile:20716: recipe for target 'all-recursive' failed
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory '/home/markir/develop/c/ceph/src'
Makefile:8977: recipe for target 'all' failed
make[1]: *** [all] Error 2
make[1]: Leaving directory '/home/markir/develop/c/ceph/src'
Makefile:467: recipe for target 'all-recursive' failed
make: *** [all-recursive] Error 1


Adding in --enable-debug gives a successful build.

This is on Ubuntu 14.10 64 bit, and the build procedure is:

$ git pull
$ git submodule update --init
$ ./autogen.sh
$ ./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/va=
r \
               [--with-debug \ ]
               --with-nss \
               --with-radosgw \
               --with-librocksdb-static=3Dcheck \

$ make [ -j4 ]


Cheers

Mark
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
