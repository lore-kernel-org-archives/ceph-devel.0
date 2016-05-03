From: Ming Lin <minggr@gmail.com>
Subject: rocksdb related build error
Date: Tue, 3 May 2016 00:05:00 -0700
Message-ID: <CAF1ivSbg-n6o2_mHzCS_Y9rDZTD+ySess8TqOto-ox7MV012bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33526 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbcECHFC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 03:05:02 -0400
Received: by mail-vk0-f41.google.com with SMTP id o133so12918669vka.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 00:05:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

Hi John,

I got rocksdb related build error (commit bb7d9c15).
Any hint to fix it?

It's OK if I build in the ceph source tree.

mlin@ssi:~/ceph$ ./autogen.sh
...

mlin@ssi:~/ceph-build$ ../ceph/configure
...

mlin@ssi:~/ceph-build$ make -j8
...
make[3]: Entering directory `/home/mlin/ceph-build/src'
cd rocksdb && CC="gcc" CXX="g++" EXTRA_CXXFLAGS=-fPIC PORTABLE=1 make
-j8 static_lib
/bin/bash: line 0: cd: rocksdb: No such file or directory
make[3]: *** [rocksdb/librocksdb.a] Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: Leaving directory `/home/mlin/ceph-build/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/mlin/ceph-build/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/mlin/ceph-build/src'
make: *** [all-recursive] Error 1


mlin@ssi:~/ceph-build$ ls src/
acconfig.h  client      crush         java             kv
 log       mount     os        rbd_fuse    test
arch        cls         erasure-code  journal          librados
 Makefile  msg       osd       rbd_replay  tools
auth        common      global        json_spirit      libradosstriper
 mds       objclass  osdc      rgw         tracing
civetweb    compressor  gmock         key_value_store  librbd
 mon       ocf       perfglue  stamp-h1    xxHash
