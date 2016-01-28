From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: Re: osd dm-crypt key management, part... deux?
Date: Thu, 28 Jan 2016 09:53:55 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601280952120.6710@cpach.fuggernut.com>
References: <56A9E13E.8050508@suse.de> <56A9E2EC.8040000@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34680 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230AbcA1Oxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 09:53:44 -0500
In-Reply-To: <56A9E2EC.8040000@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joshua Schmid <jschmid@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 28 Jan 2016, Joshua Schmid wrote:
> 
> Hi Sage,
> 
> On 01/27/2016 03:26 PM, Sage Weil wrote:
> > We've had several partial starts to address this problem but haven't 
> > gotten anything over the line.  A quick summary:
> > 
> > 1- Currently we store dm-crypt keys in /etc/ceph/dmcrypt-keys/$osd_uuid, 
> > on the boot disk.  This lets you throw away OSD disk but not boot disks 
> > and doesn't help you if someone walks away with a whole server.
> > 
> > 2- SUSE had a pull request that made ceph-disk push/pull keys over (s)ftp.  
> > I can't find it now.. did it get closed?
> 
> It's here.
> 
> https://github.com/SUSE/ceph/commit/0f5644ef3d1b1a9a14be97717b9d8dfe0338b74d
> 
> > 
> > I suggest we do something simple:
> > 
> > 1- Update SUSE's ceph-disk changes to make it easy to plug in 
> > different key management strategies.
> 
> And there.
> 
> https://github.com/SUSE/ceph/commit/127a47ca7cf28f387d832da265f6955bb04107c3

Thanks!

> SUSE currently sticks with this solution since its pluggable and works
> fairly well. It may not be the cleanest solution to rely on an external
> tool(ftp) but until now there is simply no other option.
> 
> > 2- Implement a simple mon-based strategy upstream.  We've discussed this a 
> > fair bit in the past, and were getting stuck on the problem of where to 
> > store the key-fetching-key.  I.e., we want a key on the disk that you use 
> > to ask the monitor for the LUKS key, which you then provide to LUKS to 
> > unlock the actual encryption key.  This means that we need a unencrypted 
> > spot on the device to store it in.  Milan has indicated that putting it in 
> > a LUKS key slot would be a bad idea and difficult to maintain.  Instead, I 
> > propose we create a new GPT partition type called OSD_LOCKBOX (or 
> > similar), with a tiny filesystem and a few files indicating what to do.  
> > This will make it easy to store the info we need for the mon scheme, and 
> > to support new key management approaches later (we can put whatever we 
> > want there as long as it's not too big).
> 
> Sounds good! But i still see the possible scenario where you dump a
> whole rack with a MON + OSD. As a potential attacker, having these two
> components would grant you access to all the keys needed to decrypt the
> OSDdata. If I got understood it correctly that every MON should hold all
> available keys.

I think this is no different than a normal keyserver: if you steal the 
encrypted thing, and the keyserver, then the game is up.  In this case the 
mon is just acting as a keyserver.

Unless there are other tricks that the keyservers normally play?

> Some additions:
> 
> The MON should only hand out keys when authenticated or in a clean
> cluster context. So what i mean is basically some way to proof if the
> MON is not in a made up environment.

Like, a secret to decrypt the keyservers' keys might be erasure coded 
across the keyservers so that you can only decrypt when you have a quorum?

sage
