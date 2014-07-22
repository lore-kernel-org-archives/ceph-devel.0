From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Adding a delay when restarting all OSDs on a host
Date: Tue, 22 Jul 2014 17:48:33 +0400
Message-ID: <CABYiri8hsZahorNYeeFZBO-bE6u8BZULcnNfs8eBSyYOJL+9jw@mail.gmail.com>
References: <53CE64D0.5050308@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:54451 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaGVNsy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jul 2014 09:48:54 -0400
Received: by mail-oa0-f45.google.com with SMTP id i7so9650291oag.18
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jul 2014 06:48:53 -0700 (PDT)
In-Reply-To: <53CE64D0.5050308@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 22, 2014 at 5:19 PM, Wido den Hollander <wido@42on.com> wrote:
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
>
> --
> Wido den Hollander
> Ceph consultant and trainer
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --


Hi,

this behaviour obviously have a negative side of increased overall
peering time and larger integral value of out-of-SLA delays. I`d vote
for warming up necessary files, most likely collections, just before
restart. If there are no enough room to hold all of them at once, we
can probably combine both methods to achieve lower impact value on
restart, although adding a simple delay sounds much more straight than
putting file cache to ram.
