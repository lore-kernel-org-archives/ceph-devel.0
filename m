From: Sage Weil <sage@newdream.net>
Subject: Re: Mon identity in a dynamic environment
Date: Wed, 5 Jul 2017 15:05:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707051504230.3424@piezo.novalocal>
References: <D538DFE2.8B37F%travis.nielsen@quantum.com> <alpine.DEB.2.11.1705111521580.18953@piezo.novalocal> <3B431751-D3C8-4E01-B2D8-91A58598235D@quantum.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1905000904-1499267145=:3424"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38700 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbdGEPFp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jul 2017 11:05:45 -0400
In-Reply-To: <3B431751-D3C8-4E01-B2D8-91A58598235D@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <Bassam.Tabbara@Quantum.com>
Cc: Travis Nielsen <Travis.Nielsen@Quantum.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1905000904-1499267145=:3424
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Jul 2017, Bosom Tabby wrote:
> Hi Sage,
> 
> Finally getting around to this one.

Great!
 
> > I think this is the way to go, and I don't think it will be *that* 
> > involved.  Probably it just requires an option to supplement public_addr 
> > with bind_addr.  As long as the Messenger myaddr field is populated with 
> > the public_addr (and not bind_addr) field I suspect everything will Just 
> > Work.  Peers connecting to us will see the public_addr for their 
> > getpeeraddr config and that's the one that the messenger will advertise 
> > during its handshake; bind_addr would be used *only* by the actual bind 
> > call.  Does that seem reasonable?
> 
> There is a fair amount of logic around public_addr that makes this a little more
> complex. For example, we automatically select the public_addr using pick_addresses
> when public_network is set. Also we have logic that attempts to discover available ports,
> and “rebinds” the socket which we would want to carry over to the proposed “bind_addr”.
> 
> I think it might be easier to go in the other direction. i.e, introduce “mon_advertise_addr”
> which overrides msgr->my_inst->addr and be used on the network to reach the mons. If
> empty (default) advertise_addr will be set to the effective value of public_addr. If set it must be an 
> ip address or resolvable DNS name. If a port is specified it will be used, otherwise
> CEPH_MON_PORT is assumed.
> 
> Finally, by using the “mon_” prefix this makes it clear that this is limited to MONs where its needed.
> While its possible to do with for OSD, MDS, etc. I think it unnecessarily increases the config surface area.
> 
> What do you think?

Yeah, that sounds reasonable to me.

Can you elaborate on how the kubernetes side of this approach will work?

Thanks!
sage
--8323329-1905000904-1499267145=:3424--
