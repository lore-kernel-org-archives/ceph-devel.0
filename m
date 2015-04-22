From: Ken Dreyer <kdreyer@redhat.com>
Subject: systemd unit files and multiple daemons
Date: Wed, 22 Apr 2015 15:57:12 -0600
Message-ID: <55381938.7010600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756659AbbDVV5O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Apr 2015 17:57:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

I could really use some eyes on the systemd change proposed here:
http://tracker.ceph.com/issues/11344

Specifically, on bullet #4 there, should we have a single
"ceph-mon.service" (implying that users should only run one monitor
daemon per server) or if we should support multiple "ceph-mon@" services
(implying that users will need to specify additional information when
starting the service(s)). The version in our tree is "ceph-mon@". James'
work for Ubuntu Vivid is only "ceph-mon" [2]. Same thing for ceph-mds vs
ceph-mds@.

I'd prefer to keep Ubuntu downstream the same as Ceph upstream.

What do we want to do for this?

How common is it to run multiple monitor daemons or mds daemons on a
single host?

- Ken


[1] https://github.com/ceph/ceph/tree/master/systemd
[2]
http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/vivid/ceph/vivid/files/head:/debian/lib-systemd/
