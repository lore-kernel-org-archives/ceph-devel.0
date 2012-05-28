From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: ceph: Check PagePrivate(page) before dereference, page->private
Date: Mon, 28 May 2012 14:01:12 +0800
Message-ID: <4FC314A8.1050905@intel.com>
References: <4FBF4DB7.9050707@intel.com> <Pine.LNX.4.64.1205250916410.29205@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2659 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621Ab2E1GBN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 May 2012 02:01:13 -0400
In-Reply-To: <Pine.LNX.4.64.1205250916410.29205@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/26/2012 12:24 AM, Sage Weil wrote:
> Hi Yan,
> 
> On Fri, 25 May 2012, Yan, Zheng wrote:
>> I got lots of NULL pointer dereference Oops when compiling kernel on ceph.
>> The bug is because the kernel page migration routine replaces some pages
>> in the page cache with new pages, these new pages' private can be non-zero.
>>
>> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/addr.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 173b1d2..1f180b1 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -984,7 +984,10 @@ retry_locked:
>>  	BUG_ON(!ci->i_snap_realm);
>>  	down_read(&mdsc->snap_rwsem);
>>  	BUG_ON(!ci->i_snap_realm->cached_context);
>> -	snapc = (void *)page->private;
>> +	if (PagePrivate(page))
>> +		snapc = (void *)page->private;
>> +	else
>> +		snapc = NULL;
>>  	if (snapc && snapc != ci->i_head_snapc) {
>>  		/*
>>  		 * this page is already dirty in another (older) snap
>> -- 
> 
> This looks right for this case.  What I'm less sure about is whether it's 
> sufficient.  I take it the migration only happens on clean pages?  (Unless 
> ->migrate is implemented?)
Yes, migration only happens on pages that are clean and have no private
stuff.

> 
> Before we were assuming private == NULL on any clean page, independent of 
> PG_private.  For example, ceph_invalidatepage() and ceph_releasepage() 
> have BUG_ONs that are probably wrong.  writepage_nounlock() has a sanity 
> check that should probably be strengthened/guarded with a PagePrivate() 
> check, too.
>
Will send the v2 patch soon.

Regards
Yan, Zheng

