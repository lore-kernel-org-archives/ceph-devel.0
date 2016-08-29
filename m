From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Accelerating crush with SIMD
Date: Mon, 29 Aug 2016 11:16:56 +0200
Message-ID: <20160829091656.GA10692@predictor>
References: <57C3269E.7010102@dachary.org>
 <CAJ4mKGbpnUFqXpVLVpbWrzGXHjJA17ec-evUUutBKVo9iJndBw@mail.gmail.com>
 <57C3F8CF.8060006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:34695 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750860AbcH2JQH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 Aug 2016 05:16:07 -0400
Content-Disposition: inline
In-Reply-To: <57C3F8CF.8060006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 29, 2016 at 10:56:47AM +0200, Loic Dachary wrote:
> Hi Greg,
> 
> On 29/08/2016 06:28, Gregory Farnum wrote:
> > On Sun, Aug 28, 2016 at 10:59 AM, Loic Dachary <loic@dachary.org> wrote:
> >> Hi,
> >>
> >> Could we significantly accelerate crush with SIMD instructions ? I don't remember the idea being discussed but maybe I missed it.
> > 
> > I think it was attempted, but using a lookup table method turned out
> > to be much faster. Sage did some prototyping and then some folks from
> > Intel did a lot of heavy optimization; I'd be surprised if anybody
> > managed to speed up the CRUSH calculations much at this point (at
> > least, without changing the fundamental math involved).
> > 
> > Sorry I can't be more detailed; the actual CRUSH implementation is
> > something I've largely left alone. I imagine the optimization points
> > become pretty clear running git blame or something though. ;)
> 
> I was not thinking of accelerating the crush hash function or the straw2 function, but to have them run simultaneously on 4/8/16 items at a time using _mm, _mm256 or _mm512 instructions[1], when possible. I'll put together a proof of concept later today to clarify what I have in mind.
> 
> Cheers
> 
> [1] https://software.intel.com/sites/landingpage/IntrinsicsGuide/

Last time I checked, it didn't make sense in any way as crush functions were
fast enough already, and there was little room for parallelizing
calculations. This *is* possible, but requires a lot of careful rework on
all parts that actually use it. Note that just calculating 4/8/16 hashes at
once doesn't mean instant benefit as calculation is only the part of story;
you need to pack and unpack data from source/to destination and this takes
time too. Also, I don't think Ceph does so many crush recalculations per
second to make such rework feasible - but feel free to prove me wrong.

Best regards,

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
