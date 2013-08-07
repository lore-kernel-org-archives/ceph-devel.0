From: Sage Weil <sage@inktank.com>
Subject: RE: ocf script for ceph quorum check and fs
Date: Wed, 7 Aug 2013 08:14:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308070813380.3006@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B62E74783@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B62E82AFA@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43584 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab3HGPOC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 11:14:02 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62E82AFA@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 7 Aug 2013, James Harper wrote:
> > 
> > I want to mount ceph fs (using fuse) but /etc/fstab treats it as a local
> > filesystem and so tries to mount it before ceph is started, or indeed before
> > the network is even up.
> > 
> > Also, ceph tries to start before the network is up and fails because it can't
> > bind to an address. I think this is because I'm using openvswitch which is
> > starting later.
> > 
> > Anyway, controlling it all via pacemaker seems like a much smarter thing to
> > do as I can ensure that ceph doesn't start until the network is up (which it will
> > be when pacemaker has quorum), and then the fs doesn't mount until ceph
> > is started and the ceph cluster has quorum and maybe until an mds is
> > running.
> > 
> > So to do this I need ocf scripts for:
> > 
> > . starting components of ceph, which appears to be provided by ceph-
> > resource-agents.deb, but I haven't tested yet
> > . checking ceph quorum - I guess I'd need to write a script for this like existing
> > ping check
> > . checking mds is available - maybe part of the mount script
> > . mount using ceph-fuse. Existing fs scripts make assumptions about fs types
> > and parameters and don't work
> > 
> > Has anyone written a 'check_ceph_quorum' script? Or a fs mount script that
> > is compatible with fuse? I don't want to re-invent any wheels!
> > 
> 
> I have written a ceph_check RA that sets a value in the CIB if the ceph cluster has quorum, and another to mount the fuse fs, although I think maybe it would be better to fix the bug in the existing pacemaker RA to allow mounting fuse properly.
> 
> Is anyone interested enough for me to clean it up a bit and post it?

If it's in the ceph.git tree, then I'm certainly interested in seeing it 
in a working state!

:) sage
