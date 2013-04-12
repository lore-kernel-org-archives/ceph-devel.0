From: Matthias Urlichs <matthias@urlichs.de>
Subject: ceph and efficient access of distributed resources
Date: Fri, 12 Apr 2013 03:59:17 +0000 (UTC)
Message-ID: <loom.20130412T055215-88@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58707 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724Ab3DLD7c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Apr 2013 23:59:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UQV95-00019m-W4
	for ceph-devel@vger.kernel.org; Fri, 12 Apr 2013 05:59:28 +0200
Received: from netz.smurf.noris.de ([213.95.21.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 05:59:27 +0200
Received: from matthias by netz.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 05:59:27 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

As I understand it, in Ceph one can cluster storage nodes, but otherwise
every node is essentially identical, so if three storage nodes have a file,
ceph randomly uses one of them.

This is not efficient use of network resources in a distributed data center.
Or even in a multi-rack situation.

I want to prefer accessing nodes which are "local".
The client in rack A should prefer to read from the storage nodes that are
also in rack A.
Ditto for rack B.
Ditto for s/rack/data center/.

As far as I understand, the Ceph clients can't do that.
(Nor can Ceph nodes among each other, but I care less about that, as most
traffic is reading data.)

I think this is an important feature for many high-reliability situations.

What would be the next steps to get this feature, assuming I don't have time
to implement it myself? Persistently annoy this mailing list that people
need it? Offer to pay for implementing it? Shut up and look for some other
solution -- which I already did, but I didn't find any that's as good as
Ceph, otherwise?

I've opened a feature request for this, half a year ago, which hasn't seen
any comments yet: http://tracker.ceph.com/issues/3249

-- Matthias Urlichs

