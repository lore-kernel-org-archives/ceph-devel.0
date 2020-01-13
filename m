From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v2 2/8] ceph: add caps perf metric for each session
Date: Mon, 13 Jan 2020 21:28:12 +0800
Message-ID: <8808168b-8768-be71-680e-20e3a0bcaa2c@redhat.com>
References: <20200108104152.28468-1-xiubli@redhat.com>
 <20200108104152.28468-3-xiubli@redhat.com>
 <38fc860f80d251d5cbb5ee49c253a725625190d9.camel@kernel.org>
 <a2ccd54f-11a3-a3e0-f299-00de28cca92d@redhat.com>
 <2290d0986978eb65519f2c4842a9e40db9ee7c85.camel@kernel.org>
 <7075061f-2614-4bb2-cf8b-86b8b94a1f5f@redhat.com>
 <b40d3ae50cb15d125a86d7b9c701d3836864613e.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30894 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgAMN2Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:28:25 -0500
In-Reply-To: <b40d3ae50cb15d125a86d7b9c701d3836864613e.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/1/13 21:20, Jeff Layton wrote:
> On Mon, 2020-01-13 at 09:12 +0800, Xiubo Li wrote:
>> On 2020/1/10 19:51, Jeff Layton wrote:
>>> On Fri, 2020-01-10 at 11:38 +0800, Xiubo Li wrote:
>>>> On 2020/1/9 22:52, Jeff Layton wrote:
>>>>> On Wed, 2020-01-08 at 05:41 -0500, xiubli@redhat.com wrote:
>>>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>>>
>>>>>> This will fulfill the caps hit/miss metric for each session. When
>>>>>> checking the "need" mask and if one cap has the subset of the "need"
>>>>>> mask it means hit, or missed.
>>>>>>
>>>>>> item          total           miss            hit
>>>>>> -------------------------------------------------
>>>>>> d_lease       295             0               993
>>>>>>
>>>>>> session       caps            miss            hit
>>>>>> -------------------------------------------------
>>>>>> 0             295             107             4119
>>>>>> 1             1               107             9
>>>>>>
>>>>>> Fixes: https://tracker.ceph.com/issues/43215
>>>>> For the record, "Fixes:" has a different meaning for kernel patches.
>>>>> It's used to reference an earlier patch that introduced the bug that the
>>>>> patch is fixing.
>>>>>
>>>>> It's a pity that the ceph team decided to use that to reference tracker
>>>>> tickets in their tree. For the kernel we usually use a generic "URL:"
>>>>> tag for that.
>>>> Sure, will fix it.
>>>>
>>>> [...]
>>>>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>>>>> index 28ae0c134700..6ab02aab7d9c 100644
>>>>>> --- a/fs/ceph/caps.c
>>>>>> +++ b/fs/ceph/caps.c
>>>>>> @@ -567,7 +567,7 @@ static void __cap_delay_cancel(struct ceph_mds_client *mdsc,
>>>>>>     static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
>>>>>>     			      unsigned issued)
>>>>>>     {
>>>>>> -	unsigned had = __ceph_caps_issued(ci, NULL);
>>>>>> +	unsigned int had = __ceph_caps_issued(ci, NULL, -1);
>>>>>>     
>>>>>>     	/*
>>>>>>     	 * Each time we receive FILE_CACHE anew, we increment
>>>>>> @@ -787,20 +787,43 @@ static int __cap_is_valid(struct ceph_cap *cap)
>>>>>>      * out, and may be invalidated in bulk if the client session times out
>>>>>>      * and session->s_cap_gen is bumped.
>>>>>>      */
>>>>>> -int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
>>>>>> +int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented, int mask)
>>>>> This seems like the wrong approach. This function returns a set of caps,
>>>>> so it seems like the callers ought to determine whether a miss or hit
>>>>> occurred, and whether to record it.
>>>> Currently this approach will count the hit/miss for each i_cap entity in
>>>> ci->i_caps, for example, if a i_cap has a subset of the requested cap
>>>> mask it means the i_cap hit, or the i_cap miss.
>>>>
>>>> This approach will be like:
>>>>
>>>> session       caps            miss            hit
>>>> -------------------------------------------------
>>>> 0             295             107             4119
>>>> 1             1               107             9
>>>>
>>>> The "caps" here is the total i_caps in all the ceph_inodes we have.
>>>>
>>>>
>>>> Another approach is only when the ci->i_caps have all the requested cap
>>>> mask, it means hit, or miss, this is what you meant as above.
>>>>
>>>> This approach will be like:
>>>>
>>>> session       inodes            miss            hit
>>>> -------------------------------------------------
>>>> 0             295             107             4119
>>>> 1             1               107             9
>>>>
>>>> The "inodes" here is the total ceph_inodes we have.
>>>>
>>>> Which one will be better ?
>>>>
>>>>
>>> I think I wasn't clear. My objection was to adding this "mask" field to
>>> __ceph_caps_issued and having the counting logic in there. It would be
>>> cleaner to have the callers do that instead. __ceph_caps_issued returns
>>> the issued caps, so the callers have all of the information they need to
>>> increment the proper counters without having to change
>>> __ceph_caps_issued.
>> Do you mean if the (mask & issued == mask) the caller will increase 1 to
>> the hit counter, or increase 1 miss counter, right ?
>>
>> For currently approach of this patch, when traversing the ceph_inode's
>> i_caps and if a i_cap has only a subset or all of the "mask" that means
>> hit, or miss.
>>
>> This is why changing the __ceph_caps_issued().
>>
> In this case, I'm specifically saying that you should move the hit and
> miss counting into the _callers_ of __ceph_caps_issued().
>
> That function is a piece of core infrastructure that returns the
> currently issued caps. I think that it should not be changed to count
> hits and misses, as the calling functions are in a better position to
> make that determination and it needlessly complicates low-level code.

