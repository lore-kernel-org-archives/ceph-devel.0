From: Guang Yang <yguang11@outlook.com>
Subject: Re: Weekly performance meeting
Date: Fri, 26 Sep 2014 10:47:29 +0800
Message-ID: <BLU436-SMTP230C555BD3856EACF721534DFBF0@phx.gbl>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s2.hotmail.com ([65.55.111.141]:52170 "EHLO
	BLU004-OMC4S2.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbaIZCrp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 22:47:45 -0400
In-Reply-To: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>, Somnath.Roy@sandisk.com, Allen.Samuels@sandisk.com, dieter.kasper@ts.fujitsu.com, PVonStamwitz@us.fujitsu.com, xinxin.shu@intel.com, haomaiwang@gmail.com, s.priebe@profihost.ag, xiaoxi.chen@intel.com, milosz@adfin.com, zhiqiang.wang@intel.com, jianpeng.ma@intel.com, gdror@mellanox.com, vuhuong@mellanox.com, mark.nelson@inktank.com

Hi Sage,
We are very interested to join (and contribute effort) as well. Following are a list of issues we have particular interests:
 1> Large number of small files bring performance degradation most due to file system lookup (even worst with EC).
 2> Messenger uses too many threads which bring burden for high density hardware (which I believe Haomai already has great progress).

Thanks,
Guang

On Sep 26, 2014, at 2:27 AM, Sage Weil <sweil@redhat.com> wrote:

> Hi everyone,
> 
> A number of people have approached me about how to get more involved with 
> the current work on improving performance and how to better coordinate 
> with other interested parties.  A few meetings have taken place offline 
> with good results but only a few interested parties were involved.
> 
> Ideally, we'd like to move as much of this dicussion into the public 
> forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always 
> sufficient, however.  I'd like to also set up a regular weekly meeting 
> using google hangouts or bluejeans so that all interested parties can 
> share progress.  There are a lot of things we can do during the Hammer 
> cycle to improve things but it will require some coordination of effort.
> 
> Among other things, we can discuss:
> 
> - observed performance limitations
> - high level strategies for addressing them
> - proposed patch sets and their performance impact
> - anything else that will move us forward
> 
> One challenge is timezones: there are developers in the US, China, Europe, 
> and Israel who may want to join.  As a starting point, how about next 
> Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's
> 
>  8:00 (PDT, California)
> 15:00 (UTC)
> 18:00 (IDT, Israel)
> 23:00 (CST, China)
> 
> That is surely not the ideal time for everyone but it can hopefully be a 
> starting point.
> 
> I've also created an etherpad for collecting discussion/agenda items at
> 
> 	http://pad.ceph.com/p/performance_weekly
> 
> Is there interest here?  Please let everyone know if you are actively 
> working in this area and/or would like to join, and update the pad above 
> with the topics you would like to discuss.
> 
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

