From: Marcus Watts <mwatts@redhat.com>
Subject: ceph / rocksdb
Date: Wed, 24 Feb 2016 01:05:46 -0500
Message-ID: <20160224060546.GC6585@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44600 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcBXGFt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Feb 2016 01:05:49 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 378A18E3CA
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 06:05:49 +0000 (UTC)
Received: from degu.b.linuxbox.com (vpn-60-96.rdu2.redhat.com [10.10.60.96])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1O65lkC010960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 01:05:48 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

So, about that rocksdb thing.

Rocksdb ships with 2 build systems:
	cmake		- windows only
	make based	- everything else

The makefile is very "retro".  Um.  Let's just leave it there.

The cmake part was more interesting; the main problem it had
was it was *way* too windows specific.  Which is actually kinda
hard to do, since that's just what cmake wasn't supposed to be.

Building rocksdb (-g) takes about 1g of build tree space,
and running "make check" on it takes about half an hour.
I really don't want to slow down my ceph builds this way,
so rather than make rocksdb with the rest of ceph, I would
much rather it be packaged / installed separately.

So I put together:
a set of changes to build rocksdb with cmake on linux
an rpm .spec file to build it for fedora.

Rpms (source & amd64) can be found here:
	http://people.redhat.com/mwatts/rocksdb/
and a git repo with the cmake changes here,
	https://github.com/mdw-at-linuxbox/rocksdb

The cmake parts could certainly still use more work; I haven't
tested this and it will probably need changes on anything other
than x86_64, such as certainly any non-gcc/non-linux platform.

					-Marcus Watts
