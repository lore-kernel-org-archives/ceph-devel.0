From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v2 2/8] ceph: add caps perf metric for each session
Date: Fri, 10 Jan 2020 11:38:27 +0800
Message-ID: <a2ccd54f-11a3-a3e0-f299-00de28cca92d@redhat.com>
References: <20200108104152.28468-1-xiubli@redhat.com>
 <20200108104152.28468-3-xiubli@redhat.com>
 <38fc860f80d251d5cbb5ee49c253a725625190d9.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55806 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731086AbgAJDik (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2020 22:38:40 -0500
In-Reply-To: <38fc860f80d251d5cbb5ee49c253a725625190d9.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/1/9 22:52, Jeff Layton wrote:
> On Wed, 2020-01-08 at 05:41 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will fulfill the caps hit/miss metric for each session. When
>> checking the "need" mask and if one cap has the subset of the "need"
>> mask it means hit, or missed.
>>
>> item          total           miss            hit
>> -------------------------------------------------
>> d_lease       295             0               993
>>
>> session       caps            miss            hit
>> -------------------------------------------------
>> 0             295             107             4119
>> 1             1               107             9
>>
>> Fixes: https://tracker.ceph.com/issues/43215
> For the record, "Fixes:" has a different meaning for kernel patches.
> It's used to reference an earlier patch that introduced the bug that the
> patch is fixing.
>
> It's a pity that the ceph team decided to use that to reference tracker
> tickets in their tree. For the kernel we usually use a generic "URL:"
> tag for that.

Sure, will fix it.

[...]
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 28ae0c134700..6ab02aab7d9c 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -567,7 +567,7 @@ static void __cap_delay_cancel(struct ceph_mds_client *mdsc,
>>   static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
>>   			      unsigned issued)
>>   {
>> -	unsigned had = __ceph_caps_issued(ci, NULL);
>> +	unsigned int had = __ceph_caps_issued(ci, NULL, -1);
>>   
>>   	/*
>>   	 * Each time we receive FILE_CACHE anew, we increment
>> @@ -787,20 +787,43 @@ static int __cap_is_valid(struct ceph_cap *cap)
>>    * out, and may be invalidated in bulk if the client session times out
>>    * and session->s_cap_gen is bumped.
>>    */
>> -int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
>> +int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented, int mask)
>
> This seems like the wrong approach. This function returns a set of caps,
> so it seems like the callers ought to determine whether a miss or hit
> occurred, and whether to record it.

Currently this approach will count the hit/miss for each i_cap entity in 
ci->i_caps, for example, if a i_cap has a subset of the requested cap 
mask it means the i_cap hit, or the i_cap miss.

This approach will be like:

session       caps            miss            hit
-------------------------------------------------
0             295             107             4119
1             1               107             9

The "caps" here is the total i_caps in all the ceph_inodes we have.


Another approach is only when the ci->i_caps have all the requested cap 
mask, it means hit, or miss, this is what you meant as above.

This approach will be like:

session       inodes            miss            hit
-------------------------------------------------
0             295             107             4119
1             1               107             9

The "inodes" here is the total ceph_inodes we have.

Which one will be better ?


>
>>   {
[...]
>>   
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 382beb04bacb..1e1ccae8953d 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -30,7 +30,7 @@
>>   const struct dentry_operations ceph_dentry_ops;
>>   
>>   static bool __dentry_lease_is_valid(struct ceph_dentry_info *di);
>> -static int __dir_lease_try_check(const struct dentry *dentry);
>> +static int __dir_lease_try_check(const struct dentry *dentry, bool metric);
>>   
> AFAICT, this function is only called when trimming dentries and in
> d_delete. I don't think we care about measuring cache hits/misses for
> either of those cases.

Yeah, it is.

This will ignore the trimming dentries case, and will count from the 
d_delete.

This approach will only count the cap hit/miss called from VFS layer.

Thanks
