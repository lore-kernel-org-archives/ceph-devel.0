From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Package build from master busted on Ubuntu Vivid
Date: Thu, 21 May 2015 17:03:52 +1200
Message-ID: <555D6738.40808@catalyst.net.nz>
References: <5556F75E.5040101@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:37558 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbbEUFEG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 01:04:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id F18C432B57
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 17:04:01 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sK1JzC-c1TKW for <ceph-devel@vger.kernel.org>;
	Thu, 21 May 2015 17:03:56 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:e167:fb78:fb72:27a3] (unknown [IPv6:2404:130:0:1000:e167:fb78:fb72:27a3])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id A39D332C5C
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 17:03:52 +1200 (NZST)
In-Reply-To: <5556F75E.5040101@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 16/05/15 19:53, Mark Kirkwood wrote:
> Hi,
> 
> While a standard build (configure, make etc) on $platform works fine,
> attempting to build packages gets:
> 
> $ dpkg-buildpackage -j4
> dpkg-buildpackage: source package ceph
> dpkg-buildpackage: source version 9.0.0-1
> dpkg-buildpackage: source distribution stable
> dpkg-buildpackage: source changed by Alfredo Deza <adeza@redhat.com>
> dpkg-buildpackage: host architecture amd64
>  dpkg-source --before-build ceph
>  fakeroot debian/rules clean
> dh_testdir
> dh_testroot
> rm -f build-stamp configure-stamp
> [ ! -f Makefile ] || /usr/bin/make distclean
> make[1]: Entering directory '/home/markir/develop/c/ceph'
> Making distclean in .
> make[2]: Entering directory '/home/markir/develop/c/ceph'
> rm -rf .libs _libs
> rm -f *.lo
> test -z "ceph.spec" || rm -f ceph.spec
> rm -f libtool config.lt
> rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
> test . = "." || test -z "" || rm -f
> rm -f cscope.out cscope.in.out cscope.po.out cscope.files
> make[2]: Leaving directory '/home/markir/develop/c/ceph'
> Making distclean in src
> make[2]: Entering directory '/home/markir/develop/c/ceph/src'
> Making distclean in gmock
> make[3]: Entering directory '/home/markir/develop/c/ceph/src/gmock'
> make[3]: *** No rule to make target 'distclean'.  Stop.
> make[3]: Leaving directory '/home/markir/develop/c/ceph/src/gmock'
> Makefile:21632: recipe for target 'distclean-recursive' failed
> make[2]: *** [distclean-recursive] Error 1
> make[2]: Leaving directory '/home/markir/develop/c/ceph/src'
> Makefile:469: recipe for target 'distclean-recursive' failed
> make[1]: *** [distclean-recursive] Error 1
> make[1]: Leaving directory '/home/markir/develop/c/ceph'
> debian/rules:62: recipe for target 'clean' failed
> make: *** [clean] Error 2
> dpkg-buildpackage: error: fakeroot debian/rules clean gave error exit
> status 2
> -- 


Actually, looking a bit closer that the issue is with 'make distclean'
in master [1], not the package build at all (it only occurred then
because I had performed a standard make previously). Also nothing
particular to vivid either.

Regards

Mark

[1] ... has been noted on this list.

