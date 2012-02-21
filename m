From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: v0.42 not compiling .deb's (but v0.41 can)
Date: Tue, 21 Feb 2012 18:05:37 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407E36DF7D7@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf1.mach.net.au ([115.165.169.19]:57842 "EHLO mf1.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab2BUI0F convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 03:26:05 -0500
Received: from exch12.ad.mach.net.au (unknown [10.64.255.16])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mf1.mach.net.au (Postfix) with ESMTP id 9C653287F6
	for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 18:05:38 +1000 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

G'day all

Looking forward to upgrading our Ceph cluster from v0.41 to v0.42, started to compile the .deb packages per the procedure below (see end of email).

However, the same server (Ubuntu 12.04 x64) that successfully produced v0.41 is giving the below now with v0.42:
...
libtool: install: /usr/bin/install -c .libs/librados.lai /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librados.la
libtool: install: warning: relinking `librgw.la'
libtool: install: (cd /usr/src/ceph/git-ceph_v0.42/v0.42/src; /bin/bash /usr/src/ceph/git-ceph_v0.42/v0.42/libtool  --silent --tag CXX --mode=relink g++ -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE -rdynamic -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith -fno-strict-aliasing -DCEPH_LIBDIR=\"/usr/lib\" -Wnon-virtual-dtor -Wno-invalid-offsetof -Wstrict-null-sentinel -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -version-info 1:0:0 -lpthread -lm -lcrypto++ -luuid -lrt -lexpat -lcurl -Wl,-Bsymbolic-functions -Wl,-z,relro -o librgw.la -rpath /usr/lib librgw_la-librgw.lo librgw_la-rgw_acl.lo librgw_la-rgw_xml.lo librados.la -inst-prefix-dir /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp)
./.libs/librgw.so: file not recognized: File truncated
collect2: ld returned 1 exit status
make[5]: *** [radosgw-admin] Error 1
make[5]: *** Waiting for unfinished jobs....
./.libs/librgw.so: file not recognized: File format not recognized
collect2: ld returned 1 exit status
make[5]: *** [radosgw] Error 1
libtool: install: /usr/bin/install -c .libs/librgw.so.1.0.0T /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librgw.so.1.0.0
libtool: install: (cd /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib && { ln -s -f librgw.so.1.0.0 librgw.so.1 || { rm -f librgw.so.1 && ln -s librgw.so.1.0.0 librgw.so.1; }; })
libtool: install: (cd /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib && { ln -s -f librgw.so.1.0.0 librgw.so || { rm -f librgw.so && ln -s librgw.so.1.0.0 librgw.so; }; })
libtool: install: /usr/bin/install -c .libs/librgw.lai /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librgw.la
libtool: install: warning: relinking `librbd.la'
...
libtool: install: chmod 644 /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librgw.a
libtool: install: ranlib /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librgw.a
libtool: install: /usr/bin/install -c .libs/librbd.a /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librbd.a
libtool: install: chmod 644 /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librbd.a
libtool: install: ranlib /usr/src/ceph/git-ceph_v0.42/v0.42/debian/tmp/usr/lib/librbd.a
libtool: install: warning: remember to run `libtool --finish /usr/lib'
make[5]: Leaving directory `/usr/src/ceph/git-ceph_v0.42/v0.42/src'
make[4]: *** [install-am] Error 2
make[4]: Leaving directory `/usr/src/ceph/git-ceph_v0.42/v0.42/src'
make[3]: *** [install-recursive] Error 1
make[3]: Leaving directory `/usr/src/ceph/git-ceph_v0.42/v0.42/src'
make[2]: *** [install] Error 2
make[2]: Leaving directory `/usr/src/ceph/git-ceph_v0.42/v0.42/src'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/usr/src/ceph/git-ceph_v0.42/v0.42'
make: *** [install] Error 2
dpkg-buildpackage: error: debian/rules binary gave error exit status 2


Any advice on what the issue is and how to resolve?

Cheers

Paul



mkdir -p /usr/src/ceph/git-ceph_v0.42
cd /usr/src/ceph/git-ceph_v0.42
wget https://github.com/NewDreamNetwork/ceph/tarball/v0.42
tar xf v0.42
rm v0.42
mv NewDreamNetwork-ceph-311dd19/ v0.42
cd /usr/src/ceph/git-ceph_v0.42/v0.42
dpkg-buildpackage -j16
<<<ERROR FAILURE HERE PER ABOVE OUTPUT EXTRACT
When the building finishes (~8min), there should be .deb files in the parent directory
cd ../
ls -alh *.deb


