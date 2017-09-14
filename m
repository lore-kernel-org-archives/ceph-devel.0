From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Thu, 14 Sep 2017 10:39:13 +0300
Message-ID: <CABo9giRh3iv9wX0Wj7=b7f=g+UhPAtg0m4Xa1i9ZN=inP6Z__A@mail.gmail.com>
References: <CAMMFjmHk-YfW6-qnJmgQOWj-cdRO86ggHK-2y27GN1u-Ao8X-w@mail.gmail.com>
 <alpine.DEB.2.11.1709131543030.24068@piezo.novalocal> <CAMMFjmGoiaEdCsaYNQVZMTQqLspL47AtmoDf8=QXE14OLUAaYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46487 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdINHjO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 03:39:14 -0400
Received: by mail-wr0-f178.google.com with SMTP id o42so4508793wrb.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 00:39:14 -0700 (PDT)
In-Reply-To: <CAMMFjmGoiaEdCsaYNQVZMTQqLspL47AtmoDf8=QXE14OLUAaYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>

Trying again hopefully won't be considered a virus this time ..

On Wed, Sep 13, 2017 at 6:45 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Sage
> I will test 17674, anything else for rgw?
>

We need https://github.com/ceph/ceph/pull/17484 to fix the rgw suite.

Thanks,
Orit

> Thx
> YuriW
>
> On Wed, Sep 13, 2017 at 8:43 AM, Sage Weil <sweil@redhat.com> wrote:
>> https://github.com/ceph/ceph/pull/17674 needs to go through rgw suite and
>> get merged!
>> THanks-
>>
>>
>> On Wed, 13 Sep 2017, Yuri Weinstein wrote:
>>
>>> This email is an attempt to make sure that all are clear on luminous
>>> v12.2.1 release status.
>>>
>>> Dev leads - what is left before we can start QE validation?
>>>
>>> Thx
>>> YuriW
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
