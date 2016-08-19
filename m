From: Samuel Just <sjust@redhat.com>
Subject: Re: wip-enc-dec
Date: Thu, 18 Aug 2016 17:14:11 -0700
Message-ID: <CAN=+7FWSbP8=Ae6pZnTkNwAtaVxdLEc+gRWsnfsrWvwaY8EeFw@mail.gmail.com>
References: <CAN=+7FW+csmLcFGUPNabFMwvHHy0HWKWhX+bMzpa8_cYiCjSxQ@mail.gmail.com>
 <BLUPR0201MB1524E198EBBCB36CAA1DC1FEE8150@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36297 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbcHSBIm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Aug 2016 21:08:42 -0400
Received: by mail-qk0-f178.google.com with SMTP id l2so33351476qkf.3
        for <ceph-devel@vger.kernel.org>; Thu, 18 Aug 2016 18:08:41 -0700 (PDT)
In-Reply-To: <BLUPR0201MB1524E198EBBCB36CAA1DC1FEE8150@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Varada Kari <Varada.Kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>

Here's a beginning on what that might look like:
https://github.com/athanatos/ceph/commits/wip-sam-enc-dec-proto

The design mostly comes from Allen/Varada's approach, but it uses
unsafe_appender (I don't really feel strongly about that, Sage
indicated that just using a raw pointer would probably be faster).
The important part is that the top two commits above convert all
primitive types as well as vector and pair (provided that their
templated types support the new machinery).  This means that
vector<int> should be able to preallocate and use unsafe_appender for
all existing users.  I think it's worth going to some effort to make
it easy to convert over existing users.
-Sam

On Thu, Aug 18, 2016 at 10:35 AM, Allen Samuels
<Allen.Samuels@sandisk.com> wrote:
> No reason not to merge them.
>
>
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
>> -----Original Message-----
>> From: Samuel Just [mailto:sjust@redhat.com]
>> Sent: Thursday, August 18, 2016 9:43 AM
>> To: Allen Samuels <Allen.Samuels@sandisk.com>; Varada Kari
>> <Varada.Kari@sandisk.com>; ceph-devel@vger.kernel.org
>> Subject: wip-enc-dec
>>
>> Is there a reason not to put this new machinery directly into encoding.h?  The
>> new machinery seems to be sufficient to implement the existing ::encode
>> and ::decode types and should be compatible, right?
>> With the containers, we can use template trickery to also forward the new
>> functions when present in the mapped types.  That would let us gradually
>> adapt the code base.
>> -Sam
