From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Adding a delay when restarting all OSDs on a host
Date: Wed, 23 Jul 2014 16:57:22 -0400
Message-ID: <53D021B2.7080407@adfin.com>
References: <53CE64D0.5050308@42on.com> <CAPYLRzi37k8X3ASb_HSS40-6SqTWjPZgziN8nyhkQSO6svWAtQ@mail.gmail.com> <5F401C8095B99D4FABC1B919C1BE599A01029F8655@EXMBNJE1.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51716 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933267AbaGWU5Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jul 2014 16:57:25 -0400
Received: by mail-qa0-f53.google.com with SMTP id v10so1897459qac.26
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jul 2014 13:57:24 -0700 (PDT)
In-Reply-To: <5F401C8095B99D4FABC1B919C1BE599A01029F8655@EXMBNJE1.ad.twosigma.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vit Yenukas <Vit.Yenukas@twosigma.com>, Gregory Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Default stack size shouldn't matter. At least it's not an issue on a kernel with over-commit turned on (default). Most threads / apps never use that many stack frames (in fact they use a fraction of that), thus the kernel doesn't bother allocating the pages to it. My bet is on some other resource.

On 7/23/14, 3:22 PM, Vit Yenukas wrote:
> Just some fun fact pertaining to the resources consumption during startup sequence - 
> we've ran out of memory on a 72-disk server with 256GB RAM during the startup.
> ceph-osd dies with 'can not fork' and cores. There were in excess of 40 thousands 
> threads when this began to happen. With default thread stack size being 8MB, no wonder :)
> Note that this was in an experimental setup with just one node, so all OSDs peering happens on the same host.
> Just for heck of it, I reduced the number of OSDs by two (to 36 OSDs) by setting up a soft RAID-0 for each disk pair. 
> This worked after some tweaking of udev rules (that ignore 'md' block devs). I'm not sure if we're going to see 
> the same problem with real cluster (18 such 72-disk nodes), with EC 9-3. 
> Also, not sure if reducing user proc stack to 4MB would be a good idea. 
>
> On 07/22/2014 08:08 PM, Gregory Farnum wrote:
>
>> On Tue, Jul 22, 2014 at 6:19 AM, Wido den Hollander <wido@42on.com> wrote:
>>> Hi,
>>>
>>> Currently on Ubuntu with Upstart when you invoke a restart like this:
>>>
>>> $ sudo restart ceph-osd-all
>>>
>>> It will restart all OSDs at once, which can increase the load on the system
>>> a quite a bit.
>>>
>>> It's better to restart all OSDs by restarting them one by one:
>>>
>>> $ sudo ceph restart ceph-osd id=X
>>>
>>> But you then have to figure out all the IDs by doing a find in
>>> /var/lib/ceph/osd and that's more manual work.
>>>
>>> I'm thinking of patching the init scripts which allows something like this:
>>>
>>> $ sudo restart ceph-osd-all delay=180
>>>
>>> It then waits 180 seconds between each OSD restart making the proces even
>>> smoother.
>>>
>>> I know there are currently sysvinit, upstart and systemd scripts, so it has
>>> to be implemented on various places, but how does the general idea sound?
>> That sounds like a good idea to me. I presume you're meaning to
>> actually delay the restarts, not just turning them on, so that the
>> daemons all remain alive (that's what it sounds like to me here, just
>> wanted to clarify).
>> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

