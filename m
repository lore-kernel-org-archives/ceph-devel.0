From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: outstanding branches
Date: Thu, 12 Jul 2012 09:35:54 -0700
Message-ID: <CAC-hyiFpKxu=9PDmQ3QYaPh25OgwCY8_HE7NMWdDyG5qWHmzJg@mail.gmail.com>
References: <alpine.DEB.2.00.1207120910060.693@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56129 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932714Ab2GLQfz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 12:35:55 -0400
Received: by bkwj10 with SMTP id j10so2363043bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 09:35:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207120910060.693@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 12, 2012 at 9:16 AM, Sage Weil <sage@inktank.com> wrote:
> These branches need some attention:
>
> - wip-mon-mkfs
>
> Avoid doing rm -rf (literally) during ceph-mon --mkfs.  Do it in vstart.sh
> and mkcephfs instead.
>
> - wip-omap-comparison
>
> Eleanor is using this.  It should probbaly just go in master... Sam?
>
> - wip-2650
>
> rgw: don't override subuser perm mask if perm not specified
>
> Just needs to be merged into master, probably Stable/next too... Yehuda?

Yeah, should go to argonaut too.

>
> - wip-rbd-locking
>
> This is in flux as Yehuda is converting the OSD support into a generic
> class.
>
> - wip-2504
>
> rgw: use multiple notification objects
>
> Should this be merged with a default of 1 (to cooperate with previous
> code)?
>
>
> These are probably on hold for the time being:
>
> - wip-rados-bench4
>
> On hold while Mike finishes chunky scrub... probably 0.51?
>
> - wip-auth
>
> Cleaning up 'rbd map' options to be consistent with everythign else.  Misc
> keyring handling cleanup.  New auth configuration options, negotiation,
> etc.  This needs some significant review and testing.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
