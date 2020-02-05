From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH resend v5 02/11] ceph: add caps perf metric for each
 session
Date: Wed, 5 Feb 2020 08:58:40 +0800
Message-ID: <110b6d58-693d-b77d-5bed-f5dfb28ce59b@redhat.com>
References: <20200129082715.5285-1-xiubli@redhat.com>
 <20200129082715.5285-3-xiubli@redhat.com>
 <a456a29671efa7a94a955bc8f1655bb042dbf13d.camel@kernel.org>
 <c60f2ad9-1b33-04d5-8b65-e4205880b345@redhat.com>
 <44f8f32e04b3fba2c6e444ba079cfd14ea180318.camel@kernel.org>
 <6d7f3509-80cc-4ff6-866a-09afde79309a@redhat.com>
 <a6065c51-10fc-e4de-aae4-1401ef7ec998@redhat.com>
 <991c69a47eada14099696d93e12cfe85750d2267.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36607 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727627AbgBEA6w (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2020 19:58:52 -0500
In-Reply-To: <991c69a47eada14099696d93e12cfe85750d2267.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/5 5:10, Jeff Layton wrote:
> On Fri, 2020-01-31 at 17:02 +0800, Xiubo Li wrote:
>> On 2020/1/31 9:34, Xiubo Li wrote:
>>> On 2020/1/31 3:00, Jeffrey Layton wrote:
>>>> That seems sort of arbitrary, given that you're going to get different
>>>> results depending on the index of the MDS with the caps. For instance:
>>>>
>>>>
>>>> MDS0: pAsLsFs
>>>> MDS1: pAs
>>>>
>>>> ...vs...
>>>>
>>>> MDS0: pAs
>>>> MDS1: pAsLsFs
>>>>
>>>> If we assume we're looking for pAsLsFs, then the first scenario will
>>>> just end up with 1 hit and the second will give you 2. AFAIU, the two
>>>> MDSs are peers, so it really seems like the index should not matter
>>>> here.
>>>>
>>>> I'm really struggling to understand how these numbers will be useful.
>>>> What, specifically, are we trying to count here and why?
>>> Maybe we need count the hit/mis only once, the fake code like:
>>>
>>> // Case1: check the auth caps first
>>>
>>> if (auth_cap & mask == mask) {
>>>
>>>      s->hit++;
>>>
>>>      return;
>>>
>>> }
>>>
>>> // Case2: check all the other one by one
>>>
>>> for (caps : i_caps) {
>>>
>>>      if (caps & mask == mask) {
>>>
>>>          s->hit++;
>>>
>>>          return;
>>>
>>>      }
>>>
>>>      c |= caps;
>>>
>>> }
>>>
>>> // Case3:
>>>
>>> if (c & mask == mask)
>>>
>>>      s->hit++;
>>>
>>> else
>>>
>>>      s->mis++;
>>>
>>> return;
>>>
>>> ....
>>>
>>> And for the session 's->' here, if one i_cap can hold all the 'mask'
>>> requested, like the Case1 and Case2 it will be i_cap's corresponding
>>> session. Or for Case3 we could choose any session.
>>>
>>> But the above is still not very graceful of counting the cap metrics too.
>>>
>>> IMO, for the cap hit/miss counter should be a global one just like the
>>> dentry_lease does in [PATCH 01/11], will this make sense ?
>>>
>> Currently in fuse client, for each inode it is its auth_cap->session's
>> responsibility to do all the cap hit/mis counting if it has a auth_cap,
>> or choose any one exist.
>>
>> Maybe this is one acceptable approach.
> Again, it's not clear to me what you're trying to measure.
>
> Typically, when you're counting hits and misses on a cache, what you
> care about is whether you had to wait to fill the cache in order to
> proceed. That means a lookup in the case of the dcache, but for this
> it's a cap request. If we have a miss, then we're going to ask a single
> MDS to resolve it.
>
> To me, it doesn't really make a lot of sense to track this at the
> session level since the client deals with cap hits and misses as a union
> of the caps for each session. Keeping per-superblock stats makes a lot
> more sense in my opinion.

This approach will be the same with the others, which are also 
per-superblock or global.

> That makes this easy to determine too. You just logically OR all of the
> "issued" masks together (and maybe the implemented masks in requests
> that allow that), and check whether that covers the mask you need. If it
> does, then you have a hit, if not, a miss.
Yeah, if so it will much easier to measure the hit/miss.
>
> So, to be clear, what we'd be measuring in that case is cap cache checks
> per superblock. Is that what you're looking to measure with this?

Basing per-superblock looks good for me, then there will need some 
change in the ceph side, which is receiving and showing the cap hit/miss 
per-session.

Thanks.
