From: John Spray <jspray@redhat.com>
Subject: Re: disk enclosure LEDs
Date: Mon, 5 Dec 2016 19:28:22 +0000
Message-ID: <CALe9h7caW+KBV5r7P5Ps_1NFtfhTmL=B=MDLN9822q7EqaHrZA@mail.gmail.com>
References: <20161202092301.f65vgyjrssujfyrj@suse.de> <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com>
 <BLUPR0201MB1524F8910A0625ECACC4B29AE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CALe9h7fJOM2vrxAoi+=xdc01z0kkjpH8048bFe1wF1pBw1yVsQ@mail.gmail.com>
 <20161205125836.lxcbv5ai5qdavitr@suse.de> <CALe9h7esr-SwWis58JLKnjCF0y2Rcj3116nNVKNdrrqBPRW-0A@mail.gmail.com>
 <865BAEF1-BA1D-44E7-A096-14A9FAB84A79@quantum.com> <BLUPR0201MB1524F23AC0ECA14A043F2BD5E8830@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <20161205184105.3agjcjy4ufb7smzg@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35592 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbcLET3K (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2016 14:29:10 -0500
Received: by mail-qk0-f176.google.com with SMTP id n204so357092731qke.2
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2016 11:28:43 -0800 (PST)
In-Reply-To: <20161205184105.3agjcjy4ufb7smzg@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 5, 2016 at 6:41 PM, Lars Marowsky-Bree <lmb@suse.com> wrote:
> On 2016-12-05T18:02:08, Allen Samuels <Allen.Samuels@sandisk.com> wrote:
>
>> I'm indifferent to agent vs. agent-less.
>>
>> I *believe* that having a ceph-private distribution is easier/simpler/more reliable than trying to layer over some other system (ansible, salt, etc.) [i.e., I agree with John]. But this isn't a strongly held belief.
>>
>> I'm *metaphysically certain* that whatever distribution scheme is adopted that it not be optional. A large barrier to adoption of Ceph today is the lack of "middle-ware" that handles infrequent operational events (node addition/removal, media failure/recovery, migration, etc.). IMO, this middle-ware will have to be a standard part of Ceph, i.e., fully functional "out of the  box" without site-specific twiddling (though having a mechanism to insert site-specific stuff is fine with me, it just can't be *required*).
>>
>> In my mind, the distribution scheme is the next step in the evolution of Ceph-mgr. It's what's missing :)
>
> I see the benefits of having a ceph-specific agent for hardware
> interaction. However, that then shifts the problem for bootstrapping
> said Ceph agent.

Bootstrapping would be the same as we already have for installing OSDs
and MDSs.  So ceph-deploy/ceph-ansible/whatever needs to be able to do
the same thing for the per-host agent that it currently does for OSDs,
no overall increase in complexity.

> And when you open the can of worms that is server addition/removal, etc
> we start hitting the question of either spinning up a distribution
> mechanism as well.
>
> When we want to look at container-izing Ceph in hyper-converged
> environments, this gets even worse.

I'm imagining that in a container-per-service model, where something
external has configured the OSD containers to have access to the block
device that they will run on, it doesn't seem unreasonable to have the
same configuration process set up the ceph agent container with access
to all the OSD block devices.  What are your thoughts about how this
would (or wouldn't) work?

>
> e.g., the cephalopod turns into a cephaloblob.  (Sorry. I'm terrible
> with puns.)
>
> I need a mechanism for interacting with enclosures (to stick with the
> example), but I don't need it to be part of Ceph, since I need it for
> other parts of my infrastructure too anyway.
>
>
> If it's part of Ceph, I end up writing a special case for Ceph.

I think this would cease to be a problem for you if we just had a flag
in Ceph to disable its own smartmontools type stuff?  That way when
someone was using an external tool there would be no conflict.

There is some duplication of effort, but I don't think that's
intrinsically problematic: I predict that we'll always have many users
who do not take up any of the external tools and will benefit from the
built-in Ceph bits.

> And I need a way to handle it when Ceph itself isn't around yet; how do
> I blink an enclosure that receives a new disk? Ah, I pre-register a
> given enclosure with Ceph, before an OSD is even created. I know Ceph
> has many tentacles, but ... ;-)

While at runtime we shouldn't have two agents competing to manage the
same device, I think it is reasonable to have a separate piece of
software that does installation vs. does the ongoing monitoring.  We
shouldn't let the constraints over installation (especially the need
to operate on cephless machines) restrict how we manage systems
through their life cycles.  Again, I don't think the built-in Ceph
functionality is mutually exclusive with having a good external
installation tool that touches some of the same functionality.

John


>
>
> Regards,
>     Lars
>
> --
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar Wilde
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
