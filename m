From: John Spray <jspray@redhat.com>
Subject: Re: disk enclosure LEDs
Date: Thu, 1 Dec 2016 00:15:25 +0000
Message-ID: <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal> <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33112 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbcLAAPr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 19:15:47 -0500
Received: by mail-qk0-f172.google.com with SMTP id x190so228430865qkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 16:15:46 -0800 (PST)
In-Reply-To: <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 30, 2016 at 7:37 PM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 11/30/2016 04:51 PM, Sage Weil wrote:
>>
>> Since this is in a reasonably usable state, I think It's time for us to
>> figure out how we are going to do this in ceph.
>>
>> A few ideas:
>>
>>  ceph osd identify osd.123    # blink for a few seconds?
>>
>> or
>>
>>  ceph osd ident-led-on osd.123  # turn on
>>  ceph osd ident-led-off osd.123  # turn off
>>  ceph osd fault-led-on osd.123  # turn on
>>  ceph osd fault-led-off osd.123  # turn off
>>
>> This would mean persistently recording the LED state in the OSDMap.  And
>> it would mean ceph-osd is the one twiddling the LEDs.  But that might not
>> be the way to go in all cases.  For example, if we have an OSD that fails,
>> once we confirm that we've healed (and don't need that OSDs data) we'd
>> probably want to set the fault light so that the disk can be pulled
>> safely.  In that case, ceph-osd isn't running (it's long-since failed),
>> and we'd need some other agent on the node to twiddle the light.  Do we
>> really want multiple things twiddling lights?
>
>
> Although this is really neat, I don't think ceph is the place to implement
> or even manage it.
>
> This should fall under a management tool's purview.

I would agree that any persistence/policy parts don't belong in the
OSD or the mons, but the remote access part where we reach across the
network and do something with libstoragemgmt is very useful to have
inside Ceph, because it means we can have management tools that just
speak librados and don't have to have their own remote access to all
the nodes in the system.

Put another way, I'd like it to be the case that people who want to
twiddle LEDs can write a ceph-mgr module that does that, rather than
having to push out a libstoragemgmt-enabled agent to the Ceph servers.

John

> That doesn't mean we couldn't keep some info on ceph itself, but in that
> case it should be kept either on the mon's kv config-key or ceph-mgr (e.g.,
> set of osds that actually support this, which led to turn if something
> misbehaves, whatever).
>
> And adding this sort of information to the osdmap is overkill. This is not
> something that the osds should be concerned about, but whatever tool/service
> monitors the osds.
>
> Besides, we'd be taking a stand on how to do something completely ceph
> unrelated - "how to blink your enclosure's leds". I'm guessing this will be
> hardware dependent; availability of the required libraries will be distro
> dependent; and people may want to implement this in totally different ways
> from whatever we concoct here.
>
> I don't see a good argument to delegate this to ceph.
>
>   -Joao
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
