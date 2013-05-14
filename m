From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: [ceph-users] OSD state flipping when cluster-network in high
 utilization
Date: Tue, 14 May 2013 10:35:33 -0500
Message-ID: <519259C5.3000109@inktank.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC0145EFF6@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:53454 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab3ENPfc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 11:35:32 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so720027obc.27
        for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 08:35:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On 05/14/2013 10:30 AM, Sage Weil wrote:
> On Tue, 14 May 2013, Chen, Xiaoxi wrote:
>>
>> Hi
>>
>>    We are suffering our OSD flipping between up and down ( OSD X be voted to
>> down due to 3 missing ping, and after a while it tells the monitor ?map xxx
>> wrongly mark me down? ). Because we are running sequential write performance
>> test on top of RBDs, and the cluster network nics is really in high
>> utilization (8Gb/s+ for a 10Gb network).
>>
>>           Is this a expected behavior ? or how can I prevent this happen?
>
> You an increase the heartbeat grace period.  The pings are handled by a
> separate thread on the backside interface (if there is one).  If you are
> missing pings then the network or scheduler is preventing those (small)
> messages from being processed (there is almost no lock contention in that
> path).  Which means it really is taking ~20 seconds or wahtever to handle
> those messages.  It's really a questin of how unresponsive you want to
> permit the OSDs to be before you consider it a failure..
>
> sage
>
>

It might be worth testing out how long pings or other network traffic 
are taking during these tests.  There may be some tcp tunning you can do 
here, or even consider using a separate network for the mons.

Mark
