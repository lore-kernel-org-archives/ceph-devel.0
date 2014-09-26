From: "Zhang, Jian" <jian.zhang@intel.com>
Subject: RE: Weekly performance meeting
Date: Fri, 26 Sep 2014 06:40:01 +0000
Message-ID: <51FC7A40FB29414D88A121A7FFEF9A4710F7181A@SHSMSX104.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51652 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbaIZGkn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 02:40:43 -0400
In-Reply-To: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Somnath.Roy@sandisk.com" <Somnath.Roy@sandisk.com>, "Allen.Samuels@sandisk.com" <Allen.Samuels@sandisk.com>, "dieter.kasper@ts.fujitsu.com" <dieter.kasper@ts.fujitsu.com>, "PVonStamwitz@us.fujitsu.com" <PVonStamwitz@us.fujitsu.com>, "Shu, Xinxin" <xinxin.shu@intel.com>, "haomaiwang@gmail.com" <haomaiwang@gmail.com>, "s.priebe@profihost.ag" <s.priebe@profihost.ag>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "milosz@adfin.com" <milosz@adfin.com>, "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, "Ma, Jianpeng" <jianpeng.ma@intel.com>, "gdror@mellanox.com" <gdror@mellanox.com>, "vuhuong@mellanox.com" <vuhuong@mellanox.com>, "mark.nelson@inktank.com" <mark.nelson@inktank.com>, "Duan, Jiangang" <jiangang.duan@intel.com>

Sage, 
It is really great to have a performance meeting running. We'd like to join the meeting. 
So far, we have a list of topics that can be discussed on the next meeting(seems we already have many topics listed here, and its PRC holiday next week). 
* Full SSD setup performance limitations
* Cache tiring optimization proposals
* EC Performance enhancement

Thanks
Jian


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Friday, September 26, 2014 2:27 AM
To: ceph-devel@vger.kernel.org
Cc: Somnath.Roy@sandisk.com; Allen.Samuels@sandisk.com; dieter.kasper@ts.fujitsu.com; PVonStamwitz@us.fujitsu.com; Shu, Xinxin; haomaiwang@gmail.com; s.priebe@profihost.ag; Chen, Xiaoxi; milosz@adfin.com; Wang, Zhiqiang; Ma, Jianpeng; gdror@mellanox.com; vuhuong@mellanox.com; mark.nelson@inktank.com
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
