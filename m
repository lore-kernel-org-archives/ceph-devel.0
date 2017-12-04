From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] [Docs] s/ceph-disk/ceph-volume/g ?
Date: Mon, 4 Dec 2017 09:38:37 -0500
Message-ID: <CAC-Np1w9XdR8qsOLF9NB85-yDs_s1rthxUH+WbDMfe_DzbhpFA@mail.gmail.com>
References: <dd203eff-a24d-ebbd-29fe-bb1e6273d1d7@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:46936 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbdLDOii (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Dec 2017 09:38:38 -0500
Received: by mail-qk0-f175.google.com with SMTP id b184so21647760qkc.13
        for <ceph-devel@vger.kernel.org>; Mon, 04 Dec 2017 06:38:38 -0800 (PST)
In-Reply-To: <dd203eff-a24d-ebbd-29fe-bb1e6273d1d7@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yoann Moulin <yoann.moulin@epfl.ch>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 4, 2017 at 3:34 AM, Yoann Moulin <yoann.moulin@epfl.ch> wrote:
> Hello,
>
> By the fact ceph-disk is now deprecated, that would be great to update documentation to have also processes with ceph-volume.
>
> for example :
>
> add-or-rm-osds => http://docs.ceph.com/docs/master/rados/operations/add-or-rm-osds/
>
> bluestore-migration => http://docs.ceph.com/docs/master/rados/operations/bluestore-migration/
>

Yes, there are also a few other places as well, and a PR is being worked on:

https://github.com/ceph/ceph/pull/19241

> In my opinion, documentation for luminous branch should keep both options (ceph-disk and ceph-volume) but with a warning message to
> encourage people to use ceph-volume instead of ceph-disk.
>
> I guess, there is plenty of reference to ceph-disk that need to be updated.
>
> --
> Yoann Moulin
> EPFL IC-IT
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
