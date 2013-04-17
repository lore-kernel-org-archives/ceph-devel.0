From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 2/4] ceph: take i_mutex before getting Fw cap
Date: Wed, 17 Apr 2013 20:14:27 +0800
Message-ID: <516E9223.2050609@intel.com>
References: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com> <1365754273-14088-3-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1304162028020.23771@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7573 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966311Ab3DQMOd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 08:14:33 -0400
In-Reply-To: <alpine.DEB.2.00.1304162028020.23771@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, elder@inktank.com

On 04/17/2013 11:42 AM, Sage Weil wrote:
> On Fri, 12 Apr 2013, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> There is deadlock as illustrated bellow. The fix is taking i_mutex
>> before getting Fw cap reference.
>>
>>       write                    truncate                 MDS
>> ---------------------     --------------------      --------------
>> get Fw cap
>>                           lock i_mutex
>> lock i_mutex (blocked)
>>                           request setattr.size  ->
>>                                                 <-   revoke Fw cap
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/caps.c | 13 +++++++------
>>  fs/ceph/file.c | 12 ++++++------
>>  2 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 0da2e94..8737572 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -2058,6 +2058,13 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
>>  		goto out;
>>  	}
>>  
>> +	/* finish pending truncate */
>> +	while (ci->i_truncate_pending) {
>> +		spin_unlock(&ci->i_ceph_lock);
>> +		__ceph_do_pending_vmtruncate(inode, !(need & CEPH_CAP_FILE_WR));
>> +		spin_lock(&ci->i_ceph_lock);
> 
> I think if we retake i_ceph_lock we need to goto the top to make sure our 
> local variables aren't stale.. in this case, just file_wanted.
> 
>> +	}
>> +
>>  	if (need & CEPH_CAP_FILE_WR) {
>>  		if (endoff >= 0 && endoff > (loff_t)ci->i_max_size) {
>>  			dout("get_cap_refs %p endoff %llu > maxsize %llu\n",
>> @@ -2079,12 +2086,6 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
>>  	}
>>  	have = __ceph_caps_issued(ci, &implemented);
>>  
>> -	/*
>> -	 * disallow writes while a truncate is pending
>> -	 */
>> -	if (ci->i_truncate_pending)
>> -		have &= ~CEPH_CAP_FILE_WR;
>> -
>>  	if ((have & need) == need) {
>>  		/*
>>  		 * Look at (implemented & ~have & not) so that we keep waiting
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 546a705..5490598 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -647,7 +647,6 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
>>  	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
>>  	     inode, ceph_vinop(inode), pos, (unsigned)len, inode);
>>  again:
>> -	__ceph_do_pending_vmtruncate(inode, true);
>>  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>>  		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
>>  	else
>> @@ -724,7 +723,7 @@ retry_snap:
>>  		ret = -ENOSPC;
>>  		goto out;
>>  	}
>> -	__ceph_do_pending_vmtruncate(inode, true);
>> +	mutex_lock(&inode->i_mutex);
>>  	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
>>  	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
>>  	     inode->i_size);
>> @@ -733,8 +732,10 @@ retry_snap:
>>  	else
>>  		want = CEPH_CAP_FILE_BUFFER;
>>  	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, endoff);
>> -	if (ret < 0)
>> -		goto out_put;
>> +	if (ret < 0) {
>> +		mutex_unlock(&inode->i_mutex);
>> +		goto out;
>> +	}
>>  
>>  	dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
>>  	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
>> @@ -744,10 +745,10 @@ retry_snap:
>>  	    (iocb->ki_filp->f_flags & O_DIRECT) ||
>>  	    (inode->i_sb->s_flags & MS_SYNCHRONOUS) ||
>>  	    (fi->flags & CEPH_F_SYNC)) {
>> +		mutex_unlock(&inode->i_mutex);
>>  		ret = ceph_sync_write(file, iov->iov_base, iov->iov_len,
>>  			&iocb->ki_pos);
>>  	} else {
>> -		mutex_lock(&inode->i_mutex);
>>  		ret = __generic_file_aio_write(iocb, iov, nr_segs,
>>  					       &iocb->ki_pos);
>>  		mutex_unlock(&inode->i_mutex);
>> @@ -762,7 +763,6 @@ retry_snap:
>>  			__mark_inode_dirty(inode, dirty);
>>  	}
>>  
>> -out_put:
>>  	dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
>>  	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
>>  	     ceph_cap_string(got));
> 
> Mechanically, the rest of this looks correct.  I seem to remember us 
> changing this (or something similar) so that we *didn't* hold i_mutex 
> while waiting on the caps in order to avoid some deadlock.  But... looking 
> through the git history I can't find anything.
> 
> I think the race to consider is if we are blocked waiting for the WR cap 
> and the MDS sends us a truncate.  It will queue the async truncate work 
> but that will block waiting for i_mutex.  Can that deadlock?  (I think no, 
> but perhaps the pending truncate check needs to happen after we acquire 
> the cap, too!)

Maybe we should also call wake_up_all(&ci->i_cap_wq) when receiving truncate from
MDS.

To truncate a file, the MDS xlock the filelock firstly, which revokes all Fw caps
from clients. Then the MDS sends truncate to clients and finally drops the xlock.
It's impossible that client receives a truncate request while having Fw cap. So I
don't think we need check pending truncate after acquiring the Fw cap.

> 
> Similarly, if we block holding i_mutex and wait for WR, but the MDS 
> revokes some other cap (say, WRBUFFER), could we deadlock from teh 
> async writeback worker?

I think no, i_mutex is not involved in writeback.

> 
> Both sound dangerous to me.  I wonder if something in the spirit of
> 
> 	while (true) {
> 		get_cap(Fw)
> 		if (try_lock_mutex(...))
> 			break;
> 		put_cap(Fw);
> 		lock_mutex(...)
> 		unlock_mutex(...)
> 	}
> 
> would be simpler.  Or, make a get_cap variant that drops i_mutex while 
> waiting, but takes it before grabbing the actual Fw cap ref.
> 

See my patch "ceph: apply write checks in ceph_aio_write". I think we really
should acquire i_mutex before getting caps. ceph_get_caps() needs a parameter
'endoff', if the file is opened in append mode, the endoff is calculated from
i_size. If we drop i_mutex in ceph_get_caps(), someone else may change the
i_size.


Regards
Yan, Zheng


> sage
> 

