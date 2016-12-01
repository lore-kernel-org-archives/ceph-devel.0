From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: disk enclosure LEDs
Date: Thu, 1 Dec 2016 13:02:17 +0000
Message-ID: <66419e0b-ee15-3782-0f10-cd25acfcfa3c@suse.de>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33355 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758311AbcLANCU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 08:02:20 -0500
In-Reply-To: <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 12/01/2016 12:15 AM, John Spray wrote:
> On Wed, Nov 30, 2016 at 7:37 PM, Joao Eduardo Luis <joao@suse.de> wrote:
>> On 11/30/2016 04:51 PM, Sage Weil wrote:
>>>
>>> Since this is in a reasonably usable state, I think It's time for us to
>>> figure out how we are going to do this in ceph.
>>>
>>> A few ideas:
>>>
>>>  ceph osd identify osd.123    # blink for a few seconds?
>>>
>>> or
>>>
>>>  ceph osd ident-led-on osd.123  # turn on
>>>  ceph osd ident-led-off osd.123  # turn off
>>>  ceph osd fault-led-on osd.123  # turn on
>>>  ceph osd fault-led-off osd.123  # turn off
>>>
>>> This would mean persistently recording the LED state in the OSDMap.  And
>>> it would mean ceph-osd is the one twiddling the LEDs.  But that might not
>>> be the way to go in all cases.  For example, if we have an OSD that fails,
>>> once we confirm that we've healed (and don't need that OSDs data) we'd
>>> probably want to set the fault light so that the disk can be pulled
>>> safely.  In that case, ceph-osd isn't running (it's long-since failed),
>>> and we'd need some other agent on the node to twiddle the light.  Do we
>>> really want multiple things twiddling lights?
>>
>>
>> Although this is really neat, I don't think ceph is the place to implement
>> or even manage it.
>>
>> This should fall under a management tool's purview.
>
> I would agree that any persistence/policy parts don't belong in the
> OSD or the mons, but the remote access part where we reach across the
> network and do something with libstoragemgmt is very useful to have
> inside Ceph, because it means we can have management tools that just
> speak librados and don't have to have their own remote access to all
> the nodes in the system.
>
> Put another way, I'd like it to be the case that people who want to
> twiddle LEDs can write a ceph-mgr module that does that, rather than
> having to push out a libstoragemgmt-enabled agent to the Ceph servers.

One thing would be to provide some *optional* package with a small 
daemon, or even a plugin for osds, that would handle led twiddling for 
users if they so wished.

Another totally different thing is to tie this up to Ceph so tightly 
that you can't really have one without the other. That feels a lot like 
systemd's approach to do all things, regardless of whether you really 
want it doing them or not.

I don't believe Ceph should be in the LED twiddling business, no only 
because this should be a management/monitoring tool's business, but also 
because (as Piotr mentioned) we'd be opening a new vector for issues 
that should not have anything to do with Ceph.

But assuming that's not the prevailing opinion and this does go forth, 
at least make it pluggable enough that we don't end up depending on 
libstoragemgmt to build the osd, ceph-mgr or anything else.

   -Joao
