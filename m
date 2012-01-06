From: Sage Weil <sage@newdream.net>
Subject: Re: Some of my PGs stay at "active"
Date: Fri, 6 Jan 2012 09:07:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201060907060.26315@cobra.newdream.net>
References: <1854635.GsxyuXkRgh@pc10> <Pine.LNX.4.64.1201060900480.26315@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52092 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758808Ab2AFRHp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2012 12:07:45 -0500
In-Reply-To: <Pine.LNX.4.64.1201060900480.26315@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 6 Jan 2012, Sage Weil wrote:
> On Fri, 6 Jan 2012, Guido Winkelmann wrote:
> > Hi,
> > 
> > ceph -s reports most of my PGs as "active+clean", but a small number will stay 
> > at just "active":
> > 
> > # ceph -s
> > 2012-01-06 11:16:44.832625    pg v278953: 396 pgs: 8 active, 388 active+clean; 
> > 70764 MB data, 157 GB used, 4994 GB / 5257 GB avail; 170/38388 degraded 
> > (0.443%)

Whoops, Yehuda just pointed out that there are degraded objects here too. 
So that's a less-harmless bug.  :)  

Which version?

Also, can you post the output from

	ceph pg dump | grep degraded

Thanks!
sage


> > 2012-01-06 11:16:44.842568   mds e9: 1/1/1 up {0=alpha=up:active}
> > 2012-01-06 11:16:44.842648   osd e243: 6 osds: 6 up, 6 in
> > 2012-01-06 11:16:44.842799   log 2012-01-06 06:12:00.829148 osd.4 
> > 10.3.1.35:6800/1490 343 : [INF] 0.4e scrub ok
> > 2012-01-06 11:16:44.844179   mon e5: 3 mons at 
> > {ceph1=10.3.1.33:6789/0,ceph2=10.3.1.34:6789/0,ceph3=10.3.1.35:6789/0}
> > 
> > It's been like that for several days now. IIRC, the last thing I did with the 
> > cluster was to add some more OSDs. The last time this happened, the problem 
> > went away after restarting some of the OSDs.
> > 
> > What does this mean? Is that a bug?
> 
> That does sound like a bug, altho a reasonably harmless one.  Which 
> version are you running?
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
