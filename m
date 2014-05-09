From: Sage Weil <sage@inktank.com>
Subject: Re: [systemd-devel] [PATCH] rules: add by-parttypeuuid rule for GPT
 labeled partitions
Date: Fri, 9 May 2014 15:34:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405091527480.28481@cobra.newdream.net>
References: <1399671097-32015-1-git-send-email-sage@inktank.com> <CAPXgP11h0C0BA0u+CfTV2LDz2T0vdRBThpxXu-0U-3RX2gnzDw@mail.gmail.com> <alpine.DEB.2.00.1405091454000.28481@cobra.newdream.net>
 <CAPXgP10_a1XWD-ZmPYkcctMEfP_D203QnEpS6d7R2Z+HYVS_cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40384 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaEIWed (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 May 2014 18:34:33 -0400
In-Reply-To: <CAPXgP10_a1XWD-ZmPYkcctMEfP_D203QnEpS6d7R2Z+HYVS_cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kay Sievers <kay@vrfy.org>
Cc: systemd-devel@lists.freedesktop.org, ceph-devel@vger.kernel.org

On Sat, 10 May 2014, Kay Sievers wrote:
> On Sat, May 10, 2014 at 12:00 AM, Sage Weil <sage@inktank.com> wrote:
> > On Fri, 9 May 2014, Kay Sievers wrote:
> >> On Fri, May 9, 2014 at 11:31 PM, Sage Weil <sage@inktank.com> wrote:
> >> > The Ceph OSD initialization relies on identifying GPT partitions by type
> >> > in order to mount data volumes and start daemons.  Currently we ship this
> >> > rule separately, but it is awkward to duplicate the conditional logic that
> >> > precedes this block and it would be much simpler if it were simply included
> >> > in the upstream rules.
> >>
> >> Types are by definition not unique. The symlinks in /dev/disk/by-*/
> >> are *expected* to be unique.
> >>
> >> We handle duplicated labels, but they are specified by humans,
> >> multiple partitions with the same GPT types are just normal expected
> >> behavior; and they would have no order or priority, they just
> >> overwrite each other depending on probing order.
> >
> > This is why the label has both the type (fixed, to identify this as a ceph
> > partition) and the label (random):
> >
> >  /dev/disk/by-parttypeuuid/$env{ID_PART_ENTRY_TYPE}.$env{ID_PART_ENTRY_UUID}
> >
> >> We should not add such things, the logic to find these volumes at
> >> bootup are better handled by a specific program like systemd's
> >> systemd-gpt-auto-generator, without putting unreliable and
> >> unpredictable content into /dev.
> >
> > I think this is what we're trying to accomplish with the ceph-disk tool,
> > which relies on these (reliable and predictable) symlinks.  The labels
> > alone (by-partuuid) aren't sufficient since we want to be able to scan for
> > partitions of a given type without re-running blkid on every volume.
> 
> /dev is an API which should by default not contain custom links which
> are not generally useful, and these links are not useful for other
> tools.

FWIW I was surprised that there wasn't already a way to find partitions by 
type in /dev, but I assume you know better than I how other tools are 
using udev.  It seems at least as useful as by-partuuid to me.

> These links are not even recognizable by type without doing readdir()
> over it and string match operations to find the types, we really
> should not add such stuff to the default rules set. We have to be
> careful here, it seems like the wrong approach to put that in the
> public visible /dev API.
> 
> Tools can get all this information programatically out of the udev
> database, there is no create symlinks or to run blkid.

I just looked up libudev and it looks like there is even a pyudev wrapper, 
so that could indeed work better.  I take it that queries via 
udev_enumerate for (say) ID_PART_ENTRY_TYPE=x are efficient?

> Ultimately, there is nothing wrong with tools shipping their own
> rules, but please do not use generic names like
> /dev/disk/by-parttypeuuid/. The name does even sound misleading
> because it combines two different things in one name, with a '.' as a
> separator.
> 
> Why don't you just use a leading directory for the type instead of
> stuffing that into one name?

I'd happily replace the . with /.  I suspect I wasn't sure at the time if 
nested directories were handled properly.

Anyway, libudev + pyudev looks like a better solution for ceph-disk.  

Thanks!
sage
