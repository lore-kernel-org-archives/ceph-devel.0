From: Sage Weil <sweil@redhat.com>
Subject: file journal fadvise
Date: Sun, 30 Nov 2014 10:46:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411301013490.352@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35246 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbaK3SqZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 30 Nov 2014 13:46:25 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAUIkPQ1003325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Sun, 30 Nov 2014 13:46:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mnelson@redhat.com, ceph-devel@vger.kernel.org

Currently, when an OSD journal is stored as a file, we preallocate it as a 
large contiguous extent.  That means that for every journal write we're 
seeking back to wherever the journal is.  That possibly not ideal for 
writes.  For reads it's great, but that's the last thing we care about 
optimizing (we only read the journal after a failure, which is very rare).

I wonder if we would do better if we:

 1- trim/discard the old journal contents,
 2- posix_fadvise RANDOM

I'm not sure what the XFS behavior is in this case, but ideally it seems 
what we want it to do is write the journal wherever on disk it is most 
convenient... ideally contiguous with some other write that it is already 
doing.  If fadvise random doesn't do that, perhaps there is another 
allocator hint we can give it that will get us that behavior...

sage
