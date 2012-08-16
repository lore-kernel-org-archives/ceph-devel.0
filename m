From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Thu, 16 Aug 2012 15:32:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208161448060.26904@cobra.newdream.net>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net> <502530C9.7030008@bisect.de> <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42481 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534Ab2HPWc0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 18:32:26 -0400
In-Reply-To: <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 10 Aug 2012, Sage Weil wrote:
> On Fri, 10 Aug 2012, Danny Kukawka wrote:
> > Am 10.08.2012 17:54, schrieb Sage Weil:
> > > On Thu, 9 Aug 2012, Danny Kukawka wrote:
> > >> Remove btrfs specific keys and replace them by more generic
> > >> keys to be able to replace btrfs with e.g. xfs or ext4 easily.
> > >>
> > >> Add new key to define the osd fs type: 'fstype', which can get
> > >> defined in the [osd] section for all OSDs.
> > >>
> > >> Replace:
> > >> - 'btrfs devs' -> 'devs'
> > >> - 'btrfs path' -> 'fs path'
> > >> - 'btrfs options' -> 'fs options'
> > >> - mkcephfs: replace --mkbtrfs with --mkfs
> > >> - init-ceph: replace --btrfs with --fsmount, --nobtrfs
> > >> with --nofsmount, --btrfsumount with --fsumount
> > >>
> > >> Update documentation, manpage and example config files.
> > > 
> > > Maybe this should keep the old options as well, so that --mkbtrfs is an 
> > > alias for --mkfs --btrfs...
> > 
> > I can add this to the patch, no problem!
> > 
> > > Tommi, is this kind of invocation compatible with your notion of what 
> > > mkcephfs 2.0 should be?  If we can jump to the target interface and 
> > > rewrite the implementation in terms of the new tools that would capture 
> > > the best of both worlds.
> > 
> > If you can point me to some documentation how the target interface
> > works, I could take a look at adapting mkcephfs to the new tools as soon
> > as the new interface/workflow is ready.
> 
> It's not defined yet.  I know Tommi has something in his head, but I'm not 
> sure if it's something similar to the current one (a cluster-wide 
> ceph.conf) or something else.  He's off today, so we probably have to wait 
> to find out.

Okay, I just synced up with Tommi.  The goal is for the new 'mkcephfs' 
functionality to generalize to both cluster setup and expansion, and to 
avoid the pain associated with explicitly defining osd ids, paths, and 
devices for each osd.  (IDs will by dynamic, hotplugging will be possible, 
etc.).  The result will be the ability to define a file specifying 
information like

 - hosts that will be monitors, osds, and/or mons
 - config options to put in the ceph.conf, or config file fragment

To instantiate osds, you could either:

 - explicitly run ceph-disk-prepare on the appropriate nodes, devices 
   (specifying fs type etc)
 - plug in a properly tagged disk that will be magically consumed
 - possibly provide a list of devices/paths in the file above and let the 
   mkcephfs replacement run it.

Point being, it won't be a drop-in replacement for mkcephfs (with a 
ceph.conf as input) because the current approach makes you allocate osd 
ids and such, and the new approach won't require that.

That being the case, I'm all for generalizing the current mkcephfs to 
other file systems as an interim step.  I think the requirements there are 
just that the old options continue to work, and pick good names.  That is,

 * conf: make 'btrfs ...' options alias to new options
 * mkcephfs: make --mkbtrfs an alias for '--mkfs' (or --mkosdfs?)
 * init-ceph: make the --btrfs alias --fsmount, etc.

As for the new options, I suggest:

 * osd fs type
 * osd fs devs   (will work for mkcephfs, not for new stuff)
 * osd fs path
 * osd fs options

The new stuff can definitely use 'osd fs type' and 'osd fs option' (e.g., 
in [osd] section).  It's less clear whether the others will remain useful, 
since they are generally tied to specific osd instances, which live in 
[osd.$id] sections, which the new stuff is won't require of you.

My hope is for the both methods to be present in bobtail, and mkcephfs to 
be deprecated by cuttlefish.  Does that sound reasonable?

Thanks!
sage
