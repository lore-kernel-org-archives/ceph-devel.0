From: Thomas Mueller <thomas@chaschperli.ch>
Subject: make fails: common/debug.cc:8:22: error: ceph_ver.h: No such file
 or directory (ceph.git/master)
Date: Tue, 27 Jul 2010 07:59:37 +0000 (UTC)
Message-ID: <i2m3l9$53k$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56383 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919Ab0G0IAE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Jul 2010 04:00:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Odf4v-00053s-Jd
	for ceph-devel@vger.kernel.org; Tue, 27 Jul 2010 09:59:57 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 09:59:57 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 09:59:57 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

by accident a ran a compile against the ceph.git/master.  if configure is 
ran with 

./configure --without-hadoop --with-debug

it fails with:

mv -f .deps/tls.Tpo .deps/tls.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT buffer.o -MD -MP -MF .deps/buffer.Tpo -c -o buffer.o `test -f 'common/buffer.cc' || echo './'`common/buffer.cc
mv -f .deps/buffer.Tpo .deps/buffer.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT debug.o -MD -MP -MF .deps/debug.Tpo -c -o debug.o `test -f 'common/debug.cc' || echo './'`common/debug.cc
mv -f .deps/common_init.Tpo .deps/common_init.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT ceph_fs.o -MD -MP -MF .deps/ceph_fs.Tpo -c -o ceph_fs.o `test -f 'include/ceph_fs.cc' || echo './'`include/ceph_fs.cc
 common/debug.cc:8:22: error: ceph_ver.h: No such file or directory
 mv -f .deps/ceph_fs.Tpo .deps/ceph_fs.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT ceph_hash.o -MD -MP -MF .deps/ceph_hash.Tpo -c -o ceph_hash.o `test -f 'include/ceph_hash.

- Thomas

