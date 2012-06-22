From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Recommendations for OSDs, RGW and MON
Date: Fri, 22 Jun 2012 11:38:37 +0200
Message-ID: <4FE43D1D.4010401@widodh.nl>
References: <CAMmJxtLUwnCnbkYMoh0VHxWoL+HJQ98su=4x6GTza2zoS9VR9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:46727 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761633Ab2FVJij (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 05:38:39 -0400
In-Reply-To: <CAMmJxtLUwnCnbkYMoh0VHxWoL+HJQ98su=4x6GTza2zoS9VR9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On 06/22/2012 11:28 AM, John Axel Eriksson wrote:
> Currently we're running a test cluster with 1 mon, 1 radosgw and 2
> osds. RGW runs on the same host as the mon while
> the osds recides on two different servers. We have thought of maybe
> running more than 1 osd on each storage server, where
> the osds use different disks of course - is this something reasonable
> or would performance/stability suffer?

No, that is not a problem at all. You can run multiple OSD's on one server.

Just make sure you have something like 1GB ~ 2GB per OSD available on 
memory.

See: http://www.ceph.com/docs/master/rec/

>
> Is there any recommendation against running rgw/mon on the same
> server? Would a better setup be to put osd/mon/rgw on each
> server and loadbalancing rgw? Of course we might add more osd:s at
> some point and I guess we don't want to run mons/rgw on
> those.
>

You can mix the RGW and MON daemons, but you are better of in letting 
the OSD's run on their own, dedicated machines.

In a later stage you can always move the monitors to new machines.

> Also, on Ubuntu 12.04, does anybody have experience with ceph on btrfs
> performance or is the recommendation still to run on xfs?

I wouldn't run with the stock 12.04 kernel with btrfs. The story goes 
(see ml archive) that with kernel 3.5 there have been some btrfs 
improvements, but if you are only using the RGW, XFS might be your best 
option.

http://www.ceph.com/docs/master/rec/filesystem/

Wido

>
> All this is for running only the object storage part of ceph (only
> accessed through RGWs S3-interface).
>
> Thanks,
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

