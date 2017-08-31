From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: cephfs kernel bug (4.9.44)?
Date: Thu, 31 Aug 2017 13:32:05 -0400
Message-ID: <CAGbvivKgeMHQ2v57=j2k=0zjt5nfC5X5DRx9nFWpWDQ4HVtQ5A@mail.gmail.com>
References: <CAGbvivJVFCGXLC_VroD6JVYjXk7sOV4e6-go1nx4nRg5JtXi7A@mail.gmail.com>
 <CAOi1vP_SX9MfkxnH3hcS3C2niA-gUnz5mjrkJcanjeO1bwSsqA@mail.gmail.com>
 <CAGbvivLy-pr5xMwPCzE6uZUcJAmgAq=TKt1cEeOp4uFdARgNgg@mail.gmail.com> <CAOi1vP_Cp7=jx0rp4=p5x0d4UB6K8c3S64jUOQqqvJSUFqWewQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35543 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdHaRcG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Aug 2017 13:32:06 -0400
Received: by mail-io0-f172.google.com with SMTP id k22so2690878iod.2
        for <ceph-devel@vger.kernel.org>; Thu, 31 Aug 2017 10:32:06 -0700 (PDT)
In-Reply-To: <CAOi1vP_Cp7=jx0rp4=p5x0d4UB6K8c3S64jUOQqqvJSUFqWewQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks!

On Thu, Aug 31, 2017 at 1:28 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Thu, Aug 31, 2017 at 4:12 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> Sorry for lack of detail, here is some more info:
>>
>> Currently using ceph 10.2.7
>>
>> - Prior to the error there was nothing in the kernel log for several hours.
>> - cephfs snapshots are enabled, but are not currently being taken at
>> regular intervals, the last one was 2 days before the error message
>> appeared.
>> - cephfs has a data pool with 17123471 objects (34% full) and a
>> metadata pool with 70K objects
>> - the system has 85 OSDs and 3 MDS servers, all are in a healthy state.
>> - We use 3-copy replication rules:  81739 GB used, 161 TB / 241 TB avail
>
> OK, I see what happened.
>
> You have quite a lot of snapshots -- 4758 of them?  send_request()
> attempted to encode a 8 + 4 + 4758*8 = ~38k snap context into a 4k
> buffer.  Normally it's fine because the snap context is taken into
> account when allocating a message buffer.  However, this particular
> code path (... ceph_osdc_writepages()) uses pre-allocated messages,
> which are always 4k in size.
>
> I think it's a known bug^Wlimitation.  As a short-term fix, we can
> probably increase that pre-allocated size from 4k to something bigger.
> A proper resolution would take a considerable amount of time.  Until
> then I'd recommend a much more aggressive snapshot rotation schedule,
> which is a good idea anyway -- your writes will transmit faster!
>
> Thanks,
>
>                 Ilya
