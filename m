From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 6/6] ceph: don't acquire i_mutex ceph_vmtruncate_work
Date: Mon, 07 Jan 2013 13:31:39 +0800
Message-ID: <50EA5DBB.7040505@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-7-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301052156400.15430@cobra.newdream.net> <50E92DAC.5070805@intel.com> <alpine.DEB.2.00.1301062101250.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21293 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab3AGFbm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jan 2013 00:31:42 -0500
In-Reply-To: <alpine.DEB.2.00.1301062101250.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 01/07/2013 01:05 PM, Sage Weil wrote:
> On Sun, 6 Jan 2013, Yan, Zheng wrote:
>> On 01/06/2013 02:00 PM, Sage Weil wrote:
>>> On Fri, 4 Jan 2013, Yan, Zheng wrote:
>>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>>
>>>> In commit 22cddde104, ceph_get_caps() was moved into ceph_write_begin().
>>>> So ceph_get_caps() can be called while i_mutex is locked. If there is
>>>> pending vmtruncate, ceph_get_caps() will wait for it to complete, but
>>>> ceph_vmtruncate_work() is blocked by the locked i_mutex.
>>>
>>> Hmm... :/
>>>
>>>> There are several places that call __ceph_do_pending_vmtruncate()
>>>> without holding the i_mutex, I think it's OK to not acquire the i_mutex
>>>> in ceph_vmtruncate_work()
>>>
>>> The intention was that that function woudl only be called under i_mutex.  
>>> I did a quick look through the callers and that appears to be the case 
>>> (for things llseek and setattr, the vfs should be taking i_mutex).
>>
>> both ceph_aio_read() and ceph_aio_write() call __ceph_do_pending_vmtruncate()
>> without holding the i_mutex
> 
> Hrm.. that's now how I remember it working.  I'm pretty sure i_mutex was 
> providing the serialization around truncation.
> 
>>> IIRC, this is to serialize the page cache truncation with truncate 
>>> operations; this work can only be sanely done under i_mutex, so we defer 
>>> it to the work queue or next person who takes i_mutex and cares about the 
>>> mapping and i_size being consistent.
>>>
>>> What was the deadlock you observed?
>>
>> generic_file_aio_write() locks the i_mutex, then indirectly calls ceph_get_caps()
>> through ceph_write_begin(). ceph_get_caps() wait for pending vmtruncate to complete,
>> but the work queue is blocked by the i_mutex.
> 
> ...but it seems clear that that's not a workable solution.  I suspect the 
> right solution here is to introduce an inner i_trunc_mutex in the ceph 
> inode and use that to protect truncation events in the page cache.  That 
> will touch a lot of different code paths, unfortunately, but I think 
> something like that is necessary if we need to block with i_mutex held by 
> the VFS.
> 

Maybe ceph_vmtruncate_work() can wait until no one is using write cap. I think it's safe to
truncate page cache in that case.

Regards
Yan, Zheng

