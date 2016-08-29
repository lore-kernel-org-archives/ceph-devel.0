From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Accelerating crush with SIMD
Date: Mon, 29 Aug 2016 11:15:01 -0700
Message-ID: <CAJ4mKGaTWNZciBqShwwFCVj5xEV4b9zzYpU_UZgLWx1XS5sQrg@mail.gmail.com>
References: <57C3269E.7010102@dachary.org> <CAJ4mKGbpnUFqXpVLVpbWrzGXHjJA17ec-evUUutBKVo9iJndBw@mail.gmail.com>
 <57C3F8CF.8060006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35828 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcH2SPC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 14:15:02 -0400
Received: by mail-ua0-f173.google.com with SMTP id i32so89850914uai.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 11:15:02 -0700 (PDT)
In-Reply-To: <57C3F8CF.8060006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 29, 2016 at 1:56 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> On 29/08/2016 06:28, Gregory Farnum wrote:
>> On Sun, Aug 28, 2016 at 10:59 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi,
>>>
>>> Could we significantly accelerate crush with SIMD instructions ? I don't remember the idea being discussed but maybe I missed it.
>>
>> I think it was attempted, but using a lookup table method turned out
>> to be much faster. Sage did some prototyping and then some folks from
>> Intel did a lot of heavy optimization; I'd be surprised if anybody
>> managed to speed up the CRUSH calculations much at this point (at
>> least, without changing the fundamental math involved).
>>
>> Sorry I can't be more detailed; the actual CRUSH implementation is
>> something I've largely left alone. I imagine the optimization points
>> become pretty clear running git blame or something though. ;)
>
> I was not thinking of accelerating the crush hash function or the straw2 function, but to have them run simultaneously on 4/8/16 items at a time using _mm, _mm256 or _mm512 instructions[1], when possible. I'll put together a proof of concept later today to clarify what I have in mind.

I know this moved threads, but now I get it and that sounds cool. :)
*thumbs up*
-Greg
