From: Sage Weil <sage@inktank.com>
Subject: Re: [systemd-devel] [PATCH] rules: add by-parttypeuuid rule for GPT
 labeled partitions
Date: Fri, 9 May 2014 15:00:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405091454000.28481@cobra.newdream.net>
References: <1399671097-32015-1-git-send-email-sage@inktank.com> <CAPXgP11h0C0BA0u+CfTV2LDz2T0vdRBThpxXu-0U-3RX2gnzDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40194 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757543AbaEIWA4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 May 2014 18:00:56 -0400
In-Reply-To: <CAPXgP11h0C0BA0u+CfTV2LDz2T0vdRBThpxXu-0U-3RX2gnzDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kay Sievers <kay@vrfy.org>
Cc: systemd-devel@lists.freedesktop.org, ceph-devel@vger.kernel.org

Hi Kay,

On Fri, 9 May 2014, Kay Sievers wrote:
> On Fri, May 9, 2014 at 11:31 PM, Sage Weil <sage@inktank.com> wrote:
> > The Ceph OSD initialization relies on identifying GPT partitions by type
> > in order to mount data volumes and start daemons.  Currently we ship this
> > rule separately, but it is awkward to duplicate the conditional logic that
> > precedes this block and it would be much simpler if it were simply included
> > in the upstream rules.
> 
> Types are by definition not unique. The symlinks in /dev/disk/by-*/
> are *expected* to be unique.
> 
> We handle duplicated labels, but they are specified by humans,
> multiple partitions with the same GPT types are just normal expected
> behavior; and they would have no order or priority, they just
> overwrite each other depending on probing order.

This is why the label has both the type (fixed, to identify this as a ceph 
partition) and the label (random):

 /dev/disk/by-parttypeuuid/$env{ID_PART_ENTRY_TYPE}.$env{ID_PART_ENTRY_UUID}

> We should not add such things, the logic to find these volumes at
> bootup are better handled by a specific program like systemd's
> systemd-gpt-auto-generator, without putting unreliable and
> unpredictable content into /dev.

I think this is what we're trying to accomplish with the ceph-disk tool, 
which relies on these (reliable and predictable) symlinks.  The labels 
alone (by-partuuid) aren't sufficient since we want to be able to scan for 
partitions of a given type without re-running blkid on every volume.

Right now sysvinit, upstart, and udev may trigger ceph-disk to activate 
volumes. Hopefully we'll have native systemd support sometime soon.  But 
first I want to make sure the approach has been validated, and hopefully 
avoid shipping custom rules...

Thanks!
sage
