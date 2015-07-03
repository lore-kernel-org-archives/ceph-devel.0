From: Stefan Priebe <s.priebe@profihost.ag>
Subject: trying to compile with-jemalloc but ceph-osd is still linked to libtcmalloc
Date: Fri, 03 Jul 2015 11:15:11 +0200
Message-ID: <5596529F.8060709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:58975 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbGCJPF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jul 2015 05:15:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

i'm trying to compile current hammer with-jemalloc.

configure .. --without-tcmalloc --with-jemalloc

but resulting ceph-osd is still linked against tcmalloc:
ldd /usr/bin/ceph-osd
         linux-vdso.so.1 =>  (0x00007fffbf3b9000)
         libjemalloc.so.1 => /usr/lib/x86_64-linux-gnu/libjemalloc.so.1 
(0x00007fc44bc25000)
         libaio.so.1 => /lib/x86_64-linux-gnu/libaio.so.1 
(0x00007fc44ba23000)
         libleveldb.so.1 => /usr/lib/x86_64-linux-gnu/libleveldb.so.1 
(0x00007fc44b7d2000)
         libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 
(0x00007fc44b5b6000)
         libcrypto++.so.9 => /usr/lib/libcrypto++.so.9 (0x00007fc44aea8000)
         libuuid.so.1 => /lib/x86_64-linux-gnu/libuuid.so.1 
(0x00007fc44aca2000)
         libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fc44aa9e000)
         libboost_thread.so.1.49.0 => /usr/lib/libboost_thread.so.1.49.0 
(0x00007fc44aa81000)
         librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fc44a878000)
         libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 
(0x00007fc44a571000)
         libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fc44a2ef000)
         libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 
(0x00007fc44a0d8000)
         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fc449d4d000)
         /lib64/ld-linux-x86-64.so.2 (0x00007fc44be65000)
         libsnappy.so.1 => /usr/lib/libsnappy.so.1 (0x00007fc449b47000)
         libtcmalloc.so.4 => /usr/lib/libtcmalloc.so.4 (0x00007fc4498d4000)
         libunwind.so.7 => /usr/lib/libunwind.so.7 (0x00007fc4496bb000)

Stefan
