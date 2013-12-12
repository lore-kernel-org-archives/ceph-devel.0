From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: question on BG# and its performance impact
Date: Thu, 12 Dec 2013 07:44:20 -0600
Message-ID: <52A9BDB4.1080800@inktank.com>
References: <A9F57F2ABA6BB2469F01E127557C6C9B10E7BF1D@SHSMSX104.ccr.corp.intel.com> <52A7E371.7050008@inktank.com> <51FC7A40FB29414D88A121A7FFEF9A4710D43F45@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1312102134130.18451@cobra.newdream.net> <51FC7A40FB29414D88A121A7FFEF9A4710D43FFC@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1312102209570.19333@cobra.newdream.net> <A9F57F2ABA6BB2469F01E127557C6C9B10E7C12B@SHSMSX104.ccr.corp.intel.com> <52A8759C.90803@inktank.com> <52A878C4.8040501@inktank.com> <A9F57F2ABA6BB2469F01E127557C6C9B10E7CD2C@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:59541 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3LLNoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Dec 2013 08:44:13 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl1so5194052igb.5
        for <ceph-devel@vger.kernel.org>; Thu, 12 Dec 2013 05:44:13 -0800 (PST)
In-Reply-To: <A9F57F2ABA6BB2469F01E127557C6C9B10E7CD2C@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Duan, Jiangang" <jiangang.duan@intel.com>
Cc: Sage Weil <sage@inktank.com>, "Zhang, Jian" <jian.zhang@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "He, Yujie" <yujie.he@intel.com>

On 12/11/2013 11:10 PM, Duan, Jiangang wrote:
> Mark,
>
> Thanks for the comments.
> One more question: is there bad impact if we use a higher PG# per OSD? E.g. 200x (I think a lot of people use this?) or 400x?
> E.g. more memory consumption or lock contention?

I have not seen performance issues directly related to the number of PGs 
per OSD, but rather based on the total number of PGs in the cluster.  At 
one point this was somewhere around 100K PGs with the hardware I was 
testing, but some of the work we did last summer may have improved this.

The symptoms were mons not responding quickly to requests and generally 
strange behaviour.

