From: Sage Weil <sage@inktank.com>
Subject: Re: sync Ceph packaging efforts for Debian/Ubuntu
Date: Mon, 18 Jun 2012 09:44:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206180926100.9362@cobra.newdream.net>
References: <1339805412.7726.160.camel@julia> <Pine.LNX.4.64.1206161442230.20239@cobra.newdream.net>
 <4FDF0276.8030304@ubuntu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36098 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2FRQpI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 12:45:08 -0400
In-Reply-To: <4FDF0276.8030304@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, Ben Collins <bcollins@ubuntu.com>, clint@fewbar.com, Ceph Development <ceph-devel@vger.kernel.org>, openstack-devel@lists.alioth.debian.org

On Mon, 18 Jun 2012, James Page wrote:
> Hi Sage/Laszlo
> 
> Laszlo - thanks for sending the original email - I'd like to get
> everything as closely in-sync as possible between the three packaging
> sources as well.
> 
> On 16/06/12 22:50, Sage Weil wrote:
> > I've take a closer look at these patches, and have a few questions.
> > 
> > - The URL change and nss patches I've applied; they are in the ceph.git 
> > 'debian' branch.
> 
> Great!
> 
> > 
> > - Has the leveldb patch been sent upstream?  Once it is committed to 
> > the upstream git, we can update ceph to use it; that's nicer than carrying 
> > the patch.  However, I thought you needed to link against the existing
> > libleveldb1 package... which means we shouldn't do anything on our
> > side,
> > right?
> 
> I can't see any evidence that this has been sent upstream; ideally we
> would be building against libleveldb1 rather than using the embedded
> copy - I'm not familiar with the reason that this has not happened
> already (if there is one).  This package would also need to be reviewed
> for inclusion in main if that was the case.

We bundled it for expediency, that's all.  I just send the patch off to 
the leveldb mailing list (in case that hadn't happened yet); we'll see if 
they apply it.

> > - I'm not sure how useful it is to break mount.ceph and cephfs into a 
> > separate ceph-fs-common package, but we can do it.  Same goes for a 
> > separate package for ceph-mds.  That was originally motivated by ubuntu 
> > not wanting the mds in main, but in the end only the libraries went in, so 
> > it's a moot point.  I'd rather hear from them what their intentions are 
> > for 12.10 before complicating things...
> 
> ceph-fs-common is in Ubuntu main; so I think the original motivation
> still stands IMHO.

Okay, split that part.

> For the Ubuntu quantal cycle we still have the same primary objective as
> we had during 12.04; namely ensuring that Ceph RBD can be used as a
> block store for qemu-kvm which ties nicely into the Ubuntu OpenStack
> story through Cinder; In addition we will be looking at Ceph RADOS as a
> backend for Glance (see [0] for more details).

I'm reading this to meant hat you still want the mds separated out; did 
that too.

> The MIR for Ceph occurred quite late in the 12.04 cycle so we had to
> trim the scope to actually get it done; We will be looking at libfcgi
> and google-perftools this cycle for main inclusion to re-enable the
> components that are currently disabled in the Ubuntu packaging.

Including those (and libleveldb1) would be ideal.

> > - That same patch also switched all the Architecture: lines back to 
> > linux-any.  Was that intentional?  I just changed them from that last 
> > week.
> 
> I think linux-any is correct - the change you have made would exclude
> the PPC architecture in Ubuntu and Debian.
> 
> [...]
> 
> >> Ben, James, can you please share in some sentences why ceph-fuse is
> >> dropped in Ubuntu? Do you need it Sage? If it's feasible, you may drop
> >> that as well.
> 
> There is an outstanding question on the 12.04 MIR as to whether this
> package could still be built but not promoted to main - I'll follow up
> with the MIR reviewer as to whether that's possible as I don't think it
> requires any additional build dependencies.
> 
> [...]
> 
> I hope that explains the Ubuntu position on Ceph and what plans we have
> this development cycle.

Okay, keep us posted! 

I pushed a new 'debian' branch with those changes; please take a look and 
let me know if it loks okay.

Thanks-
sage
