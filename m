From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: kraken v11.2.1 QE status
Date: Mon, 7 Aug 2017 10:12:10 +0200
Message-ID: <CAOi1vP83Wfwhxax2S0Hd2Rxht-L5=jtOLL5r14j4WiF=rH0Dvg@mail.gmail.com>
References: <CAMMFjmHRoBZP5YbrJEXUDd5F7JUbB5_r2CubuD_j6pL8J0SP3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35318 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbdHGIML (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Aug 2017 04:12:11 -0400
Received: by mail-ua0-f177.google.com with SMTP id d29so27363024uai.2
        for <ceph-devel@vger.kernel.org>; Mon, 07 Aug 2017 01:12:11 -0700 (PDT)
In-Reply-To: <CAMMFjmHRoBZP5YbrJEXUDd5F7JUbB5_r2CubuD_j6pL8J0SP3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>

On Sat, Aug 5, 2017 at 6:04 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/19009#note-91
>
> The following suites were in scope of this point release validation:
>
> rados (subset 35/50 245 jobs)
> rbd  (subset 35/50 100 jobs)
> rgw
> fs
> krbd
> kcephfs
> knfs
> rest
> hadoop - EXCLUDED
> samba - EXCLUDED
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade
> upgrade/jewel-x (kraken)
> upgrade/hammer-jewel-x - EXCLUDED
> powercycle
> ceph-ansible
>
> (please let me know if any suites are missing from this ^ list)
>
> Outstanding issues:
>
> krbd - Ilya, pls review and approve/comment for release as appropriate

Approved.

Thanks,

                Ilya
