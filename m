From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [RFC PATCH v2 10/10] ceph: attempt to do async create when
 possible
Date: Sat, 18 Jan 2020 10:42:39 +0800
Message-ID: <dcf131af-89e2-1218-3072-97232e46394a@redhat.com>
References: <20200115205912.38688-1-jlayton@kernel.org>
 <20200115205912.38688-11-jlayton@kernel.org>
 <05265520-30e8-1d88-c2f1-863308de31d1@redhat.com>
 <3d8442090c4590903425f8800dad7c504898b4ec.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20732 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727033AbgARCmv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 17 Jan 2020 21:42:51 -0500
In-Reply-To: <3d8442090c4590903425f8800dad7c504898b4ec.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com, xiubli@redhat.com

On 1/18/20 1:40 AM, Jeff Layton wrote:
> On Fri, 2020-01-17 at 21:28 +0800, Yan, Zheng wrote:
>> On 1/16/20 4:59 AM, Jeff Layton wrote:
>>> With the Octopus release, the MDS will hand out directory create caps.
>>>
>>> If we have Fxc caps on the directory, and complete directory information
>>> or a known negative dentry, then we can return without waiting on the
>>> reply, allowing the open() call to return very quickly to userland.
>>>
>>> We use the normal ceph_fill_inode() routine to fill in the inode, so we
>>> have to gin up some reply inode information with what we'd expect the
>>> newly-created inode to have. The client assumes that it has a full set
>>> of caps on the new inode, and that the MDS will revoke them when there
>>> is conflicting access.
>>>
>>> This functionality is gated on the enable_async_dirops module option,
>>> along with async unlinks, and on the server supporting the necessary
>>> CephFS feature bit.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/ceph/file.c               | 196 +++++++++++++++++++++++++++++++++--
>>>    include/linux/ceph/ceph_fs.h |   3 +
>>>    2 files changed, 190 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index b44ccbc85fe4..2742417fa5ec 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -448,6 +448,169 @@ cache_file_layout(struct inode *dst, struct inode *src)
>>>    	spin_unlock(&cdst->i_ceph_lock);
>>>    }
>>>    
>>> +/*
>>> + * Try to set up an async create. We need caps, a file layout, and inode number,
>>> + * and either a lease on the dentry or complete dir info. If any of those
>>> + * criteria are not satisfied, then return false and the caller can go
>>> + * synchronous.
>>> + */
>>> +static bool try_prep_async_create(struct inode *dir, struct dentry *dentry,
>>> +				  struct ceph_file_layout *lo,
>>> +				  unsigned long *pino)
>>> +{
>>> +	struct ceph_inode_info *ci = ceph_inode(dir);
>>> +	bool ret = false;
>>> +	unsigned long ino;
>>> +
>>> +	spin_lock(&ci->i_ceph_lock);
>>> +	/* No auth cap means no chance for Dc caps */
>>> +	if (!ci->i_auth_cap)
>>> +		goto no_async;
>>> +
>>> +	/* Any delegated inos? */
>>> +	if (xa_empty(&ci->i_auth_cap->session->s_delegated_inos))
>>> +		goto no_async;
>>> +
>>> +	if (!ceph_file_layout_is_valid(&ci->i_cached_layout))
>>> +		goto no_async;
>>> +
>>> +	/* Use LOOKUP_RCU since we're under i_ceph_lock */
>>> +	if (!__ceph_dir_is_complete(ci) &&
>>> +	    !dentry_lease_is_valid(dentry, LOOKUP_RCU))
>>> +		goto no_async;
>>
>> dentry_lease_is_valid() checks dentry lease. When directory inode has
>> Fsx caps, mds does not issue lease for individual dentry. Check here
>> should be something like dir_lease_is_valid()
> 
> Ok, I think I get it. The catch here is that we're calling this from
> atomic_open, so we may be dealing with a dentry that is brand new and
> has never had a lookup. I think we have to handle those two cases
> differently.
> 
> This is what I'm thinking:
> 
> ---
>   fs/ceph/file.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 7b14dba92266..a3eb38fac68a 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -459,6 +459,7 @@ static bool try_prep_async_create(struct inode *dir,
> struct dentry *dentry,
>   				  unsigned long *pino)
>   {
>   	struct ceph_inode_info *ci = ceph_inode(dir);
> +	struct ceph_dentry_info *di = ceph_dentry(dentry);
>   	bool ret = false;
>   	unsigned long ino;
>   
> @@ -474,16 +475,19 @@ static bool try_prep_async_create(struct inode
> *dir, struct dentry *dentry,
>   	if (!ceph_file_layout_is_valid(&ci->i_cached_layout))
>   		goto no_async;
>   
> -	/* Use LOOKUP_RCU since we're under i_ceph_lock */
> -	if (!__ceph_dir_is_complete(ci) &&
> -	    !dentry_lease_is_valid(dentry, LOOKUP_RCU))
> -		goto no_async;
> -
>   	if ((__ceph_caps_issued(ci, NULL) &
>   	     (CEPH_CAP_FILE_EXCL | CEPH_CAP_DIR_CREATE)) !=
>   	    (CEPH_CAP_FILE_EXCL | CEPH_CAP_DIR_CREATE))
>   		goto no_async;
>   
> +	if (d_in_lookup(dentry)) {
> +		if (!__ceph_dir_is_complete(ci))
> +			goto no_async;
> +	} else if (atomic_read(&ci->i_shared_gen) !=
> +		   READ_ONCE(di->lease_shared_gen)) {
> +		goto no_async;
> 

Make sense


>   	ino = ceph_get_deleg_ino(ci->i_auth_cap->session);
>   	if (!ino)
>   		goto no_async;
> 
