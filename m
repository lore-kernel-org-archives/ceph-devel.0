From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Fri, 10 Aug 2012 09:12:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net> <502530C9.7030008@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60115 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab2HJQMs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 12:12:48 -0400
In-Reply-To: <502530C9.7030008@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 10 Aug 2012, Danny Kukawka wrote:
> Am 10.08.2012 17:54, schrieb Sage Weil:
> > On Thu, 9 Aug 2012, Danny Kukawka wrote:
> >> Remove btrfs specific keys and replace them by more generic
> >> keys to be able to replace btrfs with e.g. xfs or ext4 easily.
> >>
> >> Add new key to define the osd fs type: 'fstype', which can get
> >> defined in the [osd] section for all OSDs.
> >>
> >> Replace:
> >> - 'btrfs devs' -> 'devs'
> >> - 'btrfs path' -> 'fs path'
> >> - 'btrfs options' -> 'fs options'
> >> - mkcephfs: replace --mkbtrfs with --mkfs
> >> - init-ceph: replace --btrfs with --fsmount, --nobtrfs
> >> with --nofsmount, --btrfsumount with --fsumount
> >>
> >> Update documentation, manpage and example config files.
> > 
> > Maybe this should keep the old options as well, so that --mkbtrfs is an 
> > alias for --mkfs --btrfs...
> 
> I can add this to the patch, no problem!
> 
> > Tommi, is this kind of invocation compatible with your notion of what 
> > mkcephfs 2.0 should be?  If we can jump to the target interface and 
> > rewrite the implementation in terms of the new tools that would capture 
> > the best of both worlds.
> 
> If you can point me to some documentation how the target interface
> works, I could take a look at adapting mkcephfs to the new tools as soon
> as the new interface/workflow is ready.

It's not defined yet.  I know Tommi has something in his head, but I'm not 
sure if it's something similar to the current one (a cluster-wide 
ceph.conf) or something else.  He's off today, so we probably have to wait 
to find out.

sage
