From: Gregory Farnum <greg@inktank.com>
Subject: Re: Adding a delay when restarting all OSDs on a host
Date: Tue, 22 Jul 2014 17:08:17 -0700
Message-ID: <CAPYLRzi37k8X3ASb_HSS40-6SqTWjPZgziN8nyhkQSO6svWAtQ@mail.gmail.com>
References: <53CE64D0.5050308@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36919 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757113AbaGWAIS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jul 2014 20:08:18 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so373869wgh.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jul 2014 17:08:17 -0700 (PDT)
In-Reply-To: <53CE64D0.5050308@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 22, 2014 at 6:19 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Currently on Ubuntu with Upstart when you invoke a restart like this:
>
> $ sudo restart ceph-osd-all
>
> It will restart all OSDs at once, which can increase the load on the system
> a quite a bit.
>
> It's better to restart all OSDs by restarting them one by one:
>
> $ sudo ceph restart ceph-osd id=X
>
> But you then have to figure out all the IDs by doing a find in
> /var/lib/ceph/osd and that's more manual work.
>
> I'm thinking of patching the init scripts which allows something like this:
>
> $ sudo restart ceph-osd-all delay=180
>
> It then waits 180 seconds between each OSD restart making the proces even
> smoother.
>
> I know there are currently sysvinit, upstart and systemd scripts, so it has
> to be implemented on various places, but how does the general idea sound?

That sounds like a good idea to me. I presume you're meaning to
actually delay the restarts, not just turning them on, so that the
daemons all remain alive (that's what it sounds like to me here, just
wanted to clarify).
-Greg
