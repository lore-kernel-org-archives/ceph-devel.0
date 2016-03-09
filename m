From: Marcus Watts <mwatts@redhat.com>
Subject: civetweb, sts work
Date: Wed, 9 Mar 2016 03:35:04 -0500
Message-ID: <20160309083504.GA1862@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38702 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbcCIIfI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Mar 2016 03:35:08 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 69F8C80518
	for <ceph-devel@vger.kernel.org>; Wed,  9 Mar 2016 08:35:07 +0000 (UTC)
Received: from degu.b.linuxbox.com (vpn-60-173.rdu2.redhat.com [10.10.60.173])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u298Z5Ds012987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 9 Mar 2016 03:35:07 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've just pushed out two new ceph branches, and I pushed out
a revised copy of civetweb that these both use.

I've pushed my git branches to git@github.com:ceph/ceph.git
They are:
wip-openssl-2
	( based on recentish master. )
	ssl patches (should be the same as what's already in master)
	+ "build out of tree" am changes (as described previously)
	+ civetweb "ng" changes.
		I've managed to build this with both cmake and configure.
		I haven't had time to do any testing past that yet.
		It "should" all work of course...
wip-rgw-sts-3
	everything that's in wip-openssl-2
	+ rgw-sts work.
	includes polymorphic rgw error object
	split out of some parts of rgw rest interface into objstore
		+ "generic" bits. (sts isn't an object store)
	basic sts encode/decode stuff.
		I've managed to build this with both cmake and configure.
		I haven't had time to do any testing past that yet.
		All the basic bits should work.
		The radosgw parts should work if I haven't broken them.
		The sts parts are still missing a lot of functionality.

I pushed my civitweb stuff to https://github.com/mdw-at-linuxbox/civetweb
Probably should should go to ceph/civetweb but I haven't had time
to follow up on that yet.
wip-easy1
	( based on recent upstream civetweb release)
	+ cmake build changes (builds w/ cmake on linux)
	+ modifications to support all of the functionality used by ceph,
		hopefully in a form that can be accepted by the civetweb
		folks upstream.
		I've built this standalone, and gotten it to pass all
		of its self-test logic.  I haven't done any other testing yet.

I imagine I'll find out "tomorrow" what gitbuilder thought
of all this.
	{ Hm.  rocksdb might catch me up.  I'm building with "rocksdb-devel",
		but I haven't touched ceph.spec.in ... }

Next steps on the roadmap,
fix whatever gitbuilder finds
auth_mellon-like functionality for sts
radosgw token changes
radosgw userdb changes

other bits along the side,
push rocksdb changes to rocksdb upstream
push civetweb changes to civetweb upstream
document using openssl w/ civetweb
{ and figure out how to hack gitbuilder rocksdb rpm/deb stuff... }

						-Marcus Watts
