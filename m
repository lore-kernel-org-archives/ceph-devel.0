From: Sage Weil <sweil@redhat.com>
Subject: /var/lib/ceph/*/*/config
Date: Tue, 19 Jan 2016 10:15:02 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbcASPOz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 10:14:55 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 5C5D1C09FAB5
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jan 2016 15:14:55 +0000 (UTC)
Received: from cpach (ovpn-112-45.phx2.redhat.com [10.3.112.45])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0JFErMP000380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jan 2016 10:14:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I think we should add an optional 'config' file location to the config 
search path.  This would allow you to put customized options for an 
individual daemon in the daemon data directory.  Or, you could avoid 
putting a config in /etc/ceph entirely, so that the daemon data is 
completely self-contained on the device.  That would streamline boot disk 
failure (just reinstall OS and ceph package) or drive swaps between failed 
host hardware.

What do you think?
sage

