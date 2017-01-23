From: Wido den Hollander <wido@42on.com>
Subject: Re: crush devices class types
Date: Mon, 23 Jan 2017 14:38:40 +0100 (CET)
Message-ID: <1971303930.7861.1485178720341@ox.pcextreme.nl>
References: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:46553 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdAWNja (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 08:39:30 -0500
In-Reply-To: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> Op 22 januari 2017 om 17:44 schreef Loic Dachary <loic@dachary.org>:
> 
> 
> Hi Sage,
> 
> You proposed an improvement to the crush map to address different device types (SSD, HDD, etc.)[1]. When learning how to create a crush map, I was indeed confused by the tricks required to create SSD only pools. After years of practice it feels more natural :-)
> 
> The source of my confusion was mostly because I had to use a hierarchical description to describe something that is not organized hierarchically. "The rack contains hosts that contain devices" is intuitive. "The rack contains hosts that contain ssd that contain devices" is counter intuitive. Changing:
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
> where ssd/hdd is the device class would be much better. However, using the device class like so:
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
> looks arcane. Since the goal is to simplify the description for the first time user, maybe we could have something like:
> 
>     rule ssd {
>             ruleset 1
>             type replicated
>             min_size 1
>             max_size 10
>             device class = ssd

Would that be sane?

Why not:

step set-class ssd
step take default
step chooseleaf firstn 0 type host
step emit

Since it's a 'step' you take, am I right?

Wido

>             step take default
>             step chooseleaf firstn 0 type host
>             step emit
>     }
> 
> What do you think ?
> 
> Cheers
> 
> [1] http://pad.ceph.com/p/crush-types http://tracker.ceph.com/projects/ceph/wiki/CDM_01-FEB-2017
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
