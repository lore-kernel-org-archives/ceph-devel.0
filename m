From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Fri, 11 Nov 2016 17:58:13 +0100
Message-ID: <CAOi1vP9K7htWyGBHD_c7UCArqR5N_m2R_xKYCyxbuyFToXmoXQ@mail.gmail.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35883 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756014AbcKKQ6g (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 11:58:36 -0500
Received: by mail-vk0-f41.google.com with SMTP id p9so17877616vkd.3
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 08:58:14 -0800 (PST)
In-Reply-To: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

On Fri, Nov 11, 2016 at 5:47 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/17487#note-32
>
> The following suites were in scope of this point release validation:
>
> rados (subset 35/50 297 jobs)
> rbd
> rgw
> fs
> krbd
> kcephfs
> knfs
> rest
> hadoop
> samba
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade
> upgrade/hammer-x (jewel)
> upgrade/infernalis-x (jewel) - deprecated
> powercycle
> (please let me know if any suites are missing from this ^ list)
>
> ==============================
> Issues requiring approval/decision:
>
> fs - http://tracker.ceph.com/issues/17832 (Greg pls review/approve)
>
> krbd - http://tracker.ceph.com/issues/17221 (Jason, Ilya pls review/approve)

Approved.

Thanks,

                Ilya
