From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Sat, 25 Feb 2012 05:51:20 -0200
Message-ID: <ork43bbbbb.fsf@livre.localdomain>
References: <orboos1qyu.fsf@livre.localdomain>
	<Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:47971 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752926Ab2BYHva (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 25 Feb 2012 02:51:30 -0500
In-Reply-To: <Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net> (Sage
	Weil's message of "Wed, 22 Feb 2012 22:04:07 -0800 (PST)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Feb 23, 2012, Sage Weil <sage@newdream.net> wrote:

> On Tue, 21 Feb 2012, Alexandre Oliva wrote:
>> This was supposed to fix bug 1946, and likely bug 1849 too, but it looks
>> like something's still missing for a complete fix.  fuse-unmounting
>> between touching a dir and creating a snapshot seems to help get correct
>> snapshot timestamp,

> Hmm, that sounds like ceph-fuse isn't sending the write flushsnap cap 
> message.  I forget.. have you tried the same with the kernel client?

Not recently enough that I'd remember exactly what I did.

However, I don't see how ceph-fuse could be the problem, given today's
experiments.  Here's what I just did (all with fuse):

create snapshot
check timestamps -> baseline
unmount
mount again
check timestamps -> same
restart mds
check timestamps -> same
unmount
mount again
check timestamps -> same
moved a tree into dir
check timestamps -> dir changed and snapshot unchanged, as expected
unmount
mount again
check timestamps -> same
restart mds
check timestamps -> snapshot changed to dir's; its size too!

After each umount, I checked that ceph-fuse was no longer running (it
sometimes remains running for a while after umount completes)

I've got full mds logs for this session, but they're kind of huge
(860M).  Please remind me how to upload them to your server.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
