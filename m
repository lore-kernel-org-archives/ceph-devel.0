From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: v10.0.2 released
Date: Thu, 14 Jan 2016 09:04:21 -0800
Message-ID: <CADRKj5TXdCmDS5aX5+HRee9fOr7Za4y_WGJhja0eyxhdTcHefA@mail.gmail.com>
References: <alpine.DEB.2.11.1601141033010.21258@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34023 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbcANREW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 12:04:22 -0500
Received: by mail-oi0-f44.google.com with SMTP id k206so119631651oia.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jan 2016 09:04:22 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601141033010.21258@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, ceph-announce@ceph.com

On Thu, Jan 14, 2016 at 7:37 AM, Sage Weil <sweil@redhat.com> wrote:
> This development release includes a raft of changes and improvements for
> Jewel. Key additions include CephFS scrub/repair improvements, an AIX and
> Solaris port of librados, many librbd journaling additions and fixes,
> extended per-pool options, and NBD driver for RBD (rbd-nbd) that allows
> librbd to present a kernel-level block device on Linux, multitenancy
> support for RGW, RGW bucket lifecycle support, RGW support for Swift

rgw bucket lifecycle isn't there, it still has some more way to go
before we merge it in.

Yehuda

> static large objects (SLO), and RGW support for Swift bulk delete.
>
> There are also lots of smaller optimizations and performance fixes going
> in all over the tree, particular in the OSD and common code.
>
> Notable Changes
> ---------------
>
> See
>
>         http://ceph.com/releases/v10-0-2-released/
>
> [I'd include the changelog here but I'm missing a oneliner that renders
> the rst in email-suitable form...]
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-10.0.2.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
