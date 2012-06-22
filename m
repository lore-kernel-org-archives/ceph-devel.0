From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Rolling upgrades possible?
Date: Fri, 22 Jun 2012 11:33:46 +0200
Message-ID: <4FE43BFA.8050502@widodh.nl>
References: <CAMmJxt+2YZBCTZ_W7xuk8HHnqfTUUuxFGtT_AoaJYqsvjB0niw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:46399 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485Ab2FVJds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 05:33:48 -0400
In-Reply-To: <CAMmJxt+2YZBCTZ_W7xuk8HHnqfTUUuxFGtT_AoaJYqsvjB0niw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On 06/22/2012 11:23 AM, John Axel Eriksson wrote:
> I guess this has been asked before, I'm just new to the list and
> wondered whether it's possible to do
> rolling upgrades of mons, osds and radosgw? We will soon be in the
> process of migrating from our current
> storage solution to Ceph/RGW. We will only use the object storage,
> actually mainly the S3-interface radosgw
> supplies.
>
> Right now we have a very small test-installation - 1 mon, 2 osds where
> the mon also runs rgw. Next week I've
> heard that 0.48 might be released, if we upgrade to that, do we have
> to shut down the cluster during the upgrade
> or can we do a rolling upgrade while still responding to PUTs and
> GETs? If not possible yet, is this in the pipeline?

Currently there is no guarantee that rolling upgrades will work, I 
however suspect that with 0.48 this will become a priority.

With 0.48 there will be a on-disk format change, but I don't know if the 
protocol between the daemons will change.

Towards 0.48 I wouldn't bet on a rolling upgrade, but you can always try 
with a test cluster :)

Wido

>
> Best,
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

