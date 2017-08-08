From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: kraken v11.2.1 QE status
Date: Mon, 7 Aug 2017 17:15:54 -0700
Message-ID: <CAMMFjmFhh+U+EH+Qr18DABnNb3dYWD=jB7-wX7zF+Cbdy+DMhw@mail.gmail.com>
References: <CAMMFjmHRoBZP5YbrJEXUDd5F7JUbB5_r2CubuD_j6pL8J0SP3g@mail.gmail.com>
 <CAOi1vP83Wfwhxax2S0Hd2Rxht-L5=jtOLL5r14j4WiF=rH0Dvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34675 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdHHAP4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Aug 2017 20:15:56 -0400
Received: by mail-wr0-f182.google.com with SMTP id c24so1445933wra.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Aug 2017 17:15:56 -0700 (PDT)
In-Reply-To: <CAOi1vP83Wfwhxax2S0Hd2Rxht-L5=jtOLL5r14j4WiF=rH0Dvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>

Sage, pending you final blessing.

Otherwise ready for publishing,  Alfredo!

Thx
YuriW

On Mon, Aug 7, 2017 at 1:12 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Sat, Aug 5, 2017 at 6:04 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Detailed summary of the QE Validation can be found here
>> http://tracker.ceph.com/issues/19009#note-91
>>
>> The following suites were in scope of this point release validation:
>>
>> rados (subset 35/50 245 jobs)
>> rbd  (subset 35/50 100 jobs)
>> rgw
>> fs
>> krbd
>> kcephfs
>> knfs
>> rest
>> hadoop - EXCLUDED
>> samba - EXCLUDED
>> ceph-deploy
>> ceph-disk
>> upgrade/client-upgrade
>> upgrade/jewel-x (kraken)
>> upgrade/hammer-jewel-x - EXCLUDED
>> powercycle
>> ceph-ansible
>>
>> (please let me know if any suites are missing from this ^ list)
>>
>> Outstanding issues:
>>
>> krbd - Ilya, pls review and approve/comment for release as appropriate
>
> Approved.
>
> Thanks,
>
>                 Ilya
