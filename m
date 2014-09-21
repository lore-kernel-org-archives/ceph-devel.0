From: Sage Weil <sweil@redhat.com>
Subject: Re: issue 8747 / 9011
Date: Sun, 21 Sep 2014 12:28:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409211227510.27396@cobra.newdream.net>
References: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net> <2949490.exWB3TExxB@debstor>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59258 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaIUT2Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 15:28:24 -0400
In-Reply-To: <2949490.exWB3TExxB@debstor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dmitry Smirnov <onlyjob@member.fsf.org>
Cc: ceph-devel@vger.kernel.org

On Fri, 19 Sep 2014, Dmitry Smirnov wrote:
> Hi Sage,
> 
> On Fri, 19 Sep 2014 16:43:31 Sage Weil wrote:
> > Are you still seeing this crash?
> > 
> >  osd/ReplicatedPG.cc: 5297: FAILED assert(soid < scrubber.start || soid >=
> > scrubber.end)
> 
> Thanks for following-up on this, Sage.
> Yes, I've seen this crash just recently on 0.80.5. It usually happens during 
> long recovery like when OSD is replaced. I've seen this happening after hours 
> of backfilling/remapping although it may take a long time to manifest.

Is there any possibility of enabling logging on your osds (debug ms = 1, 
debug osd = 20) so that we can capture this?

Thanks-
sage
