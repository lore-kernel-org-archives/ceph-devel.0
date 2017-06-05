From: Sage Weil <sweil@redhat.com>
Subject: Re: understanding bucket_straw2_choose
Date: Mon, 5 Jun 2017 18:13:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706051807380.14237@piezo.novalocal>
References: <1422f34a-6a4d-45a8-85ad-32b6a7cc4a5f@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1843916167-1496686437=:14237"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbdFESN6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 14:13:58 -0400
In-Reply-To: <1422f34a-6a4d-45a8-85ad-32b6a7cc4a5f@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1843916167-1496686437=:14237
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2017, Loic Dachary wrote:
> Hi Sage,
> 
> The following lines of bucket_straw2_choose are part black magic to me and I would very much appreciate
> pointers to better understand what they do.
> 
> 			u = crush_hash32_3(bucket->h.hash, x, ids[i], r);
> 			u &= 0xffff;
> 
> 			/*
> 			 * for some reason slightly less than 0x10000 produces
> 			 * a slightly more accurate distribution... probably a
> 			 * rounding effect.
> 			 *
> 			 * the natural log lookup table maps [0,0xffff]
> 			 * (corresponding to real numbers [1/0x10000, 1] to
> 			 * [0, 0xffffffffffff] (corresponding to real numbers
> 			 * [-11.090355,0]).
> 			 */
> 			ln = crush_ln(u) - 0x1000000000000ll;
> 
> I understand the general idea (I think) which is to hash the parameters 
> and calculate the log of the hash so that it can be multiplied by the 
> weight without overflowing. What I don't get is the details such as: why 
> &= 0xffff ? I suppose that's because crush_ln is only capable of 
> returning the log for this range of values.

Yeah this is somewhat arbitrary, but probably because in general all of 
these values are 16.16 fixed point and [0,0x10000] is [0,1.0].  It 
probably also originally was picked because it set the size of the 
original lookup table.  (crush_ln() is now a more complicated function 
to approximate ln.)

> If that's the case how come 
> it does not hurt the hashing function (in the sense that it increases 
> the likelyhood that values have very similar hash) because it discards 
> the higher bits?

Precision here isn't all that important; these values are just determining 
relative weights between different choices, but even with a very imprecise 
hash function it would all average out over a large number of inputs.

> Also why is it necessary to subtract 0x1000000000000ll 
> ? And why this number and not another one ?

crush_ln gives you [0,0xffffffffffff]; the subtraction just makes it a 
negative fixed-point value before doing the division (corresponding to 
[-11,0]).  Without shifting the values everything skews toward the low end 
instead of the high end when you divide.

sage


> 
> There is no immediate urgency to answer these questions, of course. I'm 
> asking because I worked on tests to verify the C implementation of the 
> algorithm to balance buckets and got into trouble. I think the reason is 
> because I used straw values that are outside of the possible range for 
> ln. But maybe it is because they are in the range and their distribution 
> is very unlikely. Or something else ... ;-)
> 
> Cheers
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1843916167-1496686437=:14237--
