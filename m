From: Sage Weil <sweil@redhat.com>
Subject: mon switch from leveldb to rocksdb
Date: Mon, 2 May 2016 14:49:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089AbcEBStC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 May 2016 14:49:02 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64DB862652
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2016 18:49:02 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u42Imx2A015960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 2 May 2016 14:49:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We're thinking about switching the default backend on the mon from leveldb 
to rocksdb.  Rocksdb is better maintained, has a stronger feature set, is 
generally faster, and is linked statically, which means we won't be 
vulnerable to buggy distro packages.

There is one blocker, though.  Some distro leveldbs name the sst files 
with the .ldb suffix.  (Some don't; very annoying.)  There is a unit test 
in rocksdb that tries to verify that ldb is silently renamed to sst, 
and it passes, but the test is incomplete: the test failes to verify 
that ldb/sst files can actually be read, and it turns out only the 'check' 
path (not the normal open and read it path) handles ldb properly.

Anyway, once that works, rocksdb will magically upgrade from leveldb to 
rocksdb.  Note that once that happens you can't switch from rocksdb back 
to leveldb without recreating the mon.

Alternatively, we could not worry about upgrading existing leveldb 
instances and just make newly created mons default to rocksdb.

1) Thoughts on moving to rocksdb in general?

2) Importance of leveldb->rocksdb conversion?

3) Anyone want to fix the ldb handling in rocksdb?

Thanks!
sage

