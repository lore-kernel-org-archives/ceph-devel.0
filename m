From: Loic Dachary <loic@dachary.org>
Subject: Re: Accelerating crush with SIMD
Date: Mon, 29 Aug 2016 10:56:47 +0200
Message-ID: <57C3F8CF.8060006@dachary.org>
References: <57C3269E.7010102@dachary.org>
 <CAJ4mKGbpnUFqXpVLVpbWrzGXHjJA17ec-evUUutBKVo9iJndBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42823 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbcH2I5v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 04:57:51 -0400
In-Reply-To: <CAJ4mKGbpnUFqXpVLVpbWrzGXHjJA17ec-evUUutBKVo9iJndBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Greg,

On 29/08/2016 06:28, Gregory Farnum wrote:
> On Sun, Aug 28, 2016 at 10:59 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
>>
>> Could we significantly accelerate crush with SIMD instructions ? I don't remember the idea being discussed but maybe I missed it.
> 
> I think it was attempted, but using a lookup table method turned out
> to be much faster. Sage did some prototyping and then some folks from
> Intel did a lot of heavy optimization; I'd be surprised if anybody
> managed to speed up the CRUSH calculations much at this point (at
> least, without changing the fundamental math involved).
> 
> Sorry I can't be more detailed; the actual CRUSH implementation is
> something I've largely left alone. I imagine the optimization points
> become pretty clear running git blame or something though. ;)

I was not thinking of accelerating the crush hash function or the straw2 function, but to have them run simultaneously on 4/8/16 items at a time using _mm, _mm256 or _mm512 instructions[1], when possible. I'll put together a proof of concept later today to clarify what I have in mind.

Cheers

[1] https://software.intel.com/sites/landingpage/IntrinsicsGuide/
-- 
Loïc Dachary, Artisan Logiciel Libre
