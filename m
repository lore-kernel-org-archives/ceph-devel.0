From: Sage Weil <sage@newdream.net>
Subject: Re: make fails: common/debug.cc:8:22: error: ceph_ver.h: No such
 file or directory (ceph.git/master)
Date: Tue, 27 Jul 2010 10:21:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007271020280.28672@cobra.newdream.net>
References: <i2m3l9$53k$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37118 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab0G0RSp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jul 2010 13:18:45 -0400
In-Reply-To: <i2m3l9$53k$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Tue, 27 Jul 2010, Thomas Mueller wrote:
> hi
> 
> by accident a ran a compile against the ceph.git/master.  if configure is 
> ran with 
> 
> ./configure --without-hadoop --with-debug
> 
> it fails with:
> 
> mv -f .deps/tls.Tpo .deps/tls.Po
> g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT buffer.o -MD -MP -MF .deps/buffer.Tpo -c -o buffer.o `test -f 'common/buffer.cc' || echo './'`common/buffer.cc
> mv -f .deps/buffer.Tpo .deps/buffer.Po
> g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT debug.o -MD -MP -MF .deps/debug.Tpo -c -o debug.o `test -f 'common/debug.cc' || echo './'`common/debug.cc
> mv -f .deps/common_init.Tpo .deps/common_init.Po
> g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT ceph_fs.o -MD -MP -MF .deps/ceph_fs.Tpo -c -o ceph_fs.o `test -f 'include/ceph_fs.cc' || echo './'`include/ceph_fs.cc
>  common/debug.cc:8:22: error: ceph_ver.h: No such file or directory
>  mv -f .deps/ceph_fs.Tpo .deps/ceph_fs.Po
> g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT ceph_hash.o -MD -MP -MF .deps/ceph_hash.Tpo -c -o ceph_hash.o `test -f 'include/ceph_hash.

This is due to some races in the Makefile.. if you 'make ceph_ver.h' and 
then 'make' it'll work fine (or possibly just 'make' again will do the 
trick).  In any case, it's fixed in the unstable branch, and 0.21 is 
coming this week!

Thanks-
sage
