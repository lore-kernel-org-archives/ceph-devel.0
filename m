From: Marcus Watts <mwatts@redhat.com>
Subject: rgw + ssl
Date: Wed, 23 Mar 2016 19:03:17 -0400
Message-ID: <20160323230317.GB24692@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbcCWXDU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Mar 2016 19:03:20 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id A427F64369
	for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 23:03:19 +0000 (UTC)
Received: from degu.b.linuxbox.com (vpn-58-63.rdu2.redhat.com [10.10.58.63])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2NN3HXu012107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 19:03:19 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just a small heads-up

I pushed a new branch
	wip-rgw-openssl-2
to civetweb today.  This contains a few small updates for SSL:
9702fc5a	Replace + with , in civetweb port string.
380af5c7	For civetweb: don't complain about trailing 's' on port number.
736815b2	Document that radosgw now supports SSL.
(all applied against a very recent copy of master.)
	(This does not include the openssl-devel patches Matt was working on.)

I'll submit a PR for this once it builds on github.

The first patch makes it possible to run radosgw and cleanly support both
SSL and non-SSL with one civetweb instance.

The second patch fixes a stupid complaint radosgw had been making
about non-integer port strings.

And the 3rd patch updates some of the documentation and should make
it possible for people to actually use this.

				-Marcus Watts
