From: Alan Johnson <alanj@supermicro.com>
Subject: RE: disk enclosure LEDs
Date: Fri, 2 Dec 2016 17:57:28 +0000
Message-ID: <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de>
 <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mg1.supermicro.com ([207.212.57.75]:9730 "EHLO
        mg1.supermicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758895AbcLBSSE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2016 13:18:04 -0500
In-Reply-To: <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Yin <alexy@supermicro.com>

As a hardware vendor we would like some sort of API to hook into - we do have a proprietary way of identifying failing devices but would rather conform to something more standard within the Ceph arena.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Allen Samuels
Sent: Friday, December 02, 2016 11:57 AM
To: Sage Weil; Lars Marowsky-Bree
Cc: Ceph Development
Subject: RE: disk enclosure LEDs

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel- 
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Friday, December 02, 2016 6:24 AM
> To: Lars Marowsky-Bree <lmb@suse.com>
> Cc: Ceph Development <ceph-devel@vger.kernel.org>
> Subject: Re: disk enclosure LEDs
> 
> On Fri, 2 Dec 2016, Lars Marowsky-Bree wrote:
> > On 2016-12-01T00:15:25, John Spray <jspray@redhat.com> wrote:
> >
> > > Put another way, I'd like it to be the case that people who want 
> > > to twiddle LEDs can write a ceph-mgr module that does that, rather 
> > > than having to push out a libstoragemgmt-enabled agent to the Ceph servers.
> >
> > I'm not sure I agree.
> >
> > I understand some of the motivation, but the key use cases where I'd 
> > want to "twiddle LEDs" involve enclosures that either don't yet have 
> > an OSD deployed (e.g., where to plug in the new disk), or where the 
> > OSD has failed (and may not even be able to start).
> >
> > And I don't want to have to maintain multiple paths for interacting 
> > with the enclosures.
> 
> I agree with John that it would be great to have ceph-mgr plugins 
> doing this sort of thing.  But the OSD can't be the only path, and I 
> also don't like the idea of multiple paths.
> 
> The problem is that there needs to be something on the hosts that's 
> doing this, and I don't want to just ignore it and hope some other 
> layer solves it; years have gone by and nobody has done it, and I'd 
> like to avoid a fragmented approach if we can.
> 
> On the other hand, if we simply make an opinionated choice about some 
> other per-host agent service, like we did in the original Calamari 
> (which used salt and zeromq, IIRC), we'll probably end up offending 
> more users than we please.
> 
> Perhaps the way forward is to pick *some* external host agent and 
> service to start with and ensure that it is integrated into ceph-mgr 
> in a pluggable way such that we have (1) the osd:device mappings 
> available, (2) a standard API for working with LEDs etc, and (3) a 
> working plugin for twiddling the LEDs, but ensure that other "disk services" backends can also be used?

I think it's important to separate this problem into two pieces: ceph-specific and platform-specific.

The ceph-specific part of the problem is to create a single abstraction and mechanism so that upper-level tools (ceph-mgr, GUIs, workflow scripts, etc.) can manipulation the abstraction without worrying about the implementation details. I'm completely with John that ceph-mgr is the right place for the upper-layer to terminated. Ultimately, we'll have infrastructure that ties the physical state of the drives (power up/down, lights on/off, etc.) more closely to the operational state of the system -- this is an area where more standardized automation will remove a significant barrier to wide-spread deployments.

The platform-specific part definitely should be pluggable/configurable/soft/manipulable, etc. It'll be quite some time (if ever) before something like libstoragemgmt becomes a reliable, universal, standard interface. We can't let that hold back the development of the upper-level infrastructure stuff.

So, I'd vote for having an API termination in ceph-mgr. Have the mgr contact the destination system (the OSD is *NOT* the right path) to perform the action. Then do something like invoke a configurable shell script (something that's configurable) to perform the actual operation. 

 
> 
> sage
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
