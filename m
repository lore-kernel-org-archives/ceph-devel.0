From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: RE: Weekly performance meeting
Date: Thu, 25 Sep 2014 18:50:32 -0700
Message-ID: <622F4407872BA447A16110F65453358C033B02A3DBC5@FMSAMAIL.fmsa.local>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu25.fnanic.fujitsu.com ([192.240.6.15]:59533 "EHLO
	fujitsu25.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753096AbaIZCJP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Sep 2014 22:09:15 -0400
In-Reply-To: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Somnath.Roy@sandisk.com" <Somnath.Roy@sandisk.com>, "Allen.Samuels@sandisk.com" <Allen.Samuels@sandisk.com>, "dieter.kasper@ts.fujitsu.com" <dieter.kasper@ts.fujitsu.com>, "xinxin.shu@intel.com" <xinxin.shu@intel.com>, "haomaiwang@gmail.com" <haomaiwang@gmail.com>, "s.priebe@profihost.ag" <s.priebe@profihost.ag>, "xiaoxi.chen@intel.com" <xiaoxi.chen@intel.com>, "milosz@adfin.com" <milosz@adfin.com>, "zhiqiang.wang@intel.com" <zhiqiang.wang@intel.com>, "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>, "gdror@mellanox.com" <gdror@mellanox.com>, "vuhuong@mellanox.com" <vuhuong@mellanox.com>, "mark.nelson@inktank.com" <mark.nelson@inktank.com>

Thanks, Sage.

I'm in, too.

Paul

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Thursday, September 25, 2014 11:27 AM
To: ceph-devel@vger.kernel.org
Cc: Somnath.Roy@sandisk.com; Allen.Samuels@sandisk.com; dieter.kasper@ts.fujitsu.com; Paul Von-Stamwitz; xinxin.shu@intel.com; haomaiwang@gmail.com; s.priebe@profihost.ag; xiaoxi.chen@intel.com; milosz@adfin.com; zhiqiang.wang@intel.com; jianpeng.ma@intel.com; gdror@mellanox.com; vuhuong@mellanox.com; mark.nelson@inktank.com
Subject: Weekly performance meeting

Hi everyone,

A number of people have approached me about how to get more involved with the current work on improving performance and how to better coordinate with other interested parties.  A few meetings have taken place offline with good results but only a few interested parties were involved.

Ideally, we'd like to move as much of this dicussion into the public
forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always sufficient, however.  I'd like to also set up a regular weekly meeting using google hangouts or bluejeans so that all interested parties can share progress.  There are a lot of things we can do during the Hammer cycle to improve things but it will require some coordination of effort.

Among other things, we can discuss:

 - observed performance limitations
 - high level strategies for addressing them
 - proposed patch sets and their performance impact
 - anything else that will move us forward

One challenge is timezones: there are developers in the US, China, Europe, and Israel who may want to join.  As a starting point, how about next Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's

  8:00 (PDT, California)
 15:00 (UTC)
 18:00 (IDT, Israel)
 23:00 (CST, China)

That is surely not the ideal time for everyone but it can hopefully be a starting point.

I've also created an etherpad for collecting discussion/agenda items at

	http://pad.ceph.com/p/performance_weekly

Is there interest here?  Please let everyone know if you are actively working in this area and/or would like to join, and update the pad above with the topics you would like to discuss.

Thanks!
sage
