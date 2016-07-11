From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Misdirected clients due to kernel bug?
Date: Mon, 11 Jul 2016 15:19:41 +0200
Message-ID: <CAOi1vP9qmx2EUNT=QT+-0rw3Hh6U+t=d709xfhQFw9fWUtjdKA@mail.gmail.com>
References: <57837C3E.6050505@greenhost.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38421 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcGKNTn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 09:19:43 -0400
Received: by mail-wm0-f44.google.com with SMTP id o80so50415022wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2016 06:19:42 -0700 (PDT)
In-Reply-To: <57837C3E.6050505@greenhost.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ana Aviles <ana@greenhost.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 11, 2016 at 1:00 PM, Ana Aviles <ana@greenhost.nl> wrote:
> Hello everyone,
>
> Last week, while deploying new disks in our cluster, we bump into what
> we believe is a kernel bug. Now everything is working fine, though we
> wanted to share our experience and see if other people have experienced
> similar behaviour.
>
> Steps we followed were:
>
> 1) First we removed DNE osds (that had been previously removed
> from the cluster) to reuse their ids.
>
> ceph osd crush remove osd.6
> ceph auth del osd.6
> ceph osd rm 6
>
> 2) Then we deployed new disks with ceph-deploy
>
> ceph-deploy --overwrite-conf osd create ds1-ceph01:sda
>
> We have two different pools on the cluster, hence we used the option
>
> osd crush update on start = false
>
> So we could later manually add OSDs to the desired pool with
>
> ceph osd crush add osd.6 0.9 host=ds1-ceph01
>
>
> We added two disks. First one looked fine, however, after adding the
> second disk ceph -s started to show odd info such as some PGS on
> backfill_toofull. The odd thing was that, the OSD supposed to be full
> was 81% full, and the ratios are full_ratio 0.95 nearfull_ratio 0.88.

I'm not very familiar with this area, but note that for backfills, the
full ratio is controlled by a separate option osd_backfill_full_ratio
= 0.85.  Also, note that in order for a backfill to start, space has to
be reserved on both sides, so I'd say it's quite possible for
backfill_toofull to appear temporarily.

>
> Also, monitor logs were getting flooded with messages like:
>
> misdirected client.708156.1:1609543462 pg 2.1eff89a7 to osd.83 not
> [1,83,93] in e154784/154784
>
> On the clients we got write errors:
>
> [20882274.721623] rbd: rbd28: result -6 xferred 2000
> [20882274.773296] rbd: rbd28: write 2000 at aef404000 (4000)
> [20882274.773304] rbd: rbd28: result -6 xferred 2000
> [20882274.826057] rbd: rbd28: write 2000 at aef404000 (4000)
> [20882274.826064] rbd: rbd28: result -6 xferred 2000
>
> On OSDs, most of them were running:
> ceph version 0.94.5 (9764da52395923e0b32908d83a9f7304401fee43)
> and few of them (including the new ones) with:
> ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
>
> On the clients, we were running kernel 4.1.1.
>
> Once we rebooted clients with kernel 4.1.13 errors disappeared.
>
> The misdirect messages made us think that there were incorrect/outdated
> copies of the cluster map.

This is likely a kernel client bug and you are correct in that it has
to do with outdated state.  I think it went away because of the reboot
and not because you've upgraded to 4.1.13.  I don't see anything in
4.1.13 that's not in 4.1.1 that would have fixed something like this.

Mapping code was almost entirely rewritten in 4.7, hopefully fixing
this issue.

Thanks,

                Ilya
