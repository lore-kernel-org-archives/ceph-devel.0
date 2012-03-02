From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: leveldb configure errors
Date: Fri, 2 Mar 2012 15:24:12 -0800
Message-ID: <50C10F7E-5438-463D-864D-8C9CF7AC8030@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:59233 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965393Ab2CBXYS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 18:24:18 -0500
Received: from [192.168.50.124] (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 75256777C010
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 15:24:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

With the latest master the leveldb directory is showing up empty and causing some problems after the clone. Is there an additional step required to get that directory to be populated?

-Noah

$ ./configure
...
config.status: executing libtool commands
=== configuring in src/leveldb (/home/nwatkins/projects/ceph/clean/ceph/src/leveldb)
configure: WARNING: no configuration information is in src/leveldb



nwatkins@kyoto:~/projects/ceph/clean/ceph$ ls -l src/leveldb/
total 0



nwatkins@kyoto:~/projects/ceph/clean/ceph$ make
Making all in .
make[1]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph'
make[1]: Nothing to be done for `all-am'.
make[1]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph'
Making all in src
make[1]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src'
rm -f init-ceph init-ceph.tmp
sed -e 's|@bindir[@]|/usr/local/bin|g' -e 's|@libdir[@]|/usr/local/lib|g' -e 's|@sysconfdir[@]|/usr/local/etc|g' -e 's|@datadir[@]|/usr/local/share/ceph|g' -e 's|@prefix[@]|/usr/local|g' -e 's|@@GCOV_PREFIX_STRIP[@][@]|7|g' './init-ceph.in' >init-ceph.tmp
chmod +x init-ceph.tmp
chmod a-w init-ceph.tmp
mv init-ceph.tmp init-ceph
make  all-recursive
make[2]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src'
Making all in ocf
make[3]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src/ocf'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src/ocf'
Making all in leveldb
make[3]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src/leveldb'
make[3]: *** No rule to make target `all'.  Stop.
make[3]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src/leveldb'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src'
make: *** [all-recursive] Error 1

