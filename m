From: Dongsheng Yang <dongsheng.yang-zgCPCz31fAiwd6j6Zg/5ug@public.gmane.org>
Subject: Re: bcache vs flashcache vs cache tiering
Date: Thu, 16 Feb 2017 16:40:18 +0800
Message-ID: <58A56572.2020503@easystack.cn>
References: <58A2C72E.6090200@easystack.cn>
	<18e88ebb.AEEAIAHE9hIAAAAAAAAAAEtrDcsAADNJBWwAAAAAAACRXwBYotiR@mailjet.com>
	<1250894564.9950.1487089524556@ox.pcextreme.nl>
	<CAJ4mKGYEyvmZttKGGrkxU=iGvLd=vyFDapW=JuKrmfmUXzE-jA@mail.gmail.com>
	<caed7dff.ADsAAGaLee0AAAAAAAAAAF3gdzYAADNJBWwAAAAAAACRXwBYo4fW@mailjet.com>
	<58A42492.1000206@easystack.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <58A42492.1000206-zgCPCz31fAiwd6j6Zg/5ug@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org, 'Gregory Farnum' <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Wido den Hollander' <wido-fspyXLx8qC4@public.gmane.org>
Cc: 'Ceph Users' <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

BTW, is there any body using EnhanceIO?

On 02/15/2017 05:51 PM, Dongsheng Yang wrote:
> thanx Nick, Gregory and Wido,
>     So at least, we can say the cache tiering in Jewel is stable 
> enough I think.
> I like cache tiering more than the others, but yes, there is a problem 
> about cache tiering in
> flushing data between different nodes, which are not a problem in 
> local caching solution.
>
> guys:
>     Is there any plan to enhance cache tiering to solve such problem? 
> Or as Nick asked, is
> that cache tiering fading away?
>
> Yang
>
> On 15/02/2017, 06:42, Nick Fisk wrote:
>>> -----Original Message-----
>>> From: Gregory Farnum [mailto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
>>> Sent: 14 February 2017 21:05
>>> To: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
>>> Cc: Dongsheng Yang <dongsheng.yang-zgCPCz31fAiwd6j6Zg/5ug@public.gmane.org>; Nick Fisk
>>> <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>; Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>> Subject: Re: [ceph-users] bcache vs flashcache vs cache tiering
>>>
>>> On Tue, Feb 14, 2017 at 8:25 AM, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
>>> wrote:
>>>>> Op 14 februari 2017 om 11:14 schreef Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On
>>>>>> Behalf Of Dongsheng Yang
>>>>>> Sent: 14 February 2017 09:01
>>>>>> To: Sage Weil <notifications-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org>
>>>>>> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>>> Subject: [ceph-users] bcache vs flashcache vs cache tiering
>>>>>>
>>>>>> Hi Sage and all,
>>>>>>       We are going to use SSDs for cache in ceph. But I am not sure
>>>>>> which one is the best solution, bcache? flashcache? or cache
>>>>> tier?
>>>>>
>>>>> I would vote for cache tier. Being able to manage it from within
>>>>> Ceph, instead of having to manage X number of bcache/flashcache
>>>>> instances, appeals to me more. Also last time I looked Flashcache
>>>>> seems unmaintained and bcache might be going that way with talk of
>>>>> this new bcachefs. Another point to consider is that Ceph has had 
>>>>> a lot of
>>> work done on it to ensure data consistency; I don't ever want to be 
>>> in a
>>> position where I'm trying to diagnose problems that might be being 
>>> caused
>>> by another layer sitting in-between Ceph and the Disk.
>>>>> However, I know several people on here are using bcache and
>>>>> potentially getting better performance than with cache tiering, so
>>> hopefully someone will give their views.
>>>> I am using Bcache on various systems and it performs really well. The
>>> caching layer in Ceph is slow. Promoting Objects is slow and it also 
>>> involves
>>> additional RADOS lookups.
>>>
>>> Yeah. Cache tiers have gotten a lot more usable in Ceph, but the use 
>>> cases
>>> where they're effective are still pretty limited and I think in-node 
>>> caching has
>>> a brighter future. We just don't like to maintain the global state 
>>> that makes
>>> separate caching locations viable and unless you're doing something
>>> analogous to the supercomputing "burst buffers" (which some people 
>>> are!),
>>> it's going to be hard to beat something that doesn't have to pay the 
>>> cost of
>>> extra network hops/bandwidth.
>>> Cache tiers are also not a feature that all the vendors support in 
>>> their
>>> downstream products, so it will probably see less ongoing investment 
>>> than
>>> you'd expect from such a system.
>> Should that be taken as an unofficial sign that the tiering support 
>> is likely to fade away?
>>
>> I think both approaches have different strengths and probably the 
>> difference between a tiering system and a caching one is what causes 
>> some of the problems.
>>
>> If something like bcache is going to be the preferred approach, then 
>> I think more work needs to be done around certifying it for use with 
>> Ceph and allowing its behavior to be more controlled by Ceph as well. 
>> I assume there are issues around backfilling and scrubbing polluting 
>> the cache? Maybe you would want to be able to pass hints down from 
>> Ceph, which could also allow per pool cache behavior??
>>
>>> -Greg
>>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
