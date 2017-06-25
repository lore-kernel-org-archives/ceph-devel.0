From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: undefined symbol when running new erasure code
Date: Sun, 25 Jun 2017 23:53:07 +0300
Message-ID: <CAODUPsH1Opy8wPdLQ5dd3e-Edpp7hb4rEXk_OLpLDOeYZENaBg@mail.gmail.com>
References: <CAODUPsEFD27_aDbOx7qjnwummu6JimhYszA3dABm00_r1OQ1-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35767 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdFYUxI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Jun 2017 16:53:08 -0400
Received: by mail-oi0-f50.google.com with SMTP id c189so46373839oia.2
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jun 2017 13:53:08 -0700 (PDT)
In-Reply-To: <CAODUPsEFD27_aDbOx7qjnwummu6JimhYszA3dABm00_r1OQ1-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
An update:
I've removed ceph dir and rebuilt everything, now the error is the following:
Error EIO: load dlopen(/home/ubuntu/ceph/build/lib/libec_optlrc.so):
/home/ubuntu/ceph/build/lib/libec_optlrc.so: undefined symbol:
_ZTIN4ceph11ErasureCodeE

Regards,
Oleg

On Sun, Jun 25, 2017 at 9:36 PM, Oleg Kolosov <olekol@gmail.com> wrote:
> Hi
> I've written an erasure code for my research purposes. I've built ceph
> successfully however when setting up a virtual cluster and running
> "bin/ceph osd erasure-code-profile set" I get the following error:
> Error EIO: load dlopen(/home/ubuntu/ceph/build/lib/libec_optlrc.so):
> /home/ubuntu/ceph/build/lib/libec_optlrc.so: undefined symbol:
> _ZN4ceph11ErasureCode17minimum_to_decodeERKSt3setIiSt4lessIiESaIiEES7_PS5_
>
>
> I'm working on master branch. ./run-make-check.sh also ran successfully.
> I'm wondering how to approach this error.
>
> Thanks
