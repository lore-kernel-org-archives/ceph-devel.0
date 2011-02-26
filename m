From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: building Ceph on various architectures
Date: Sat, 26 Feb 2011 12:41:18 +0100
Message-ID: <1298720478.16174.14.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:58684 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab1BZLsV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 26 Feb 2011 06:48:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.routers.hu (Postfix) with ESMTP id D5E84153968
	for <ceph-devel@vger.kernel.org>; Sat, 26 Feb 2011 13:05:01 +0100 (CET)
Received: from mail.routers.hu ([127.0.0.1])
	by localhost (sum.routers.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6pDa+3Qyz3s0 for <ceph-devel@vger.kernel.org>;
	Sat, 26 Feb 2011 13:05:01 +0100 (CET)
Received: from [192.168.0.100] (kabelnet-248-67.parisat.hu [91.147.248.67])
	by mail.routers.hu (Postfix) with ESMTPA id B4A84153964
	for <ceph-devel@vger.kernel.org>; Sat, 26 Feb 2011 13:05:01 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

Being the Debian packager of Ceph, I ask for help about building 0.24.3
on armel. It fails with:
g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64
-D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT AuthAuthorizeHandler.o
-MD -MP -MF .deps/AuthAuthorizeHandler.Tpo -c -o AuthAuthorizeHandler.o
`test -f 'auth/AuthAuthorizeHandler.cc' || echo
'./'`auth/AuthAuthorizeHandler.cc
In file included from ./include/buffer.h:55,
                 from ./include/encoding.h:20,
                 from ./include/object.h:29,
                 from ./include/types.h:64,
                 from auth/Crypto.h:17,
                 from auth/Auth.h:18,
                 from auth/AuthAuthorizeHandler.cc:1:
./include/atomic.h: In member function 'void ceph::atomic_t::inc()':
./include/atomic.h:33: error: 'AO_fetch_and_add1' was not declared in this scope
./include/atomic.h: In member function 'size_t ceph::atomic_t::dec()':
./include/atomic.h:36: error: 'AO_fetch_and_sub1_write' was not declared in this scope
./include/atomic.h: In member function 'void ceph::atomic_t::add(size_t)':
./include/atomic.h:39: error: 'AO_fetch_and_add' was not declared in this scope
./include/atomic.h: In member function 'void ceph::atomic_t::sub(int)':
./include/atomic.h:43: error: 'AO_fetch_and_add_write' was not declared in this scope
make[3]: *** [AuthAuthorizeHandler.o] Error 1

You can read the full build log on the web[1].

It also fails on s390, on the same file but with a different error
message:
g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT AuthAuthorizeHandler.o -MD -MP -MF .deps/AuthAuthorizeHandler.Tpo -c -o AuthAuthorizeHandler.o `test -f 'auth/AuthAuthorizeHandler.cc' || echo './'`auth/AuthAuthorizeHandler.cc
In file included from ./msg/msg_types.h:19,
                 from auth/Auth.h:19,
                 from auth/AuthAuthorizeHandler.cc:1:
./include/blobhash.h: In member function 'size_t blobhash::operator()(const char*, unsigned int)':
./include/blobhash.h:42: error: no match for call to '(rjhash<long unsigned int>) (size_t&)'
make[3]: *** [AuthAuthorizeHandler.o] Error 1

The full building log can be found on the same location[2]. I would be
grateful if someone with more knowledge of Ceph internals can look into
them.

Regards,
Laszlo/GCS
[1] https://buildd.debian.org/fetch.cgi?pkg=ceph&arch=armel&ver=0.24.3-2&stamp=1298712439&file=log&as=raw
[2] https://buildd.debian.org/fetch.cgi?pkg=ceph&arch=s390&ver=0.24.3-2&stamp=1298712185&file=log&as=raw

