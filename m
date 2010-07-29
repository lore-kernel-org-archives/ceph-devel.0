From: Sage Weil <sage@newdream.net>
Subject: Re: thounds of files in monX/logm dir
Date: Thu, 29 Jul 2010 09:41:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007290939520.799@cobra.newdream.net>
References: <i2s6r5$33r$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47423 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab0G2Qiz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jul 2010 12:38:55 -0400
In-Reply-To: <i2s6r5$33r$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Thu, 29 Jul 2010, Thomas Mueller wrote:
> hi
> 
> had running a 4 node cluster with 3mon,3mds,4osd for a while with no one 
> accessing it (actually nobody mounted it, i just forgot to stop the 
> services). this was about ceph.git/unstable a month ago.
> 
> today i've upgraded to the latest ceph.git/unstable . to start over I 
> deleted the ceph data completly. 
> 
> after 3mins of deleting i got curious.
> 
> every of the 3 mon nodes got about 530'000 files in the monX/logm dir.
> 
> is this expected?

It's an open issue without a comprehensive solution.  I added a trim on 
just the log states for now that will keep this in check (although keep in 
mind the $mon_data/log* files aren't rotated still).

http://tracker.newdream.net/issues/250

sage
