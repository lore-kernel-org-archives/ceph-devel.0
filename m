From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] osd: nss build of OSD.cc needs CRYPTO_CXXFLAGS since
 commit d59f34ab
Date: Fri,  2 Sep 2011 14:50:45 -0600
Message-ID: <1314996645-19678-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:51073 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab1IBUvL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2011 16:51:11 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 166FC1897CF
	for <ceph-devel@vger.kernel.org>; Fri,  2 Sep 2011 14:51:08 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Fri, 2 Sep 2011 14:51:00 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

nss build fails like this:

if /bin/sh ../libtool --tag=CXX --mode=compile g++ -DHAVE_CONFIG_H -I. -I. -I.   -D__KERNEL_STRICT_NAMES -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE -rdynamic   -Winit-self -Wpointer-arith -fno-strict-aliasing -Wnon-virtual-dtor -Wno-invalid-offsetof -Wstrict-null-sentinel   -g -MT OSD.lo -MD -MP -MF ".deps/OSD.Tpo" -c -o OSD.lo `test -f 'osd/OSD.cc' || echo './'`osd/OSD.cc; \
        then mv -f ".deps/OSD.Tpo" ".deps/OSD.Plo"; else rm -f ".deps/OSD.Tpo"; exit 1; fi
 g++ -DHAVE_CONFIG_H -I. -I. -I. -D__KERNEL_STRICT_NAMES -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE -rdynamic -Winit-self -Wpointer-arith -fno-strict-aliasing -Wnon-virtual-dtor -Wno-invalid-offsetof -Wstrict-null-sentinel -g -MT OSD.lo -MD -MP -MF .deps/OSD.Tpo -c osd/OSD.cc  -fPIC -DPIC -o .libs/OSD.o
In file included from ./os/LFNIndex.h:27,
                 from ./os/HashIndex.h:20,
                 from ./os/FileStore.h:26,
                 from osd/OSD.cc:25:
./common/ceph_crypto.h:44:22: error: pk11pub.h: No such file or directory

Commit d59f34ab made FileStore.h include HashIndex.h, which ultimately
results in OSD.cc including ceph_crypto.h.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/Makefile.am |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index e53b68d..f3ca34b 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -928,6 +928,7 @@ libosd_la_SOURCES = \
 	osd/OSDCaps.cc \
 	osd/Watch.cc \
         osd/ClassHandler.cc
+libosd_la_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
 libosd_la_LIBADD = libglobal.la
 noinst_LTLIBRARIES += libosd.la
 
-- 
1.7.1


