From: Sage Weil <sweil@redhat.com>
Subject: Weekly performance meeting
Date: Thu, 25 Sep 2014 11:27:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40806 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbaIYS1A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 14:27:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Somnath.Roy@sandisk.com, Allen.Samuels@sandisk.com, dieter.kasper@ts.fujitsu.com, PVonStamwitz@us.fujitsu.com, xinxin.shu@intel.com, haomaiwang@gmail.com, s.priebe@profihost.ag, xiaoxi.chen@intel.com, milosz@adfin.com, zhiqiang.wang@intel.com, jianpeng.ma@intel.com, gdror@mellanox.com, vuhuong@mellanox.com, mark.nelson@inktank.com

Hi everyone,

A number of people have approached me about how to get more involved with 
the current work on improving performance and how to better coordinate 
with other interested parties.  A few meetings have taken place offline 
with good results but only a few interested parties were involved.

Ideally, we'd like to move as much of this dicussion into the public 
forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always 
sufficient, however.  I'd like to also set up a regular weekly meeting 
using google hangouts or bluejeans so that all interested parties can 
share progress.  There are a lot of things we can do during the Hammer 
cycle to improve things but it will require some coordination of effort.

Among other things, we can discuss:

 - observed performance limitations
 - high level strategies for addressing them
 - proposed patch sets and their performance impact
 - anything else that will move us forward

One challenge is timezones: there are developers in the US, China, Europe, 
and Israel who may want to join.  As a starting point, how about next 
Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's

  8:00 (PDT, California)
 15:00 (UTC)
 18:00 (IDT, Israel)
 23:00 (CST, China)

That is surely not the ideal time for everyone but it can hopefully be a 
starting point.

I've also created an etherpad for collecting discussion/agenda items at

	http://pad.ceph.com/p/performance_weekly

Is there interest here?  Please let everyone know if you are actively 
working in this area and/or would like to join, and update the pad above 
with the topics you would like to discuss.

Thanks!
sage
