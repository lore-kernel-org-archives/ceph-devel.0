From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: systemd status
Date: Tue, 28 Jul 2015 15:16:57 -0700
Message-ID: <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36857 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbG1WRS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 18:17:18 -0400
Received: by oibn4 with SMTP id n4so77067638oib.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 15:17:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Owen Synge <osynge@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 12:13 PM, Sage Weil <sweil@redhat.com> wrote:
> Hey,
>
> I've finally had some time to play with the systemd integration branch on
> fedora 22.  It's in wip-systemd and my current list of issues includes:
>
> - after mon creation ceph-create-keys isn't run automagically
>   - Personally I kind of hate how it was always run on mon startup and not
> just during cluster creation so I wouldn't mind *so* much if this became
> an explicit step, maybe triggered by ceph-deploy, after mon create.

I would be happy to see this become an explicit step as well.  We
could make it conditional such that ceph-deploy only runs it if we are
dealing with systemd, but I think re-running ceph-create-keys is
always safe.  It just aborts if
/etc/ceph/{cluster}.client.admin.keyring is already present.

>
> - udev's attempt to trigger ceph-disk isn't working for me.  the osd
> service gets started but the mount isn't present and it fails to start.
> I'm a systemd noob and haven't sorted out how to get udev to log something
> meaningful to debug it.  Perhaps we should merge in the udev +
> systemd revamp patches here too...
>
> - ceph-detect-init is only recently unbroken in master for fedora 22.
>
> - ceph-deploy doesn't know that fedora should be systemd yet.
>
> - ceph-deploy has a wip-systemd branch with a few things so far:
>   - on mon create, we unconditionally systemctl enable ceph.target.
> i think osd create and mds create and rgw create should do the same thing,
> since the ceph.target is a catch-all bucket for any ceph service, and i
> don't think we want to enable it on install?
>   - rgw create and mds create don't work yet
>   - osd create doesn't enable ceph.target

yeah, the ceph-deploy changes needed to properly support systemd are
pretty big. As part of that effort, ceph-deploy could use some
refactoring to more gracefully handle multiple init systems.  Owen has
proposed some of the changes necessary already, and there is some
current discussion about what constitutes minor vs major refactoring.
See https://github.com/ceph/ceph-deploy/pull/317 for some WIP toward
abstracting the init system in ceph-deploy.

>
> - I'm guessing my ceph.spec changes to install teh systemd unit files
> aren't quite right... please review!  The gitbuilder turnaround is so slow
> it's hard to iterate and I don't really know what I'm doing here.
>
> Owen, I'd like to get this just a tad bit more functional and then merge
> ASAP, then up any issues in the weeks leading up to infernalis.  What say
> ye?
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
