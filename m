From: Loic Dachary <loic@dachary.org>
Subject: Re: understanding bucket_straw2_choose
Date: Tue, 6 Jun 2017 18:47:32 +0200
Message-ID: <275673a2-cdf2-8386-1ffd-d61b82a5fef2@dachary.org>
References: <1422f34a-6a4d-45a8-85ad-32b6a7cc4a5f@dachary.org>
 <alpine.DEB.2.11.1706051807380.14237@piezo.novalocal>
 <5c6140f1-c0cc-d71e-8761-8e7fc1e68200@dachary.org>
 <alpine.DEB.2.11.1706061329120.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47166 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdFFQrg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 12:47:36 -0400
In-Reply-To: <alpine.DEB.2.11.1706061329120.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 06/06/2017 03:42 PM, Sage Weil wrote:
> On Tue, 6 Jun 2017, Loic Dachary wrote:
>> On 06/05/2017 08:13 PM, Sage Weil wrote:
>>> On Mon, 5 Jun 2017, Loic Dachary wrote:
>>>> Hi Sage,
>>>>
>>>> The following lines of bucket_straw2_choose are part black magic to me and I would very much appreciate
>>>> pointers to better understand what they do.
>>>>
>>>> 			u = crush_hash32_3(bucket->h.hash, x, ids[i], r);
>>>> 			u &= 0xffff;
>>>>
>>>> 			/*
>>>> 			 * for some reason slightly less than 0x10000 produces
>>>> 			 * a slightly more accurate distribution... probably a
>>>> 			 * rounding effect.
>>>> 			 *
>>>> 			 * the natural log lookup table maps [0,0xffff]
>>>> 			 * (corresponding to real numbers [1/0x10000, 1] to
>>>> 			 * [0, 0xffffffffffff] (corresponding to real numbers
>>>> 			 * [-11.090355,0]).
>>>> 			 */
>>>> 			ln = crush_ln(u) - 0x1000000000000ll;
>>>>
>>>> I understand the general idea (I think) which is to hash the parameters 
>>>> and calculate the log of the hash so that it can be multiplied by the 
>>>> weight without overflowing. What I don't get is the details such as: why 
>>>> &= 0xffff ? I suppose that's because crush_ln is only capable of 
>>>> returning the log for this range of values.
>>>
>>> Yeah this is somewhat arbitrary, but probably because in general all of 
>>> these values are 16.16 fixed point and [0,0x10000] is [0,1.0].  It 
>>> probably also originally was picked because it set the size of the 
>>> original lookup table.  (crush_ln() is now a more complicated function 
>>> to approximate ln.)
>>>
>>>> If that's the case how come 
>>>> it does not hurt the hashing function (in the sense that it increases 
>>>> the likelyhood that values have very similar hash) because it discards 
>>>> the higher bits?
>>>
>>> Precision here isn't all that important; these values are just determining 
>>> relative weights between different choices, but even with a very imprecise 
>>> hash function it would all average out over a large number of inputs.
>>>
>>>> Also why is it necessary to subtract 0x1000000000000ll 
>>>> ? And why this number and not another one ?
>>>
>>> crush_ln gives you [0,0xffffffffffff]; the subtraction just makes it a 
>>> negative fixed-point value before doing the division (corresponding to 
>>> [-11,0]).  
>>
>> What kind of fixed-point value is this ? I understand Q16.16 represented
>> in a u32. But here we have s64 out of which 48 bits are used and this confuses me.
> 
> The real equation is
> 
>  straw length = ln(x) / weight
> 
> where x is some random value in (0,1].
> 
> You can think of x as a 16.16 fixed-point value stored in a 64-bit 
> integer, but it doesn't really matter... it's just that the crush_ln value 
> is expecting 16-bits of input to [1/0x10000,1].  That starting value 
> ln(.000015) happens to be about -11, and ln(1) is 0, so the output range 
> in real numbers is roughly [-11,0].  crush_ln(x) *actually* returns a 
> value from [0,0x1000000000000ll], so we put it in an s64 and subtract 
> 0x1000000000000ll so that it's a negative s.48 fixed-point value, we can 
> divide by a 16.16 fixed-point weight value, and get a result that has a 
> reasonable amount of precision left.
> 
> The ranges for these fixed-point values are semi-arbitrarily chosen, 
> partly to get reasonable precision, and partly because that's what made 
> sense to me at the time. For example the crush_ln() could have been 
> adjusted to return a value that was already a negative value; the reason 
> it looks like it does it because it was originally implemented as a simple 
> lookup table that mapped (0,1) as [0,0xffff] to [-11,0] as 
> [0,0xffffffffffff] and I did the adjustment back into "real" fixed-point 
> values in the caller.  I can't remember excatly why that made the 
> most sense at the time.  :)

It makes sense now !

>> I'm also confused by the fact that crush_ln(x) returns a positive number from which 0x1000000000000ll 
>> is subtracted to make it a negative number. log(x) where x is [0,1[ is a negative number already. 
>> Unless crush_ln does not really return the log but something related to it ?
>>
>> I think I'm lost in the real number representations :-)
>>
>>> Without shifting the values everything skews toward the low end 
>>> instead of the high end when you divide.

I'm not sure I understand why. 

If the hash is on 16 bits (&0xffff) multiplying it by the weight u32 which is in the range [0, 0xffff ffff]
will produce a result in the range [0, 0xffff ffff ffff]. The weights used in Ceph are all grouped around 0x10000 and unlikely to be in outside of the range [0x1000, 0x1000000]. But I don't see why it would cause a problem for the distribution.

I'm missing something important but I can't figure out what.

Thanks a lot for the explanations :-)

>>>
>>> sage
>>>
>>>
>>>>
>>>> There is no immediate urgency to answer these questions, of course. I'm 
>>>> asking because I worked on tests to verify the C implementation of the 
>>>> algorithm to balance buckets and got into trouble. I think the reason is 
>>>> because I used straw values that are outside of the possible range for 
>>>> ln. But maybe it is because they are in the range and their distribution 
>>>> is very unlikely. Or something else ... ;-)
>>>>
>>>> Cheers
>>>>
>>>> -- 
>>>> Loïc Dachary, Artisan Logiciel Libre
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

-- 
Loïc Dachary, Artisan Logiciel Libre
