From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Package build from master busted on Ubuntu Vivid
Date: Sat, 16 May 2015 19:53:02 +1200
Message-ID: <5556F75E.5040101@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:48639 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626AbbEPHxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 May 2015 03:53:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id E4C0132B49
	for <ceph-devel@vger.kernel.org>; Sat, 16 May 2015 19:53:04 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EDPzzXTATBij for <ceph-devel@vger.kernel.org>;
	Sat, 16 May 2015 19:53:02 +1200 (NZST)
Received: from [192.168.1.64] (125-237-67-100.jetstream.xtra.co.nz [125.237.67.100])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id B9BDA322B4
	for <ceph-devel@vger.kernel.org>; Sat, 16 May 2015 19:53:02 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

While a standard build (configure, make etc) on $platform works fine, 
attempting to build packages gets:

$ dpkg-buildpackage -j4
dpkg-buildpackage: source package ceph
dpkg-buildpackage: source version 9.0.0-1
dpkg-buildpackage: source distribution stable
dpkg-buildpackage: source changed by Alfredo Deza <adeza@redhat.com>
dpkg-buildpackage: host architecture amd64
  dpkg-source --before-build ceph
  fakeroot debian/rules clean
dh_testdir
dh_testroot
rm -f build-stamp configure-stamp
[ ! -f Makefile ] || /usr/bin/make distclean
make[1]: Entering directory '/home/markir/develop/c/ceph'
Making distclean in .
make[2]: Entering directory '/home/markir/develop/c/ceph'
rm -rf .libs _libs
rm -f *.lo
test -z "ceph.spec" || rm -f ceph.spec
rm -f libtool config.lt
rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
test . = "." || test -z "" || rm -f
rm -f cscope.out cscope.in.out cscope.po.out cscope.files
make[2]: Leaving directory '/home/markir/develop/c/ceph'
Making distclean in src
make[2]: Entering directory '/home/markir/develop/c/ceph/src'
Making distclean in gmock
make[3]: Entering directory '/home/markir/develop/c/ceph/src/gmock'
make[3]: *** No rule to make target 'distclean'.  Stop.
make[3]: Leaving directory '/home/markir/develop/c/ceph/src/gmock'
Makefile:21632: recipe for target 'distclean-recursive' failed
make[2]: *** [distclean-recursive] Error 1
make[2]: Leaving directory '/home/markir/develop/c/ceph/src'
Makefile:469: recipe for target 'distclean-recursive' failed
make[1]: *** [distclean-recursive] Error 1
make[1]: Leaving directory '/home/markir/develop/c/ceph'
debian/rules:62: recipe for target 'clean' failed
make: *** [clean] Error 2
dpkg-buildpackage: error: fakeroot debian/rules clean gave error exit 
status 2
