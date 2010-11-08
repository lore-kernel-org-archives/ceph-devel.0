From: Wido den Hollander <wido@widodh.nl>
Subject: Re: questions about weight
Date: Mon, 08 Nov 2010 14:07:52 +0100
Message-ID: <1289221672.2266.9.camel@wido-desktop>
References: <AANLkTi=_qKOzX4KgB8eA1b+Gq-A1botpix=vv-9WCYQS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:41032 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0KHNHx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Nov 2010 08:07:53 -0500
In-Reply-To: <AANLkTi=_qKOzX4KgB8eA1b+Gq-A1botpix=vv-9WCYQS@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ravi Pinjala <pstatic@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Ravi,

On Sun, 2010-11-07 at 23:52 -0800, Ravi Pinjala wrote:
> First off: what does weight actually mean in a CRUSH map? I had
> assumed it was there to balance capacity, and should be set to
> something proportional to the size of the disk. However, the page on
> the wiki about osd_auto_weight seems to indicate that it's related to
> disk performance, not size. Is it one of these, or something
> completely different?

It is the size of the disk, for example:

osd1, size 120GB, weight: 1.200
osd2, size 560GB, weight: 5.600
osd3, size 340GB, weight: 3.400

Now, you should be careful, since osd2 and osd3 will have to do much
more IOps, so make sure their hardware is up to the job.

> 
> Also: when defining several levels of buckets, how does the weight on
> the higher levels of buckets affect the overall distribution? I've got
> the beginning of a cluster running now, with one host with a 640GB
> drive and a 1TB drive, and another host with a 640GB drive. I've been
> playing with the weights to try and get the amount of data on each
> disk proportional to its size, to maximize the space I have available.
> I have my CRUSH map set up like this right now:
> 
> host0 {
>     item device 0 weight 0.640
>     item device 1 weight 1.000
> }
> 
> host1 {
>     item device 2 weight 0.640
> }
> 
> root {
>     item host0 weight 1.640
>     item host1 weight 0.640
> }
> 
> Will this do what I'm expecting, and maximize the amount of data I can
> store before any of the disks fill up?

You don't have to calculate a hosts weight in the root, this will be
done automatically by summing the device's weight.

But, it looks fine what you've done, that should work.

Wido

> 
> Thanks,
> --Ravi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

