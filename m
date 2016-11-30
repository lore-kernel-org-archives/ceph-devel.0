From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: disk enclosure LEDs
Date: Wed, 30 Nov 2016 19:37:26 +0000
Message-ID: <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38477 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754538AbcK3Thc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 14:37:32 -0500
In-Reply-To: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 11/30/2016 04:51 PM, Sage Weil wrote:
> Since this is in a reasonably usable state, I think It's time for us to
> figure out how we are going to do this in ceph.
>
> A few ideas:
>
>  ceph osd identify osd.123    # blink for a few seconds?
>
> or
>
>  ceph osd ident-led-on osd.123  # turn on
>  ceph osd ident-led-off osd.123  # turn off
>  ceph osd fault-led-on osd.123  # turn on
>  ceph osd fault-led-off osd.123  # turn off
>
> This would mean persistently recording the LED state in the OSDMap.  And
> it would mean ceph-osd is the one twiddling the LEDs.  But that might not
> be the way to go in all cases.  For example, if we have an OSD that fails,
> once we confirm that we've healed (and don't need that OSDs data) we'd
> probably want to set the fault light so that the disk can be pulled
> safely.  In that case, ceph-osd isn't running (it's long-since failed),
> and we'd need some other agent on the node to twiddle the light.  Do we
> really want multiple things twiddling lights?

Although this is really neat, I don't think ceph is the place to 
implement or even manage it.

This should fall under a management tool's purview.

That doesn't mean we couldn't keep some info on ceph itself, but in that 
case it should be kept either on the mon's kv config-key or ceph-mgr 
(e.g., set of osds that actually support this, which led to turn if 
something misbehaves, whatever).

And adding this sort of information to the osdmap is overkill. This is 
not something that the osds should be concerned about, but whatever 
tool/service monitors the osds.

Besides, we'd be taking a stand on how to do something completely ceph 
unrelated - "how to blink your enclosure's leds". I'm guessing this will 
be hardware dependent; availability of the required libraries will be 
distro dependent; and people may want to implement this in totally 
different ways from whatever we concoct here.

I don't see a good argument to delegate this to ceph.

   -Joao
