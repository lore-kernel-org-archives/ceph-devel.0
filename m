From: John Spray <john.spray@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Thu, 11 Dec 2014 22:47:04 +0000
Message-ID: <CAGd4Wr3A4QYQkPsgSJ3viraxToGWBWJ=eaUZ08CM+tSGg56WXQ@mail.gmail.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net>
	<5488919E.4090109@redhat.com>
	<alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net>
	<5488FC46.5080106@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:50461 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965652AbaLKWrG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Dec 2014 17:47:06 -0500
Received: by mail-la0-f53.google.com with SMTP id gm9so5023828lab.40
        for <ceph-devel@vger.kernel.org>; Thu, 11 Dec 2014 14:47:04 -0800 (PST)
In-Reply-To: <5488FC46.5080106@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: Sage Weil <sweil@redhat.com>, Ken Dreyer <kdreyer@redhat.com>, cjwatson@debian.org, timm@fnal.gov, ceph-maintainers@ceph.com, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 11, 2014 at 2:07 AM, Tim Serong <tserong@suse.com> wrote:
> Calamari consists of a few pieces - the web-accessible bit runs as the
> apache user, then there's the cthulhu daemon, as well as carbon-cache
> for the graphite stuff.  These latter two I believe run as root (at
> least, they do with my SUSE packages which have systemd units for each
> of these services, and I assume they run as root on other distros where
> they're run under supervisord).  Now that I think of it though, I wonder
> if it makes sense to just run the whole lot as the apache user...?

It probably doesn't make sense to move all the services under apache:
the in-apache parts (i.e. the REST request handlers) are relatively
unprivileged things that just know how to make calls to other (local)
services, whereas the other services are reaching out over the network
to the Ceph servers.  It might make sense to use a ceph-calamari user
for cthulhu et al, and leave the REST bits running as apache.

As for carbon-cache, that should cease to be a calamari-specific
question when using proper distro packages instead of an embedded
instance (iirc we were still running our own built-in carbon last time
I touched calamari)

Cheers,
John
