From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] mds: update dentry lease for async create
Date: Wed, 4 Mar 2020 22:26:14 +0800
Message-ID: <6642e002-9e9b-4e73-a160-726e6d164173@redhat.com>
References: <20200304132220.41238-1-zyan@redhat.com>
 <88afc25efd69e9d07df88bb2efbc3e989e14fd9a.camel@kernel.org>
 <29ed368fce6cb62f2bbc9b5d181eacf2cdf990bb.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729386AbgCDO0V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2020 09:26:21 -0500
In-Reply-To: <29ed368fce6cb62f2bbc9b5d181eacf2cdf990bb.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org

On 3/4/20 10:05 PM, Jeff Layton wrote:
> On Wed, 2020-03-04 at 08:55 -0500, Jeff Layton wrote:
>> On Wed, 2020-03-04 at 21:22 +0800, Yan, Zheng wrote:
>>> Otherwise ceph_d_delete() may return 1 for the dentry, which makes
>>> dput() prune the dentry and clear parent dir's complete flag.
>>>
>>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>>> ---
>>>   fs/ceph/file.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 53321bf517c2..671b141aedfe 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -480,6 +480,9 @@ static int try_prep_async_create(struct inode *dir, struct dentry *dentry,
>>>   	if (d_in_lookup(dentry)) {
>>>   		if (!__ceph_dir_is_complete(ci))
>>>   			goto no_async;
>>> +		spin_lock(&dentry->d_lock);
>>> +		di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
>>> +		spin_unlock(&dentry->d_lock);
>>>   	} else if (atomic_read(&ci->i_shared_gen) !=
>>>   		   READ_ONCE(di->lease_shared_gen)) {
>>>   		goto no_async;
>>
>> Good catch, merged into testing (with small update to changelog
>> s/mds:/ceph:/)
>>
> 
> One related comment though. This patch implies that lease_shared_gen is
> protected by the d_lock, but it's not held when it's assigned in
> ceph_lookup. Should it be?
> 

we only assign and compare lease_shared_gen, I think it doesn't matter 
if it's protected by d_lock or not
