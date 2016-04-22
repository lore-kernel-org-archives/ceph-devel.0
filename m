From: Sage Weil <sweil@redhat.com>
Subject: mon port changing from 6789 to 3300
Date: Fri, 22 Apr 2016 10:27:28 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604221024310.8831@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50899 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbcDVO1Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Apr 2016 10:27:25 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 189E678234
	for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 14:27:25 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: kdreyer@redhat.com

A while back the IANA assigned us an official port number to use for the 
monitor ports: 3300 (0xce4, or ce4h).

Here's a PR that updates ceph.git with the new port:

	https://github.com/ceph/ceph/pull/8699

In short, new clusters will use the new mon port, old clusters won't 
change, and clients will try the new port and then the old port (unless 
the config options explicitly specify a port).

I suspect there will be a bunch of external tools and documentation that 
need to be updated, though, like default firewall configuration files.

I'd like to merge this *very* early in the kraken cycle (i.e., now) so 
that we have lots of time to find and fix these issues.

Comments, concerns?
sage
