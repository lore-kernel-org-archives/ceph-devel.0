From: John Spray <jspray@redhat.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Sun, 13 Nov 2016 12:15:07 +0000
Message-ID: <CALe9h7dGfVTYfp0grQ3=Xq=0f01S2zN=ttJjoOKES6qmUg7wSQ@mail.gmail.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36002 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbcKMMP2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Nov 2016 07:15:28 -0500
Received: by mail-qt0-f181.google.com with SMTP id w33so33477317qtc.3
        for <ceph-devel@vger.kernel.org>; Sun, 13 Nov 2016 04:15:28 -0800 (PST)
In-Reply-To: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, "Durgin, Josh" <jdurgin@redhat.com>

On Fri, Nov 11, 2016 at 4:47 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
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

OK.  BTW feel free to backport the patch from master that disables the
unstable flock tests.

John

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
