From: John Spray <jspray@redhat.com>
Subject: Re: disk enclosure LEDs
Date: Mon, 5 Dec 2016 12:44:51 +0000
Message-ID: <CALe9h7fJOM2vrxAoi+=xdc01z0kkjpH8048bFe1wF1pBw1yVsQ@mail.gmail.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de> <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de> <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com> <BLUPR0201MB1524F8910A0625ECACC4B29AE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33792 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbcLEMpY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2016 07:45:24 -0500
Received: by mail-qt0-f175.google.com with SMTP id n6so312484318qtd.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2016 04:45:12 -0800 (PST)
In-Reply-To: <BLUPR0201MB1524F8910A0625ECACC4B29AE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Alan Johnson <alanj@supermicro.com>, Sage Weil <sage@newdream.net>, Lars Marowsky-Bree <lmb@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Yin <alexy@supermicro.com>

On Fri, Dec 2, 2016 at 6:05 PM, Allen Samuels <Allen.Samuels@sandisk.com> wrote:
> I agree. For the HW vendors, I think it's Ceph's job to execute some kind of command on the local node (presumably, some kind of shell command). The vendor should take over from there.

Assuming that we want Ceph to act as a channel for remote execution,
there are two approaches:
 * Put a ceph-supervisor service on all our nodes, and use that to
terminate the remote commands.  This daemon would also be the place
for reporting per-host stats that we currently send multiple times
through each OSD.
 * Build a SSH/salt remote execution client into ceph-mgr, and modify
installation tools to store a privileged key in Ceph so that it can
remote to the nodes.

Both of these are possible.  They are essentially agent vs. agentless
approaches.

One can argue either way:
 * "sshd already exists, why would we write our own daemon that
enables remote execution?"
 * "we already have our own protocol and crypto, adding remote
execution is simple so why would we bring in a whole separate set of
keys?"

I have a preference for creating an agent, because we would use it for
monitoring as well as for remote execution.  However, this is really
only useful if somebody wants to use it: when management tools have
their own agents, it's likely they won't use whatever we build into
Ceph.

Question to the OpenAttic folks, who afaik are the only ones on the
thread actively building tools like this: if ceph-mgr modules could do
arbitrary command remote execution on OSD nodes, is that what you
would use for blinking LEDs?  How would you wire that up to the rest
of your stack?

John

> I'd assume that one version of the shell command would be a simple wrapper around libstoragemgmt. So you'd have your choice of either extending libstoragemgmt, or writing a command-line utility that did your special thing (whatever it was).
>
>
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
>> -----Original Message-----
>> From: Alan Johnson [mailto:alanj@supermicro.com]
>> Sent: Friday, December 02, 2016 9:57 AM
>> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
>> <sage@newdream.net>; Lars Marowsky-Bree <lmb@suse.com>
>> Cc: Ceph Development <ceph-devel@vger.kernel.org>; Alex Yin
>> <alexy@supermicro.com>
>> Subject: RE: disk enclosure LEDs
>>
>> As a hardware vendor we would like some sort of API to hook into - we do
>> have a proprietary way of identifying failing devices but would rather
>> conform to something more standard within the Ceph arena.
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Allen Samuels
>> Sent: Friday, December 02, 2016 11:57 AM
>> To: Sage Weil; Lars Marowsky-Bree
>> Cc: Ceph Development
>> Subject: RE: disk enclosure LEDs
>>
>> > -----Original Message-----
>> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> > owner@vger.kernel.org] On Behalf Of Sage Weil
>> > Sent: Friday, December 02, 2016 6:24 AM
>> > To: Lars Marowsky-Bree <lmb@suse.com>
>> > Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> > Subject: Re: disk enclosure LEDs
>> >
>> > On Fri, 2 Dec 2016, Lars Marowsky-Bree wrote:
>> > > On 2016-12-01T00:15:25, John Spray <jspray@redhat.com> wrote:
>> > >
>> > > > Put another way, I'd like it to be the case that people who want
>> > > > to twiddle LEDs can write a ceph-mgr module that does that, rather
>> > > > than having to push out a libstoragemgmt-enabled agent to the Ceph
>> servers.
>> > >
>> > > I'm not sure I agree.
>> > >
>> > > I understand some of the motivation, but the key use cases where I'd
>> > > want to "twiddle LEDs" involve enclosures that either don't yet have
>> > > an OSD deployed (e.g., where to plug in the new disk), or where the
>> > > OSD has failed (and may not even be able to start).
>> > >
>> > > And I don't want to have to maintain multiple paths for interacting
>> > > with the enclosures.
>> >
>> > I agree with John that it would be great to have ceph-mgr plugins
>> > doing this sort of thing.  But the OSD can't be the only path, and I
>> > also don't like the idea of multiple paths.
>> >
>> > The problem is that there needs to be something on the hosts that's
>> > doing this, and I don't want to just ignore it and hope some other
>> > layer solves it; years have gone by and nobody has done it, and I'd
>> > like to avoid a fragmented approach if we can.
>> >
>> > On the other hand, if we simply make an opinionated choice about some
>> > other per-host agent service, like we did in the original Calamari
>> > (which used salt and zeromq, IIRC), we'll probably end up offending
>> > more users than we please.
>> >
>> > Perhaps the way forward is to pick *some* external host agent and
>> > service to start with and ensure that it is integrated into ceph-mgr
>> > in a pluggable way such that we have (1) the osd:device mappings
>> > available, (2) a standard API for working with LEDs etc, and (3) a
>> > working plugin for twiddling the LEDs, but ensure that other "disk services"
>> backends can also be used?
>>
>> I think it's important to separate this problem into two pieces: ceph-specific
>> and platform-specific.
>>
>> The ceph-specific part of the problem is to create a single abstraction and
>> mechanism so that upper-level tools (ceph-mgr, GUIs, workflow scripts, etc.)
>> can manipulation the abstraction without worrying about the
>> implementation details. I'm completely with John that ceph-mgr is the right
>> place for the upper-layer to terminated. Ultimately, we'll have infrastructure
>> that ties the physical state of the drives (power up/down, lights on/off, etc.)
>> more closely to the operational state of the system -- this is an area where
>> more standardized automation will remove a significant barrier to wide-
>> spread deployments.
>>
>> The platform-specific part definitely should be
>> pluggable/configurable/soft/manipulable, etc. It'll be quite some time (if
>> ever) before something like libstoragemgmt becomes a reliable, universal,
>> standard interface. We can't let that hold back the development of the
>> upper-level infrastructure stuff.
>>
>> So, I'd vote for having an API termination in ceph-mgr. Have the mgr contact
>> the destination system (the OSD is *NOT* the right path) to perform the
>> action. Then do something like invoke a configurable shell script (something
>> that's configurable) to perform the actual operation.
>>
>>
>> >
>> > sage
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> > info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
