From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v3 2/8] ceph: add caps perf metric for each session
Date: Thu, 16 Jan 2020 09:57:19 +0800
Message-ID: <7574d509-7aed-ef8e-265f-6220f865d8e0@redhat.com>
References: <20200115034444.14304-1-xiubli@redhat.com>
 <20200115034444.14304-3-xiubli@redhat.com>
 <52b531a7092a8bd09f7ade52fb17b0cee68ffd8a.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47674 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729615AbgAPB5b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:57:31 -0500
In-Reply-To: <52b531a7092a8bd09f7ade52fb17b0cee68ffd8a.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/1/15 22:24, Jeff Layton wrote:
> On Tue, 2020-01-14 at 22:44 -0500, xiubli@redhat.com wrote:
[...]
>> +/*
>> + * Counts the cap metric.
>> + */
>> +void __ceph_caps_metric(struct ceph_inode_info *ci, int mask)
>> +{
>> +	int have = ci->i_snap_caps;
>> +	struct ceph_mds_session *s;
>> +	struct ceph_cap *cap;
>> +	struct rb_node *p;
>> +	bool skip_auth = false;
>> +
>> +	if (mask <= 0)
>> +		return;
>> +
>> +	/* Counts the snap caps metric in the auth cap */
>> +	if (ci->i_auth_cap) {
>> +		cap = ci->i_auth_cap;
>> +		if (have) {
>> +			have |= cap->issued;
>> +
>> +			dout("%s %p cap %p issued %s, mask %s\n", __func__,
>> +			     &ci->vfs_inode, cap, ceph_cap_string(cap->issued),
>> +			     ceph_cap_string(mask));
>> +
>> +			s = ceph_get_mds_session(cap->session);
>> +			if (s) {
>> +				if (mask & have)
>> +					percpu_counter_inc(&s->i_caps_hit);
>> +				else
>> +					percpu_counter_inc(&s->i_caps_mis);
>> +				ceph_put_mds_session(s);
>> +			}
>> +			skip_auth = true;
>> +		}
>> +	}
>> +
>> +	if ((mask & have) == mask)
>> +		return;
>> +
>> +	/* Checks others */
>
> Iterating over i_caps requires that you hold the i_ceph_lock. Some
> callers of __ceph_caps_metric already hold it but some of the callers
> don't.
>
> The simple fix would be to wrap this function in another that takes and
> drops the i_ceph_lock before calling this one. It would also be good to
> add this at the top of this function as well:
>
> 	lockdep_assert_held(&ci->i_ceph_lock);

Yeah, let fix it using the simple way for now.


>
> The bad part is that this does mean adding in extra spinlocking to some
> of these codepaths, which is less than ideal. Eventually, I think we
> ought to convert the cap handling to use RCU and move the i_caps tree to
> a linked list. That would allow us to avoid a lot of the locking for
> stuff like this, and it never has _that_ many entries to where a tree
> really matters.
>
>> +	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
>> +		cap = rb_entry(p, struct ceph_cap, ci_node);
>> +		if (!__cap_is_valid(cap))
>> +			continue;
>> +
>> +		if (skip_auth && cap == ci->i_auth_cap)
>> +			continue;
>> +
>> +		dout("%s %p cap %p issued %s, mask %s\n", __func__,

[...]
>> @@ -2603,6 +2671,8 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
>>   		spin_lock(&ci->i_ceph_lock);
>>   	}
>>   
>> +	__ceph_caps_metric(ci, need);
>> +
> Should "want" also count toward hits and misses here? IOW:
>
> 	__ceph_caps_metric(ci, need | want);
>
> ?

Yeah, this makes sense.


>
[...]
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 1e6cdf2dfe90..b32aba4023b3 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -393,6 +393,7 @@ int ceph_open(struct inode *inode, struct file *file)
>>   		     inode, fmode, ceph_cap_string(wanted),
>>   		     ceph_cap_string(issued));
>>   		__ceph_get_fmode(ci, fmode);
>> +		__ceph_caps_metric(ci, fmode);
> This looks wrong. fmode is not a cap mask.
>
It should be "wanted" here.

Thanks
