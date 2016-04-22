From: Sage Weil <sweil@redhat.com>
Subject: ECONNREFUSED implies OSD definitely failed
Date: Fri, 22 Apr 2016 12:24:52 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604221221000.8831@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbcDVQYt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Apr 2016 12:24:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0A41C0467EE
	for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 16:24:48 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3MGOkB3028661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 12:24:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Piotr has a PR at

	https://github.com/ceph/ceph/pull/8558

that changes the messenger and OSD logic so that if we get an ECONNREFUSED 
trying to talk to another OSD we can definitively conclude that the OSD is 
down/failed, without waiting for the normal heartbeat timeout.

I think this is true in normal networking environments.  My only concern 
is that there might be cases where the OSD isn't actually down and some 
transient network issue could cause ECONNREFUSED.  Like... some 
firewally magic networky thing.  If a transient ECONNREFUSED was possible, 
it could cause some ugly flapping.

Can anyone think of something that might cause this?  Even if it is 
something obscure, it means we should have a config option to disable this 
new behavior (we probably should anyway).

sage
