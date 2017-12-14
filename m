From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Thu, 14 Dec 2017 08:58:51 -0600
Message-ID: <CAEPMp+5mx57spPOBPtx6VpOJca=zpQ2MCumvBJwY7a5bH9HH=w@mail.gmail.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
 <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
 <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal> <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:42638 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdLNO7c (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Dec 2017 09:59:32 -0500
Received: by mail-qk0-f170.google.com with SMTP id a71so6541476qkc.9
        for <ceph-devel@vger.kernel.org>; Thu, 14 Dec 2017 06:59:32 -0800 (PST)
In-Reply-To: <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milan Broz <mbroz@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>

>> It's worth mentioning that the "new" way for new ceph-volume OSD
>> deployments will also be using LVM, and (presumably?) allow layering
>> dm-crypt on top of an LV--not just a PV or raw device.  So this is more a
>> question of what, clean slate, we want to do to deploy dm-crypt when the
>> end result that we're after is an LV to feed to bluestore or filestore.
>> I'm not sure how/where LUKS fits in in the LVM world...
>
> I think LUKS fits in LVM world quite well.
>
> Standard Fedora (and most other distors as well) install stacks LVM over LUKS
> (so you activate only one encrypted device and then the partitioning is up to LVM.
> Also LVM metadata are then encrypted.)
>
> You can of course stack LUKS over LV as well, but for example LV resize
> will be two-step operation (well, fsadm can automate it but it is still two-steps).

Would this be the only downside to LUKS on LVM? This approach is nice
for ceph-volume
because we need to be able to encrypt anything given to us, which is
often times a LV.

The LVM on LUKS approach also makes it more difficult to expand the
underlying vgs and span
lvs across many disks. If I'm understanding correctly.


Thanks,
Andrew
