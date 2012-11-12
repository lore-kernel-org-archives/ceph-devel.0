From: Sage Weil <sage@inktank.com>
Subject: Re: Disabling journal
Date: Mon, 12 Nov 2012 06:42:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211120639540.28418@cobra.newdream.net>
References: <F905E0C9-46B6-4DD7-A57D-072CD4ADDFEE@profihost.ag> <alpine.DEB.2.00.1211110722100.28418@cobra.newdream.net> <50A019BE.9030002@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36751 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab2KLOmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 09:42:53 -0500
In-Reply-To: <50A019BE.9030002@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Sun, 11 Nov 2012, Stefan Priebe wrote:
> Hi Sage,
> 
> > With btrfs, yes, although this isn't something we have tested in a while.
> I'm not using btrfs as long as the devs claim it is not ready for prod.

In that case, the journal is needed for consistency of the fs; we rely on 
writeahead journaling.  It can't be turned off.

Putting it on a ramdisk in this case is interesting for performance, but 
it means that a crash/reboot/powerloss event leaves the fs in an 
inconsistent and unusable state.

The only time tmpfs is potentially useful in production is when you're 
using btrfs *and* have independent backup power sources for replicas (and 
can thus avoid worrying about a site-wide power failure and loss of 
journal).  (Or have relaxed requirements for the durability of recent 
writes.)

sage

