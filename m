From: Marcus Watts <mwatts@redhat.com>
Subject: ceph + -lssl
Date: Wed, 24 Feb 2016 00:09:12 -0500
Message-ID: <20160224050912.GA6585@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089AbcBXFJO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Feb 2016 00:09:14 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id A935BC0006F7
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 05:09:14 +0000 (UTC)
Received: from degu.b.linuxbox.com (vpn-60-96.rdu2.redhat.com [10.10.60.96])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1O59CIi032301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 00:09:14 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've been working on better integrating ssl int ceph.
Currently, I have a branch, "wip-openssl" which I've pushed to
github, which builds using gitbuilder, also builds with cmake.
I haven't done much testing with this, so there may be some other
business (with certs and such) to make this actually useful.

commits to make this build:
1/ ba8bfab15255d4b321f200a617bc2e0335676482
	automake: -lssl
2/ 5188536a6e42d9207d45dadc86700546ac12b1a2
	cmake: ssl + crypto
3/ 96fe7c5745584158aa69223e3b2482fc9dcfc8fe
	automake: -lssl -lcrypto (not just -lssl)
4/ a23e063a7db4780f120a2199db55ce5ae816b829
	git: used fixed version of civetweb.
	fixes a warning.

There are some additional commits in wip-openssl to support
build "out of tree".  I'll post a separate message about that.

					-Marcus Watts
