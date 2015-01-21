From: Sage Weil <sweil@redhat.com>
Subject: prime pg_temp
Date: Tue, 20 Jan 2015 20:02:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501201958150.3895@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbbAUECC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Jan 2015 23:02:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0L422vL006969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2015 23:02:02 -0500
Received: from redhat.com (ovpn-112-29.phx2.redhat.com [10.3.112.29])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t0L421HZ013586
	for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2015 23:02:01 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We discussed this forever ago during the Giant CDS.  I put together a 
patch set tonight that implements it in a pretty basic form.  See

	https://github.com/ceph/ceph/pull/3429

There's no fancy threading do to this in the background or any of the 
other more crazy stuff we discussed before.  Instead, there's just a 
simple limit that bounds the amount of time the primary is allowed to 
spend calculating mappings (default 500ms).  It also tries to be 
reasonably smart about limiting the amount of work, mainly by keeping a 
mapping of osds to pgs so that we can limit our checks when osds go down 
or out.

My main concern is whether the pg_by_osd map will consume much CPU or 
memory to maintain.  Anybody interested in testing that out?

sage

