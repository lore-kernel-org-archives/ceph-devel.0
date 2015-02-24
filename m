From: Sage Weil <sweil@redhat.com>
Subject: Re: Negative stats on lab cluster
Date: Tue, 24 Feb 2015 08:05:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502240803530.25838@cobra.newdream.net>
References: <54EC634D.9050104@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43409 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbbBXQFY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Feb 2015 11:05:24 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1OG5Oqx001268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2015 11:05:24 -0500
In-Reply-To: <54EC634D.9050104@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, ceph-devel@vger.kernel.org

On Tue, 24 Feb 2015, John Spray wrote:
> The lab cluster hosting teuthology logs is currently exhibiting negative
> statistics (#5884, #7737).  Could be a good time for someone with more
> low-level RADOS expertise than me to take a look at the status and see if they
> can work out why it's happening.

Definitely.  Pretty sure it's because there is a process deleting a bunch 
of files/objects while we are backfilling.  I want to get it upgraded to 
hammer -rc today while it is still happening so that I can fix it there; I 
forget how much drift there has been since giant...

sage
