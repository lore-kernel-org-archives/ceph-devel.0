From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] who is using radosgw with civetweb?
Date: Wed, 25 Feb 2015 14:44:16 -0700
Message-ID: <CAANLjFpHND2uyUvdzJ-pz4QOXp6SpYK=sD1WQz=rT-Two6izqw@mail.gmail.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:32890 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbbBYVoT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 16:44:19 -0500
Received: by lbvp9 with SMTP id p9so6933988lbv.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 13:44:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

We tried to get radosgw working with Apache + mod_fastcgi, but due to
the changes in radosgw, Apache, mode_*cgi, etc and the documentation
lagging and not having a lot of time to devote to it, we abandoned it.
Where it the documentation for civetweb? If it is appliance like and
easy to set-up, we would like to try it to offer some feedback on your
question.

Thanks,
Robert LeBlanc

On Wed, Feb 25, 2015 at 12:31 PM, Sage Weil <sweil@redhat.com> wrote:
> Hey,
>
> We are considering switching to civetweb (the embedded/standalone rgw web
> server) as the primary supported RGW frontend instead of the current
> apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here means
> both the primary platform the upstream development focuses on and what the
> downstream Red Hat product will officially support.
>
> How many people are using RGW standalone using the embedded civetweb
> server instead of apache?  In production?  At what scale?  What
> version(s) (civetweb first appeared in firefly and we've backported most
> fixes).
>
> Have you seen any problems?  Any other feedback?  The hope is to (vastly)
> simplify deployment.
>
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
