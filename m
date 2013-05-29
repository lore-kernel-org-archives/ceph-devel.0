From: Chris Dunlop <chris@onthe.net.au>
Subject: Speed up 'rbd rm'
Date: Wed, 29 May 2013 15:59:42 +1000
Message-ID: <20130529055942.GA3977@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:42947 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab3E2GH5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 02:07:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 9FD7E61498
	for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 15:59:46 +1000 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L1Gqzs+kMnYC for <ceph-devel@vger.kernel.org>;
	Wed, 29 May 2013 15:59:42 +1000 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 924A061465
	for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 15:59:42 +1000 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id CF40F2AA7A7
	for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 15:59:42 +1000 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I know 'rbd rm' is notoriously slow, even on never-written devices:

http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/6740
http://tracker.ceph.com/issues/2256

I fat fingered an 'rbd create' and accidentally created a 1.5 PB device,
and it's going to take some considerable time to remove this!

I see there's a new commit to speed up an 'rbd rm':

http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926

Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?

Cheers,

Chris
