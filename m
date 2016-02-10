From: Sage Weil <sweil@redhat.com>
Subject: Re: osd dm-crypt key management, part... deux?
Date: Wed, 10 Feb 2016 08:38:40 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602100831250.28396@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1601262106390.6524@cpach.fuggernut.com> <56BB0E20.9000800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbcBJNiV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Feb 2016 08:38:21 -0500
In-Reply-To: <56BB0E20.9000800@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milan Broz <gmazyland@gmail.com>, lmb@suse.de
Cc: ceph-devel@vger.kernel.org

On Wed, 10 Feb 2016, Milan Broz wrote:
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
> > 
> > 3- We built a generic "config-key" storage service into the monitor that 
> > lets you restrict access to certain key/value pairs based on your 
> > (cephx) authentication key, intending that the osd dm-crypt keys be stored 
> > there.
> 
> My (upstream cryptsetup) plan is to have LUKS2 configurable keyslot and these
> should allow plugins that can directly fetch the key for example.
> 
> In fact proof-of-concept code was inspired by Ceph OSD use case and
> allows fetching key from remote server through libssh (it expects
> ssh keys configured such way, that you can run ssh to some server
> with public key auth without password - but that's just example).
> 
> In LUKS2 header then we store just ssh server/user/dir
> https://gitlab.com/cryptsetup/cryptsetup/blob/wip-luks2/misc/luks2_keyslot_example/keyslot_test.c
> (please note it is just wip example of standalone binary, interface will change,
> and currently it uses real volume key, not unlocking passphrase)
> 
> I can imagine that in long-term there can be simple keyslot using
> cephx auth as well or whatever Ceph will need.

This sounds really promising! I wish it were arriving a bit sooner... :/

> > 5- Lars observes that any solution is incomplete if we don't *also* 
> > encrypt the swap devices.  (I think we don't need to worry about the boot 
> > disks, though, unless we're paranoid about /var/log/ceph?)
> 
> It depends on your threat model...
> 
> But you can easily create encrypted swap using key from /dev/urandom
> (iow regenerated every boot).
> 
> This is common solution if you do not store hibernation data in swap.
> (Just one line in crypttab/fstab.)

Good to know!  Lars, does this fully address your concerns?  I forget if 
the boot drive (and /var/log) was part of your concern.

sage