>
> -jiangang
>
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson@inktank.com]
> Sent: Wednesday, December 11, 2013 10:38 PM
> To: Duan, Jiangang
> Cc: Sage Weil; Zhang, Jian; ceph-devel@vger.kernel.org; He, Yujie
> Subject: Re: question on BG# and its performance impact
>
> On 12/11/2013 08:24 AM, Mark Nelson wrote:
>> Hi Jiangang,
>>
>> To answer your earlier question about Uniformity:
>>
>> What I saw in my testing was that the PG count increases, things did
>> tend to get more uniform, ie the standard deviation of the percentages
>> distributed over the set of OSDs slowly decreased with more PGs.
>> Primarily what I am interested in though is whether or not any
>> specific OSD has more PGs than the rest as that's all it will take to
>> screw up performance.  As far as performance goes though, in my
>> testing it didn't necessarily seem to be strongly correlated with the
>> PG distribution, except for very small numbers of PGs.  Much more
>> rigorous testing is probably needed to draw much of a conclusion.
>>
>> Sage and I had a conversation a while ago about how to deal with
>> situations where you have uneven distributions (either through not
>> having enough PGs to ensure even distribution, or simply bad luck at
>> psuedo-random roulette).  I proposed that we might iterate through
>> multiple possible pool distributions using different seed values until
>> we found one we liked with good psudorandom distribution.  Perhaps you
>> could get even fancier by looking at what happens when you lose and
>> OSD or two.  As this is all during pool creation, a little extra time
>> finding a nice initial distribution doesn't really hurt.
>>
>> Sage mentioned though that it may be better to simple take whatever
>> distribution is generated and simply re-weight it to deal with
>> uniformity imperfections.  I can't see any reason why this wouldn't
>> also work and has the benefit that it works no matter how the
>> distribution changes.  Arguably this technique could go beyond just
>> looking at PG distributions and look at actual data distribution too
>> if the user wants extremely even data uniformity at the expense of a re-weighting tweak.
>>
>> In any event, with very large clusters with lots of pools, I think we
>> will likely need to at some point adopt some kind of scheme that lets
>> us get away with fewer PGs per pool than our current recommendations.
>
> Ha, replying to my own reply!  Thinking about this a little more, these two techniques may in fact still be complementary.  For very large clusters where the PG counts per OSD may be low, I suspect we will want to at least make sure the initial map guarantees that every OSD has at least 1 PG so we can do proper re-weighting down the road.  In fact the better the initial distribution is, the less crazy we'll have to get with re-weighting, so it may not be a bad idea to use both techniques.
>
>>
>> Mark
>>
>>
>> On 12/11/2013 12:22 AM, Duan, Jiangang wrote:
>>> Cc the mail list as Sage suggested.
>>>
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sage@inktank.com]
>>> Sent: Wednesday, December 11, 2013 2:10 PM
>>> To: Zhang, Jian
>>> Cc: Mark Nelson; Duan, Jiangang
>>> Subject: RE: question on BG# and its performance impact
>>>
>>> On Wed, 11 Dec 2013, Zhang, Jian wrote:
>>>> Thanks for the suggestions, I will take a look on the ls output.
>>>> No, we didn't use the optimal crush tunables.
>>>
>>> Hopefully that is part of it... try repeating the test with the
>>> optimal tunables (now the default in master)!
>>>
>>> s
>>>
>>>
>>>>
>>>> Jian
>>>>
>>>> -----Original Message-----
>>>> From: Sage Weil [mailto:sage@inktank.com]
>>>> Sent: Wednesday, December 11, 2013 1:36 PM
>>>> To: Zhang, Jian
>>>> Cc: Mark Nelson; Duan, Jiangang
>>>> Subject: RE: question on BG# and its performance impact
>>>>
>>>> I might be worthwhile here to get teh actual list of objects (rados
>>>> -p $pool ls list.txt) and calculate the pg and osd mappings for each
>>>> of them to verify things are uniform.
>>>>
>>>> One thing: are you using the 'optimal' crush tunables (ceph osd
>>>> crush tunables optimal)?
>>>>
>>>> Also, can we cc ceph-devel?
>>>>
>>>> sage
>>>>
>>>>
>>>> On Wed, 11 Dec 2013, Zhang, Jian wrote:
>>>>
>>>>> Mark,
>>>>> Thanks for the help.
>>>>> For the performance dip, I think it should casued by the directory
>>>>> splitting, just check several OSD, it does has many sub directories.
>>>>> For the pg # and distribution, see if I understand you correctly:
>>>>> When you said "a slow trend toward uniformity" do you mean the pg #
>>>>> for each pool is unforim? But from sheet2, the pg # on OSD10 is
>>>>> 103, while the pg # on OSD8 is 72, there is still a 30% gap. And I
>>>>> think that's the reason we saw performance drop of 10M read with
>>>>> 1280 pgs
>>>>> - pg # on the OSD is not balance.
>>>>>
>>>>> Thanks
>>>>> Jian
>>>>>
>>>>> -----Original Message-----
>>>>> From: Mark Nelson [mailto:mark.nelson@inktank.com]
>>>>> Sent: Wednesday, December 11, 2013 12:01 PM
>>>>> To: Duan, Jiangang
>>>>> Cc: Sage Weil (sage@inktank.com); Zhang, Jian
>>>>> Subject: Re: question on BG# and its performance impact
>>>>>
>>>>> Hi Jiangang,
>>>>>
>>>>> My results are rather old at this point, but I did similar testing
>>>>> last spring to look at PG distribution and performance (with larger
>>>>> writes) with varying numbers of PGs.  I saw what looked like a slow
>>>>> trend toward uniformity.  Performance however was quite variable.
>>>>>
>>>>> The performance dip you saw after many hours may have been due to
>>>>> directory splitting on the underlying OSDs.  When this happens
>>>>> depends on the number of objects that are written out and the
>>>>> number of PGs in the pool.  Eventually, when enough objects are
>>>>> written, the filestore will create a deeper nested directory
>>>>> structure to store objects to keep the maximum number of objects
>>>>> per directory below a certain maximum.
>>>>> This is governed by two settings:
>>>>>
>>>>> filestore merge threshold = 10
>>>>>
>>>>> filestore split multiple = 2
>>>>>
>>>>> The total number of objects per directory is by default 10 * 2 * 16
>>>>> = 320.  With small PG counts this can cause quite a bit of
>>>>> directory splitting if there are many objects.
>>>>>
>>>>> I believe that it is likely these defaults are lower than necessary
>>>>> and we could allow more objects per directory, potentially reducing
>>>>> the number of seeks for dentry lookups (though theoretically this
>>>>> should be cached).  We definitely have seen this have a large
>>>>> performance impact with RGW though on clusters with small numbers
>>>>> of PGs.  With more PGs, and more relaxed thresholds, directory
>>>>> splitting doesn't happen until many many millions of objects are
>>>>> written out, and performance degradation as the disk fills up
>>>>> appears to be less severe.
>>>>>
>>>>> Mark
>>>>>
>>>>> On 12/10/2013 09:05 PM, Duan, Jiangang wrote:
>>>>>> Sage/mark,
>>>>>>
>>>>>> We find object# unbalance condition in our Ceph setup for both RBD
>>>>>> and object. Refer to the attached pdf.
>>>>>>
>>>>>> Increase the PG# does increase performance however result in
>>>>>> unstable issues ?
>>>>>>
>>>>>> Is this a known issue and do you have any BKM to fix this?
>>>>>>
>>>>>> -jiangang
>>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>
>

