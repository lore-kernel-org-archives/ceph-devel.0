From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Build fails on Fedora 14 on linking librados-config
Date: Wed, 07 Dec 2011 16:19:24 +0100
Message-ID: <220547841.g14m0M3JMV@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:54460 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064Ab1LGPT3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Dec 2011 10:19:29 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 7259610C866
	for <ceph-devel@vger.kernel.org>; Wed,  7 Dec 2011 16:19:28 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

When building ceph 0.39 on Fedora 14, the build process fails with the 
following messages:

  CXXLD  librados-config
/usr/bin/ld: ./.libs/libglobal.a(libcommon_la-HeartbeatMap.o): undefined 
reference to symbol 'pthread_rwlock_wrlock@@GLIBC_2.2.5'
/usr/bin/ld: note: 'pthread_rwlock_wrlock@@GLIBC_2.2.5' is defined in DSO 
/lib64/libpthread.so.0 so try adding it to the linker command line
/lib64/libpthread.so.0: could not read symbols: Invalid operation
collect2: ld returned 1 exit status
make[3]: *** [librados-config] Error 1

	Guido
