From: Sage Weil <sweil@redhat.com>
Subject: Re: crush devices class types
Date: Mon, 23 Jan 2017 14:12:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701231410340.3654@piezo.novalocal>
References: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbdAWOMm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Jan 2017 09:12:42 -0500
In-Reply-To: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 22 Jan 2017, Loic Dachary wrote:
> Hi Sage,
> 
> You proposed an improvement to the crush map to address different device 
> types (SSD, HDD, etc.)[1]. When learning how to create a crush map, I 
> was indeed confused by the tricks required to create SSD only pools. 
> After years of practice it feels more natural :-)
> 
> The source of my confusion was mostly because I had to use a 
> hierarchical description to describe something that is not organized 
> hierarchically. "The rack contains hosts that contain devices" is 
> intuitive. "The rack contains hosts that contain ssd that contain 
> devices" is counter intuitive. Changing:
> 
>     # devices
>     device 0 osd.0
>     device 1 osd.1
>     device 2 osd.2
>     device 3 osd.3
> 
> into:
> 
>     # devices
>     device 0 osd.0 ssd
>     device 1 osd.1 ssd
>     device 2 osd.2 hdd
>     device 3 osd.3 hdd
> 
> where ssd/hdd is the device class would be much better. However, using 
> the device class like so:
> 
>     rule ssd {
>             ruleset 1
>             type replicated
>             min_size 1
>             max_size 10
>             step take default:ssd
>             step chooseleaf firstn 0 type host
>             step emit
>     }
> 
> looks arcane. Since the goal is to simplify the description for the 
> first time user, maybe we could have something like:
> 
>     rule ssd {
>             ruleset 1
>             type replicated
>             min_size 1
>             max_size 10
>             device class = ssd
>             step take default
>             step chooseleaf firstn 0 type host
>             step emit
>     }
> 
> What do you think ?

Yes! Maybe adjust it to be consistent with the other directives, like

	device_class ssd

We could also adjust the naming of the generated nodes to be something 
like ssd@default instead of default:ssd as that reads semi-intuitively?

sage
