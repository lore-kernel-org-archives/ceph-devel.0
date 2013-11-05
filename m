From: Sage Weil <sage@inktank.com>
Subject: Re: writing a ceph cliente for MS windows
Date: Tue, 5 Nov 2013 06:23:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net>
References: <52780140.6090409@kepler.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50396 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3KEOXv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 09:23:51 -0500
In-Reply-To: <52780140.6090409@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas Michels <asalas@kepler.cl>
Cc: ceph-devel@vger.kernel.org

Hi Alphe,

On Mon, 4 Nov 2013, Alphe Salas Michels wrote:
> Good day developers!
> 
> I would like to propose to the one interested  work with me to develop a ceph
> cliente for MS windows world, Basing us on dokanFS.
> 
> My company is a ceph enthousiast that use on a dayly basis ceph and that need
> both transfer speed and big expendable and cheap storage.
> My company is specialised in data recovery and we want to participate to ceph
> effort by bringing a ceph cliente for windows.

Awesome!

> Our experience shows us that the best gateway is each clientes being its own
> gateway, instead of having a bottle neck server or a cluster of bottle neck
> servers as gateway (FTP, samba, SFTP,webdav, s3, etc..).
> 
> We already did some research in that domain.
> 
> Dokan FS is an intent  to write an opensource fuse like cliente for MS
> windows.
> 
> More information on DOKANFS can be triggered here
> http://dokan-dev.net/en/download/
> 
> Positive points of using DOKANFS.
> 
> - its opensourced and well licenced mit licence, gpl licence and lgpl licence.
> 
> Negative point of using DOKAN FS.
> - unreachable author
> - Poor documentation . Dev comments in japanese.
> - Work in progress so it is unstable and needs to be updated, debugged and
> maintained by a MS Windows file system expert developper.

I am not very familiar with windows storage APIs, but somebody told me 
at once point there were several interfaces against which a new file 
system could be implemented, everything from a full in-kernel driver to 
something that is explorer-based.  Are any of those suitable?  Using a 
potentially abandoned fuse-like layer makes me a bit nervous.

That said,
 
> I try past year to do a merge from ceph-fuse to dokanfs
> here are what I learnt.
> - Ceph-fuse and related source code is around 60 000 lines of code.
> - Ceph protocol isn t documented so it is like trying to draw a map of america
> using only a sextan and a compass.
> 
> Those led me to those conclusions:
> - I can t do it alone.
> - It is easier to draw down the ceph protocol way to work from kernel/fs/ceph
> sources and mount.ceph
> - Ceph depending libraries may be unexistant or not up to date in their port
> on MS Windows (cygwin)

I think the most sane path should be to make libcephfs sufficiently 
portable to build on windows (or cygwin).  For the bits used by the 
client-side coe, I don't think there should be much in the way of 
dependencies, and the main challenge would be untangling the build for 
the necessary pieces out from the rest of Ceph.

Have you seen the wip-port portability work that is currently underway by 
Noah and Alan?  That may solve many of the cygwin problems you are seeing 
today.

> - MS file system specialist are hard do find in the "open source libre world"
> so I will try in the commercial world.
> 
> The commercial world has some problems too. They need ceph protocol draft to
> implemente it to their own product They will have licencing /commercial
> politics that infringe lgpl, and hide that most of the work is done by people
> other than them. They will not participate in a financial way to ceph
> enhancement and growth.

I don't think reimplementing the client code is an efficient way forward.  
Unless the goal is a pure kernel implementation...but a significant 
ongoing investment in development resources would be needed for that going 
forward.  I suspect that is a challenge for a platform that does not 
typically rally that sort of community effort.

The easiest thing is of course just to use CIFS and Samba (which works 
today).  A fuse-like approach is probably a reasonably middle ground (both 
in initial effort and maintainability going forward)...

sage
