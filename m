From: Sage Weil <sage@newdream.net>
Subject: Re: Some of my PGs stay at "active"
Date: Fri, 6 Jan 2012 09:59:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201060959070.26315@cobra.newdream.net>
References: <1854635.GsxyuXkRgh@pc10> <Pine.LNX.4.64.1201060900480.26315@cobra.newdream.net>
 <Pine.LNX.4.64.1201060907060.26315@cobra.newdream.net> <9902626.TgOVAtLKkc@pc10>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58638 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758300Ab2AFR7u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2012 12:59:50 -0500
In-Reply-To: <9902626.TgOVAtLKkc@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 6 Jan 2012, Guido Winkelmann wrote:
> Am Freitag, 6. Januar 2012, 09:07:43 schrieben Sie:
> > On Fri, 6 Jan 2012, Sage Weil wrote:
> > > On Fri, 6 Jan 2012, Guido Winkelmann wrote:
> > > > Hi,
> > > > 
> > > > ceph -s reports most of my PGs as "active+clean", but a small number
> > > > will stay at just "active":
> > > > 
> > > > # ceph -s
> > > > 2012-01-06 11:16:44.832625    pg v278953: 396 pgs: 8 active, 388
> > > > active+clean; 70764 MB data, 157 GB used, 4994 GB / 5257 GB avail;
> > > > 170/38388 degraded (0.443%)
> > 
> > Whoops, Yehuda just pointed out that there are degraded objects here too.
> > So that's a less-harmless bug.  :)
> > 
> > Which version?
> 
> 0.39
>  
> > Also, can you post the output from
> > 
> > 	ceph pg dump | grep degraded
> 
> Sorry, I've already restarted one the osds and the degraded pgs are gone 
> again...

No problem.  There been a lot of changes in this code for 0.40 anyway, so 
debugging the problem with 0.39 is of limited value anyway.

Cheers-
sage
