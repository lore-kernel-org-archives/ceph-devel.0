From: charles L <charlesboy009@hotmail.com>
Subject: /usr/bin/ld: cannot find -lboost_program_options
Date: Mon, 2 Dec 2013 02:57:34 +0100
Message-ID: <DUB116-W1392EBBBE3792703D625FEFE0EA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub0-omc4-s24.dub0.hotmail.com ([157.55.2.99]:31927 "EHLO
	dub0-omc4-s24.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752508Ab3LBB5f convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 1 Dec 2013 20:57:35 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Pls can some1 help? Im compiling ceph...i did the make -j2 command and =
got this "cannot find -lboost_program_options" many times ..so i tried =
to run make in verbose mode...and =A0got this...

root@ubuntuserver:/home/ceph# V=3D1 make
Making all in .
make[1]: Entering directory `/home/ceph'
make[1]: Nothing to be done for `all-am'.
make[1]: Leaving directory `/home/ceph'
Making all in src
make[1]: Entering directory `/home/ceph/src'
make =A0all-recursive
make[2]: Entering directory `/home/ceph/src'
Making all in ocf
make[3]: Entering directory `/home/ceph/src/ocf'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory `/home/ceph/src/ocf'
Making all in java
make[3]: Entering directory `/home/ceph/src/java'
make =A0all-am
make[4]: Entering directory `/home/ceph/src/java'
make[4]: Nothing to be done for `all-am'.
make[4]: Leaving directory `/home/ceph/src/java'
make[3]: Leaving directory `/home/ceph/src/java'
make[3]: Entering directory `/home/ceph/src'
=2E/check_version ./.git_version
=2E/.git_version is up to date.
/bin/bash ../libtool =A0--tag=3DCXX =A0 --mode=3Dlink g++ -Wall -Wtype-=
limits -Wignored-qualifiers -Winit-self -Wpointer-arith -Werror=3Dforma=
t-security -fno-strict-aliasing -fsigned-char -rdynamic -Wnon-virtual-d=
tor -Wno-invalid-offsetof =A0 -fno-builtin-malloc -fno-builtin-calloc -=
fno-builtin-realloc -fno-builtin-free -Wstrict-null-sentinel -g -Wl,--a=
s-needed -latomic_ops =A0-o ceph_filestore_tool tools/ceph-filestore-to=
ol.o libosd.la libosdc.la libos.la -laio =A0-lleveldb -lsnappy libperfg=
lue.la -ltcmalloc libos.la -laio =A0-lleveldb -lsnappy libglobal.la -lp=
thread -lm -lcrypto++ =A0 -luuid -lm -lkeyutils =A0-lrt =A0 -lboost_pro=
gram_options -ldl -lboost_thread -lboost_system -lleveldb -lsnappy
libtool: link: g++ -Wall -Wtype-limits -Wignored-qualifiers -Winit-self=
 -Wpointer-arith -Werror=3Dformat-security -fno-strict-aliasing -fsigne=
d-char -rdynamic -Wnon-virtual-dtor -Wno-invalid-offsetof -fno-builtin-=
malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free -Wstr=
ict-null-sentinel -g -Wl,--as-needed -o ceph_filestore_tool tools/ceph-=
filestore-tool.o =A0/usr/lib/libatomic_ops.a ./.libs/libosd.a ./.libs/l=
ibosdc.a ./.libs/libperfglue.a -ltcmalloc ./.libs/libos.a -laio ./.libs=
/libglobal.a -lpthread -lcrypto++ -luuid -lm -lkeyutils -lrt -lboost_pr=
ogram_options -ldl -lboost_thread -lboost_system -lleveldb -lsnappy
/usr/bin/ld: cannot find -lboost_program_options
collect2: error: ld returned 1 exit status
make[3]: *** [ceph_filestore_tool] Error 1
make[3]: Leaving directory `/home/ceph/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/ceph/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/ceph/src'
make: *** [all-recursive] Error 1 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
