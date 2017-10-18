From: Sage Weil <sage@newdream.net>
Subject: Re: Messenger V2
Date: Wed, 18 Oct 2017 18:12:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710181757050.24806@piezo.us.to>
References: <1508338218.21259.33.camel@suse.com> <alpine.DEB.2.11.1710181751311.24806@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:57559 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdJRSMM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Oct 2017 14:12:12 -0400
In-Reply-To: <alpine.DEB.2.11.1710181751311.24806@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 18 Oct 2017, Sage Weil wrote:
> On Wed, 18 Oct 2017, Ricardo Dias wrote:
> 
> > Hi,
> > 
> > By reading the old "msgr2 protocol" thread, and according to this
> > particular response (https://marc.info/?l=ceph-devel&m=147361359132535&
> > w=2), I understood that the idea is to allow a daemon/client to
> > instantiate a V2 msgr instance in a new port, while still allowing a V1
> > msgr instance to exist.
> > 
> > I'm starting to make some changes to the msgr code, and I'm planning to
> > allow the specification of the protocol (V1 or V2) in the constructor.
> > This allows to create two messengers instances each one using a
> > different protocol and bonded to different ports.
> > Does this make sense?
> > 
> > Also, since we want to support multiple Ceph daemons (multiplexing) in
> > the same process, what would be the preferable API (messenger <-> Ceph
> > daemon) to be user:
> > 
> > a) Instantiate a single Messenger object and share the instance between
> > the multiple "sub-daemons"
> > b) Each "sub-daemon" instantiates a Messenger object, and the internal
> > Messenger code will take care of the magic of re-using/sharing the
> > connections to the same peers.
> 
> I agree with Casey that (a) seems more attractive.  It'll require a bit of 
> reworking things, though.  Right now we have like 6 Messengers used by the 
> OSD.  I have a PR that eliminates several of them (by consolidating 
> heartbeats onto the main messengers), but enen with that we'll need 2 
> separate instances, one for the public network and one for the cluster 
> network.  So I suspect we'll still need some capability to have mulitple 
> Messenger instances share some internal state.

Perhaps a good first step here is to finish this PR

	https://github.com/ceph/ceph/pull/15067

I dropped it leading up to luminous because I was hitting some 
non-obvious bug and other things were higher priority.  It's helpful on 
its own, though, and probably necessary lead-up to the multiplexing.  
Needs rebase and testing and review...

sage
