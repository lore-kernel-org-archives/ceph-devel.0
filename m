From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: Re: osd dm-crypt key management, part... deux?
Date: Thu, 28 Jan 2016 12:46:13 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601281244360.4107@cpach.fuggernut.com>
References: <56A9E13E.8050508@suse.de> <56A9E2EC.8040000@suse.de> <alpine.DEB.2.11.1601280952120.6710@cpach.fuggernut.com> <56AA42A4.7080406@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36657 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934378AbcA1RqC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 12:46:02 -0500
In-Reply-To: <56AA42A4.7080406@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joshua Schmid <jschmid@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 28 Jan 2016, Joshua Schmid wrote:
> >>> 2- Implement a simple mon-based strategy upstream.  We've discussed this a 
> >>> fair bit in the past, and were getting stuck on the problem of where to 
> >>> store the key-fetching-key.  I.e., we want a key on the disk that you use 
> >>> to ask the monitor for the LUKS key, which you then provide to LUKS to 
> >>> unlock the actual encryption key.  This means that we need a unencrypted 
> >>> spot on the device to store it in.  Milan has indicated that putting it in 
> >>> a LUKS key slot would be a bad idea and difficult to maintain.  Instead, I 
> >>> propose we create a new GPT partition type called OSD_LOCKBOX (or 
> >>> similar), with a tiny filesystem and a few files indicating what to do.  
> >>> This will make it easy to store the info we need for the mon scheme, and 
> >>> to support new key management approaches later (we can put whatever we 
> >>> want there as long as it's not too big).
> >>
> >> Sounds good! But i still see the possible scenario where you dump a
> >> whole rack with a MON + OSD. As a potential attacker, having these two
> >> components would grant you access to all the keys needed to decrypt the
> >> OSDdata. If I got understood it correctly that every MON should hold all
> >> available keys.
> > 
> > I think this is no different than a normal keyserver: if you steal the 
> > encrypted thing, and the keyserver, then the game is up.  In this case the 
> > mon is just acting as a keyserver.
> > 
> > Unless there are other tricks that the keyservers normally play?
> 
> The only difference between a dedicated keyserver and a MON is that you
> hopefully know where its physically located and can take precautions. So
> the problem(customer needs) we are facing is not only theft but the
> ability to just dump disks/nodes/racks without exposing sensitive data.
> 
> 
> > 
> >> Some additions:
> >>
> >> The MON should only hand out keys when authenticated or in a clean
> >> cluster context. So what i mean is basically some way to proof if the
> >> MON is not in a made up environment.
> > 
> > Like, a secret to decrypt the keyservers' keys might be erasure coded 
> > across the keyservers so that you can only decrypt when you have a quorum?
> > 
> sounds pretty good to me! that would cover all requirements i can
> currently think of..

I'm skeptical that's actually something we want to implement in the mon, 
though.  I think if you want that level of security (secret sharding 
across keyservers) you should use a real keyserver and not the mon.  I 
think if we cover the basic case, though, where we assume the monitor 
nodes are secure and separate from the OSDs, then that'll cover most 
users' needs.

sage

