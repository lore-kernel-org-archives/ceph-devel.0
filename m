From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: disk enclosure LEDs
Date: Mon, 5 Dec 2016 19:41:05 +0100
Message-ID: <20161205184105.3agjcjy4ufb7smzg@suse.de>
References: <20161202092301.f65vgyjrssujfyrj@suse.de>
 <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com>
 <BLUPR0201MB1524F8910A0625ECACC4B29AE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CALe9h7fJOM2vrxAoi+=xdc01z0kkjpH8048bFe1wF1pBw1yVsQ@mail.gmail.com>
 <20161205125836.lxcbv5ai5qdavitr@suse.de>
 <CALe9h7esr-SwWis58JLKnjCF0y2Rcj3116nNVKNdrrqBPRW-0A@mail.gmail.com>
 <865BAEF1-BA1D-44E7-A096-14A9FAB84A79@quantum.com>
 <BLUPR0201MB1524F23AC0ECA14A043F2BD5E8830@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34297 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbcLESyA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Dec 2016 13:54:00 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37B8CABD3
        for <ceph-devel@vger.kernel.org>; Mon,  5 Dec 2016 18:41:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB1524F23AC0ECA14A043F2BD5E8830@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2016-12-05T18:02:08, Allen Samuels <Allen.Samuels@sandisk.com> wrote:

> I'm indifferent to agent vs. agent-less.
> 
> I *believe* that having a ceph-private distribution is easier/simpler/more reliable than trying to layer over some other system (ansible, salt, etc.) [i.e., I agree with John]. But this isn't a strongly held belief.
> 
> I'm *metaphysically certain* that whatever distribution scheme is adopted that it not be optional. A large barrier to adoption of Ceph today is the lack of "middle-ware" that handles infrequent operational events (node addition/removal, media failure/recovery, migration, etc.). IMO, this middle-ware will have to be a standard part of Ceph, i.e., fully functional "out of the  box" without site-specific twiddling (though having a mechanism to insert site-specific stuff is fine with me, it just can't be *required*). 
> 
> In my mind, the distribution scheme is the next step in the evolution of Ceph-mgr. It's what's missing :)

I see the benefits of having a ceph-specific agent for hardware
interaction. However, that then shifts the problem for bootstrapping
said Ceph agent.

And when you open the can of worms that is server addition/removal, etc
we start hitting the question of either spinning up a distribution
mechanism as well.

When we want to look at container-izing Ceph in hyper-converged
environments, this gets even worse.

e.g., the cephalopod turns into a cephaloblob.  (Sorry. I'm terrible
with puns.)

I need a mechanism for interacting with enclosures (to stick with the
example), but I don't need it to be part of Ceph, since I need it for
other parts of my infrastructure too anyway.

If it's part of Ceph, I end up writing a special case for Ceph.

And I need a way to handle it when Ceph itself isn't around yet; how do
I blink an enclosure that receives a new disk? Ah, I pre-register a
given enclosure with Ceph, before an OSD is even created. I know Ceph
has many tentacles, but ... ;-)


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

