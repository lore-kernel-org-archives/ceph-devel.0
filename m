From: Sage Weil <sage@newdream.net>
Subject: Re: disk enclosure LEDs
Date: Fri, 2 Dec 2016 14:23:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal> <eb52d1a8-8058-b57b-1585-828385953919@suse.de> <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com> <20161202092301.f65vgyjrssujfyrj@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60981 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934146AbcLBOXm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2016 09:23:42 -0500
In-Reply-To: <20161202092301.f65vgyjrssujfyrj@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 2 Dec 2016, Lars Marowsky-Bree wrote:
> On 2016-12-01T00:15:25, John Spray <jspray@redhat.com> wrote:
> 
> > Put another way, I'd like it to be the case that people who want to
> > twiddle LEDs can write a ceph-mgr module that does that, rather than
> > having to push out a libstoragemgmt-enabled agent to the Ceph servers.
> 
> I'm not sure I agree.
> 
> I understand some of the motivation, but the key use cases where I'd
> want to "twiddle LEDs" involve enclosures that either don't yet have an
> OSD deployed (e.g., where to plug in the new disk), or where the OSD has
> failed (and may not even be able to start).
> 
> And I don't want to have to maintain multiple paths for interacting with
> the enclosures.

I agree with John that it would be great to have ceph-mgr plugins doing 
this sort of thing.  But the OSD can't be the only path, and I also don't 
like the idea of multiple paths.

The problem is that there needs to be something on the hosts that's doing 
this, and I don't want to just ignore it and hope some other layer solves 
it; years have gone by and nobody has done it, and I'd like to 
avoid a fragmented approach if we can.

On the other hand, if we simply make an opinionated choice about some 
other per-host agent service, like we did in the original Calamari (which 
used salt and zeromq, IIRC), we'll probably end up offending more users 
than we please.

Perhaps the way forward is to pick *some* external host agent and service 
to start with and ensure that it is integrated into ceph-mgr in a 
pluggable way such that we have (1) the osd:device mappings available, (2) 
a standard API for working with LEDs etc, and (3) a working plugin for 
twiddling the LEDs, but ensure that other "disk services" backends can 
also be used?

sage


