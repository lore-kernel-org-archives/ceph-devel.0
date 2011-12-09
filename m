From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Build fails on Fedora 14 on linking librados-config
Date: Fri, 09 Dec 2011 16:17:47 +0100
Message-ID: <1494963.dggp1jPvU4@pc10>
References: <220547841.g14m0M3JMV@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:39187 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab1LIPRx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Dec 2011 10:17:53 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 37ECB10C866
	for <ceph-devel@vger.kernel.org>; Fri,  9 Dec 2011 16:17:52 +0100 (CET)
In-Reply-To: <220547841.g14m0M3JMV@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Mittwoch, 7. Dezember 2011, 16:19:24 schrieben Sie:
> Hi,
> 
> When building ceph 0.39 on Fedora 14, the build process fails with the
> following messages:
> 
>   CXXLD  librados-config
> /usr/bin/ld: ./.libs/libglobal.a(libcommon_la-HeartbeatMap.o): undefined
> reference to symbol 'pthread_rwlock_wrlock@@GLIBC_2.2.5'
> /usr/bin/ld: note: 'pthread_rwlock_wrlock@@GLIBC_2.2.5' is defined in DSO
> /lib64/libpthread.so.0 so try adding it to the linker command line
> /lib64/libpthread.so.0: could not read symbols: Invalid operation
> collect2: ld returned 1 exit status
> make[3]: *** [librados-config] Error 1

I filed a bug under http://tracker.newdream.net/issues/1797

It turns out compiling works if you call configure with

LIBS="-lpthread" ./configure

	Guido
