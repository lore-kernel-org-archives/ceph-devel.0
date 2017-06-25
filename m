From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: undefined symbol when running new erasure code
Date: Mon, 26 Jun 2017 00:21:58 +0300
Message-ID: <CAODUPsGG81wcKfHRv7LU7THHHx0zJnHp-A65NjxOhM9AxMqP4g@mail.gmail.com>
References: <CAODUPsEFD27_aDbOx7qjnwummu6JimhYszA3dABm00_r1OQ1-g@mail.gmail.com>
 <CAODUPsH1Opy8wPdLQ5dd3e-Edpp7hb4rEXk_OLpLDOeYZENaBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:36213 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdFYVV7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Jun 2017 17:21:59 -0400
Received: by mail-ot0-f182.google.com with SMTP id 95so57679297ott.3
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jun 2017 14:21:59 -0700 (PDT)
In-Reply-To: <CAODUPsH1Opy8wPdLQ5dd3e-Edpp7hb4rEXk_OLpLDOeYZENaBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Please ignore, the issue was solved. I didn't add the correct object
to the cmake file of my EC.

Thanks,
Oleg

On Sun, Jun 25, 2017 at 11:53 PM, Oleg Kolosov <olekol@gmail.com> wrote:
> Hi
> An update:
> I've removed ceph dir and rebuilt everything, now the error is the following:
> Error EIO: load dlopen(/home/ubuntu/ceph/build/lib/libec_optlrc.so):
> /home/ubuntu/ceph/build/lib/libec_optlrc.so: undefined symbol:
> _ZTIN4ceph11ErasureCodeE
>
> Regards,
> Oleg
>
> On Sun, Jun 25, 2017 at 9:36 PM, Oleg Kolosov <olekol@gmail.com> wrote:
>> Hi
>> I've written an erasure code for my research purposes. I've built ceph
>> successfully however when setting up a virtual cluster and running
>> "bin/ceph osd erasure-code-profile set" I get the following error:
>> Error EIO: load dlopen(/home/ubuntu/ceph/build/lib/libec_optlrc.so):
>> /home/ubuntu/ceph/build/lib/libec_optlrc.so: undefined symbol:
>> _ZN4ceph11ErasureCode17minimum_to_decodeERKSt3setIiSt4lessIiESaIiEES7_PS5_
>>
>>
>> I'm working on master branch. ./run-make-check.sh also ran successfully.
>> I'm wondering how to approach this error.
>>
>> Thanks
