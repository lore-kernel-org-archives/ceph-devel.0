From: John Leach <john@brightbox.co.uk>
Subject: osd memory usage with lots of objects
Date: Tue, 04 Jan 2011 21:58:02 +0000
Message-ID: <1294178282.2654.5.camel@dogen>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:36174 "EHLO
	smtp161.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab1ADV6G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 16:58:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp46.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 70432E8B7E
	for <ceph-devel@vger.kernel.org>; Tue,  4 Jan 2011 16:58:04 -0500 (EST)
Received: by smtp46.relay.iad1a.emailsrvr.com (Authenticated sender: john-AT-brightbox.co.uk) with ESMTPSA id 0BA0DE88CD
	for <ceph-devel@vger.kernel.org>; Tue,  4 Jan 2011 16:58:03 -0500 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've got a 3 node test cluster (3 mons, 3 osds) with about 24,000,000
very small objects across 2400 pools (written directly with librados,
this isn't a ceph filesystem).

The cosd processes have steadily grown in ram size and have finally
exhausted ram and are getting killed by the oom killer (the nodes have
6gig RAM and no swap).

When I start them back up they just very quickly increase in ram size
again and get killed.

Is this expected? Do the osds require a certain amount of resident
memory relative to the data size (or perhaps number of objects)?

Can you offer any guidance on planning for ram usage?

I'm running ceph 0.24 on 64bit Ubuntu Lucid servers.  In case it's
useful, I've just written these objects serially, no reading, no
rewrites, updates or snapshots.

I've got some further questions/observations about disk usage with this
scenario but I'll start a separate thread about that.

Thanks,

John. 

