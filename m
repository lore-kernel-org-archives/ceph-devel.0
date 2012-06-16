From: Sage Weil <sage@inktank.com>
Subject: Re: sync Ceph packaging efforts for Debian/Ubuntu
Date: Sat, 16 Jun 2012 09:00:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206160856140.1862@cobra.newdream.net>
References: <1339805412.7726.160.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51042 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab2FPQAL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jun 2012 12:00:11 -0400
In-Reply-To: <1339805412.7726.160.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Ben Collins <bcollins@ubuntu.com>, James Page <james.page@ubuntu.com>, Ceph Development <ceph-devel@vger.kernel.org>, openstack-devel@lists.alioth.debian.org

Hi Laszlo!

On Sat, 16 Jun 2012, Laszlo Boszormenyi (GCS) wrote:
> Hi all parties,
> 
> Ceph is packaged at three places: in Ubuntu, at upstream and in Debian.
> Its first 'stable' release, 0.48 is coming. At least as Sage wrote some
> days ago: "It looks like 0.48 will also be the basis for one of our
> first 'stable' releases.".
> 
> Hereby I would like to sync our Debian related packaging efforts, not
> only for the mentioned stable release. The OpenStack packaging team
> would like to add Ceph to their stack. Howtos, helping hands on forums
> needs it as well.
> I'm not subscribed to the lists, please keep me in the loop with Cc-s.
> 
> First patch, 0002-Add-support-PPC.patch is for upstream. Would help the
> in tree leveldb to build on PowerPC architectures as well.
> Second patch reflect the homepage and git tree changes for Ubuntu.
> Third patch is from them, noted as "Switch from libcryptopp to libnss as
> libcryptopp is not seeded.". So libnss3-dev is used as build-dependency
> instead. Sage, would you commit it?

I haven't looked closely yet, but these should be fine.

> I've separated gceph out, if someone needs the CLI only, then s/he can
> do that without the GTK+ libraries. See below.

gceph is already gone from the 'next' branch.

> Ben, James, can you please share in some sentences why ceph-fuse is
> dropped in Ubuntu? Do you need it Sage? If it's feasible, you may drop
> that as well.

We could package it separately, if necessary, but it should be packaged.  

> As I see, you still ship d/librgw1.install , d/librgw1.postrm ,
> d/librgw1.postinst and librgw-dev.install . They are not needed anymore.

These are already gone from the 'next' branch as well.

> Maybe the biggest change is that ceph-mds was separated out and such,
> ceph-fs-common created for cephfs and mount.ceph.

We can do this as well, but I would prefer not to.  Opinions?

> Please move the configure call to its target, as you can check in git.
> Add var/lib/ceph/mon , var/lib/ceph/osd and var/lib/ceph/mds to
> d/ceph.dirs .

This should be done in 'next'.

> git patch is for Sage, upstream and contains what needed for the new
> packages. May I get commit rights to debian/ or should I go with git
> forks and you'll merge the changes?

Patches or a git merge request are best as they allow for review.

Thanks, Laszlo!  Looking forward to seeing this in wheezy, and easing the 
burden on you and the Ubuntu guys.

sage

 
> Also it seems that limit the architectures to build on is not
> allowed[1]. I'll write an email to this issue, how to go with failing
> leveldb build-dependency on some archs.
> 
> Loic, do you need anything or do you have any objections with these
> changes?
> 
> Regards,
> Laszlo/GCS
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=677626
> 
