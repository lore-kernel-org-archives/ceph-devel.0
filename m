From: Tommi Virtanen <tv@inktank.com>
Subject: Re: weirdness upgrading to v0.48argonaut packages
Date: Tue, 14 Aug 2012 13:55:31 -0700
Message-ID: <CADvuQRFJhG6iVY1xs2Wi3bxhmawFWOtYCz8ea-xYriLg31AbJA@mail.gmail.com>
References: <alpine.DEB.2.00.1208141324000.29021@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55370 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab2HNUzw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 16:55:52 -0400
Received: by vcbfk26 with SMTP id fk26so818691vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 13:55:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208141324000.29021@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: gcs@debian.hu, ceph-devel@vger.kernel.org

On Tue, Aug 14, 2012 at 1:26 PM, Sage Weil <sage@inktank.com> wrote:
> Because we moved mount.ceph from ceph-common to ceph-fs-common, upgrading
> to v0.48 can cause apt-get to complain (because mount.ceph is part of
> ceph-common).  One workaround is to do
>
>  apt-get install ceph-common=v0.48argonaut ceph=v0.48argonaut
>
> Is there something we should have done when making that change to avoid
> this problem, or is this an inevitable annoyance with rearranging the
> packages?  Is there a better workaround?

I think ceph-fs-common should have

Replaces: ceph-common (<< v0.48argonaut-1)
Breaks: ceph-common (<< v0.48argonaut-1)

(or whatever the first package with that renaming included was)


http://www.debian.org/doc/debian-policy/ch-relationships.html#s-replaces
http://www.debian.org/doc/debian-policy/ch-relationships.html#s-breaks
