From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Wed, 13 Apr 2016 09:06:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604122137200.24055@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com> <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz> <alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
 <8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz> <alpine.DEB.2.11.1604121525020.29593@cpach.fuggernut.com> <2CBEF339-052C-42D8-A6EA-5BA9C5B8DE9F@schermer.cz> <alpine.DEB.2.11.1604121639590.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45149 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758200AbcDMNGP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 09:06:15 -0400
In-Reply-To: <alpine.DEB.2.11.1604121639590.29593@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Schermer <jan@schermer.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Tue, 12 Apr 2016, Jan Schermer wrote:
> Who needs to have exactly the same data in two separate objects 
> (replicas)? Ceph needs it because "consistency"?, but the app (VM 
> filesystem) is fine with whatever version because the flush didn't 
> happen (if it did the contents would be the same).

While we're talking/thinking about this, here's a simple example of why 
the simple solution (let the replicas be out of sync), which seems 
reasonable at first, can blow up in your face.

If a disk block contains A and you write B over the top of it and then 
there is a failure (e.g. power loss before you issue a flush), it's okay 
for the disk to contain either A or B.  In a replicated system, let's say 
2x mirroring (call them R1 and R2), you might end up with B on R1 and A 
on R2.  If you don't immediately clean it up, then at some point down the 
line you might switch from reading R1 to reading R2 and the disk block 
will go "back in time" (previously you read B, now you read A).  A 
single disk/replica will never do that, and applications can break.

For example, if the block in question is a journal block, we might see B 
the first time (valid journal!), the do a bunch of work and 
journal/write new stuff to the blocks that follow.  Then we lose 
power again, lose R1, replay the journal, read A from R2, and stop journal 
replay early... missing out on all the new stuff.  This can easily corrupt 
a file system or database or whatever else.

It might sound unlikely, but keep in mind that writes to these 
all-important metadata and commit blocks are extremely frequent.  It's the 
kind of thing you can usually get away with, until you don't, and then you 
have a very bad day...

sage
