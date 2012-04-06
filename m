From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: ceph 0.44+ and leveldb
Date: Fri, 06 Apr 2012 07:18:18 +0200
Message-ID: <1333689498.19737.11.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:57082 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab2DFFSW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 01:18:22 -0400
Received: from [192.168.0.100] (kabelnet-248-67.parisat.hu [91.147.248.67])
	by mail.barcikacomp.hu (Postfix) with ESMTPA id DA30749DBC
	for <ceph-devel@vger.kernel.org>; Fri,  6 Apr 2012 07:18:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph developers,

It seems you included leveldb in the source of Ceph. It has two serious
problems.
First, security. Now leveldb can't be updated to a newer version, only
with Ceph. Worst, security teams may not notice leveldb is embedded into
Ceph; meaning the latter would remain unfixed and vulnerable.
Second, as it doesn't contain fixes for various architectures that a
separately packaged leveldb has, it can make Ceph fail to build on
several architectures where leveldb is built otherwise.

See the Debian build list for example:
https://buildd.debian.org/status/package.php?p=ceph+leveldb&suite=sid

Also, leveldb doesn't work on all architectures. Making Ceph less
portable, which means less users can reach it.
See the build failures for ia64, mips, powerpc and s390[x]:
-- cut --
from ./db/builder.cc:7:
./port/atomic_pointer.h:133:2: error: #error Please implement AtomicPointer for this platform.
make[5]: *** [builder.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [all] Error 2
make[5]: Leaving directory `/build/buildd-ceph_0.44.1-1-ia64-2UAFHZ/ceph-0.44.1/src/leveldb'
-- cut --

Please re-evaluate the usage of leveldb.

Regards,
Laszlo/GCS

