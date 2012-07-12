From: "Pascal de Bruijn | Unilogic Networks B.V."
	<pascal@unilogicnetworks.net>
Subject: Re: [PATCH] Robustify ceph-rbdnamer and adapt udev rules
Date: Thu, 12 Jul 2012 09:49:12 +0200
Message-ID: <1342079352.2204.16.camel@clawhammer>
References: <1342012996.5511.27.camel@clawhammer>
	 <4FFDA995.70302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:48393 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752759Ab2GLHtP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Jul 2012 03:49:15 -0400
In-Reply-To: <4FFDA995.70302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, s.kleijkers@unilogic.nl

On Wed, 2012-07-11 at 09:28 -0700, Josh Durgin wrote:
> On 07/11/2012 06:23 AM, Pascal de Bruijn | Unilogic Networks B.V. wrote:
> > Below is a patch which makes the ceph-rbdnamer script more robust and
> > fixes a problem with the rbd udev rules.
> >
> > On our setup we encountered a symlink which was linked to the wrong rbd:
> >
> >    /dev/rbd/mypool/myrbd ->  /dev/rbd1
> >
> > While that link should have gone to /dev/rbd3 (on which a
> > partition /dev/rbd3p1 was present).
> >
> > Now the old udev rule passes %n to the ceph-rbdnamer script, the problem
> > with %n is that %n results in a value of 3 (for rbd3), but in a value of
> > 1 (for rbd3p1), so it seems it can't be depended upon for rbdnaming.
> >
> > In the patch below the ceph-rbdnamer script is made more robust and it
> > now it can be called in various ways:
> >
> >    /usr/bin/ceph-rbdnamer /dev/rbd3
> >    /usr/bin/ceph-rbdnamer /dev/rbd3p1
> >    /usr/bin/ceph-rbdnamer rbd3
> >    /usr/bin/ceph-rbdnamer rbd3p1
> >    /usr/bin/ceph-rbdnamer 3
> >
> > Even with all these different styles of calling the modified script, it
> > should now return the same rbdname. This change "has" to be combined
> > with calling it from udev with %k though.
> >
> > With that fixed, we hit the second problem. We ended up with:
> >
> >    /dev/rbd/mypool/myrbd ->  /dev/rbd3p1
> >
> > So the rbdname was symlinked to the partition on the rbd instead of the
> > rbd itself. So what probably went wrong is udev discovering the disk and
> > running ceph-rbdnamer which resolved it to myrbd so the following
> > symlink was created:
> >
> >    /dev/rbd/mypool/myrbd ->  /dev/rbd3
> >
> > However partitions would be discovered next and ceph-rbdnamer would be
> > run with rbd3p1 (%k) as parameter, resulting in the name myrbd too, with
> > the previous correct symlink being overwritten with a faulty one:
> >
> >    /dev/rbd/mypool/myrbd ->  /dev/rbd3p1
> >
> > The solution to the problem is in differentiating between disks and
> > partitions in udev and handling them slightly differently. So with the
> > patch below partitions now get their own symlinks in the following style
> > (which is fairly consistent with other udev rules):
> >
> >    /dev/rbd/mypool/myrbd-part1 ->  /dev/rbd3p1
> >
> > Please let me know any feedback you have on this patch or the approach
> > used.
> 
> This all makes sense, but maybe we should put the -part suffix in
> another namespace to avoid colliding with images that happen to have
> -partN in their name, e.g.:
> 
>      /dev/rbd/mypool/myrbd/part1 -> /dev/rbd3p1

Well my current patch changes the udev rules in a way that's consistent
with other udev bits. For example:

  /dev/disk/by-id/cciss-3600508b1001038353220202020200006
  /dev/disk/by-id/cciss-3600508b1001038353220202020200006-part1
  /dev/disk/by-id/cciss-3600508b1001038353220202020200006-part2

There is no namespacing there either. That said, those rules tends to
use serials/unique-id's for naming (and not user specified strings), so
there is little risk of conflicting with the -part%n bit.

Also, having a namespace as suggested:

  /dev/rbd/mypool/myrbd/part1 -> /dev/rbd3p1

Also precludes:

  /dev/rbd/mypool/myrbd -> /dev/rbd3

From existing, as myrbd can't be both a device file and directory at the
same time :)

Assuming you'd want to continue with this approach the disk udev link
should probably be something like:

  /dev/rbd/mypool/myrbd/disk -> /dev/rbd3

Please do note that this would change the udev rules in a way that could
potentially break people's existing scripts which might assume the old
udev scheme (whereas my current patch does not break the old scheme).

Maybe it's worth considering applying my patch as-is to the 0.48.x
stable tree, and experimenting with other udev schemes in newer
development releases?

Regards,
Pascal de Bruijn


