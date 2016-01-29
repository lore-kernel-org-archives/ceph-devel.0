From: Sage Weil <sage@newdream.net>
Subject: Re: Journal Disk Cache - on or off
Date: Fri, 29 Jan 2016 12:43:43 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601291241130.28963@cpach.fuggernut.com>
References: <CAKtk8hceHCVqZpiA0cCu-17-oJmTgvUihHJujyTcggpzYc-75Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50822 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbcA2Rnb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 12:43:31 -0500
In-Reply-To: <CAKtk8hceHCVqZpiA0cCu-17-oJmTgvUihHJujyTcggpzYc-75Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <guangyy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, rwheeler@redhat.com

On Fri, 29 Jan 2016, Guang Yang wrote:
> Hi Sage,
> I found a thread discussing whether we could turn on disk cache with
> new kernel or not -
> http://www.spinics.net/lists/ceph-devel/msg06173.html
> 
> From within that thread, you mentioned that since the fsync/fdatasync
> would flush the disk cache as well, we could actually turn on the
> cache without worrying about the data safety.

Yeah, any vaguely modern kernel will do a proper flush to the device; no 
need to worry about the disk cache.
 
> Is that true if journal_dio is being used (by default), in which case
> O_DIRECT | O_DSYNC is being used to write journal rather than
> fsync(2)?

Right.  O_DSYNC triggers a flush at the SCSI (or virtio) level, so these 
journal [A]IOs are fully synchronous all the way to the platter.

sage
