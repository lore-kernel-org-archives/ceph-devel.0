From: Sage Weil <sage@newdream.net>
Subject: Re: Status of ceph ITP?
Date: Tue, 30 Nov 2010 10:21:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
References: <1290365977.9821.3.camel@clint-MacBookPro>
 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
 <1290436452.9821.5.camel@clint-MacBookPro> <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
 <1291075213.14018.101.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43612 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592Ab0K3SQZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 13:16:25 -0500
In-Reply-To: <1291075213.14018.101.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

Hey Laszlo,

These changes are great!  I incorporated all of your changes into 
ceph.git, and also fixed up the ceph.spec.in to include the missed gui 
files.

> I've changed the way debug parts of the packages are handled. It may
> sound harsh and so I'm open to revert that back to your way.

Yay, the old way was definitely a hack.
 
> Sage: may you let me handle the packaging for Debian and Ubuntu? So you
> can find more time working on ceph itself as it has some inconsistency
> as well. Binaries without manpages like cephfs and radosacl ; somewhere
> the manpage contains an example which is not a valid command (at least
> in v0.23 , it passed midnight and now I can't remember which one is it).

Whatever you think would work best.  I would like to keep the debian/ 
files in some form or another (although whether they live in ceph.git is 
an open question) since I build packages for sid, squeeze, and lenny for 
the ceph.newdream.net site, and would like to do so immediately when a 
release is made.  But if you can handle the packaging changes and 
uploading to debian that would (continue to be) helpful.  Or if the 
packaging stuff is managed by you separately, but still available 
somewhere for me pull and build my packages against.  What do you suggest?

> Are you sure that ceph should depend on hdparm? What if my box has SCSI,
> SAS or other disk that isn't [sP]ATA? Yes, there's sdparm, but do you
> use it directly from ceph? Should it be a recommendation instead?

Currently it's only used by os/FileJournal.cc to check for a journal on a 
block device with write caching off.  This is only a problem for kernels 
prior to 2.6.33 (which unfortunately includes squeeze!), so I'm inclined 
to keep it for now.  In any case, though, the code fails gracefully if 
it's not found, so a recommendation would work.  And yeah, it doesn't try 
sdparm if hdparm doesn't do the trick.  But it catches most administrator 
error as is, which is the goal.

> If others agree, I'll upload it in some days. It'll sit into the NEW
> queue and may take a while to be officially accepted.

Great!  There are a handful of bug fixes I'd like to roll into v0.23.2 
first, if it isn't too much trouble.  I can do that today.  

Clint, do you see any remaining issues I should fix first?

Thanks!
sage