Sure, sounds reasonable.

Will fix this part later.

>
>>>>>>     {
>>>> [...]
>>>>>>     
>>>>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>>>>> index 382beb04bacb..1e1ccae8953d 100644
>>>>>> --- a/fs/ceph/dir.c
>>>>>> +++ b/fs/ceph/dir.c
>>>>>> @@ -30,7 +30,7 @@
>>>>>>     const struct dentry_operations ceph_dentry_ops;
>>>>>>     
>>>>>>     static bool __dentry_lease_is_valid(struct ceph_dentry_info *di);
>>>>>> -static int __dir_lease_try_check(const struct dentry *dentry);
>>>>>> +static int __dir_lease_try_check(const struct dentry *dentry, bool metric);
>>>>>>     
>>>>> AFAICT, this function is only called when trimming dentries and in
>>>>> d_delete. I don't think we care about measuring cache hits/misses for
>>>>> either of those cases.
>>>> Yeah, it is.
>>>>
>>>> This will ignore the trimming dentries case, and will count from the
>>>> d_delete.
>>>>
>>>> This approach will only count the cap hit/miss called from VFS layer.
>>>>
>>> Why do you need this "metric" parameter here? We _know_ that we won't be
>>> counting hits and misses in this codepath, so it doesn't seem to serve
>>> any useful purpose.
>>>
>> We need to know where the caller comes from:
>>
>> In Case1:  caller is vfs
>>
>> This will count the hit/miss counters.
>>
>> ceph_d_delete() --> __dir_lease_try_check(metric = true) -->
>> __ceph_caps_issued_mask(mask = XXX, metric = true)
>>
> Why would you count hits/misses from the d_delete codepath? That isn't
> generally driven by user activity, and it's just checking to see whether
> we have a lease for the dentry (in which case we'll keep it around). I
> don't think we should count the lease check here as it's basically
> similar to trimming.

Okay, will remove it.


>> In Case2: caller is ceph.ko itself
>>
>> This will ignore the hit/miss counters.
>>
>> ceph_trim_dentries() --> __dentry_lease_check() -->
>> __dir_lease_try_check(metric = false) --> __ceph_caps_issued_mask(mask =
>> XXX, metric = false)
> Right, so the caller (__dentry_lease_check()) just wouldn't count it in
> this case.
>
> In general, adding a boolean argument to a function like this is often a
> sign that you're doing something wrong. You're almost always better off
> doing this sort of thing in the caller, or making two different
> functions that call the same underlying code.

Sure, this is reasonable.

BRs

Xiubo
