From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Mon, 14 Nov 2016 14:20:33 -0800
Message-ID: <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38654 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940854AbcKNWUf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 17:20:35 -0500
Received: by mail-wm0-f41.google.com with SMTP id f82so127994586wmf.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 14:20:34 -0800 (PST)
In-Reply-To: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

See updated status - http://tracker.ceph.com/issues/17487#note-32

Outstanding issues:

knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
pls review/approve, assumed Approved ?)

upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
pls review/approve, seems persistent, but maybe not a showstopper)

upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
to make it pass, see issues in the tacker summary above)

Sage, jewel 10.2.4 can be released as soon as you agree with the
findings/summary.

Thx
YuriW

On Fri, Nov 11, 2016 at 8:47 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
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
>
> knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
> pls review/approve)
>
> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
> pls review/approve)
>
> upgrade/infernalis-x (jewel) - deprecated, but Nathan is still working
> to make it pass (Sage pls review/approve)
>
> powercycle - in progress
>
> Thx
> YuriW
