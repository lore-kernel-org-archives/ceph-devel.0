From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] ceph: allow sync_read/write return partial successed
 size of read/write.
Date: Thu, 22 Aug 2013 13:14:56 +0800
Message-ID: <52159E50.7000601@intel.com>
References: <201308211502490443362@gmail.com> <alpine.DEB.2.00.1308212211460.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15205 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672Ab3HVFPG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Aug 2013 01:15:06 -0400
In-Reply-To: <alpine.DEB.2.00.1308212211460.1479@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: majianpeng <majianpeng@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/22/2013 01:12 PM, Sage Weil wrote:
> On Wed, 21 Aug 2013, majianpeng wrote:
>> Hi Sage:
>> 	This patch based on my previous patch"ceph: fix bugs about handling short-read for sync read mode".
>> I can't see this patch in ceph-client#testing.Maybe you forget it ?
> 
> Whoops, I did!  I've pulled both patches into the testing branch now. 
> 
> Yan, did you want to look at this?

the patch looks good.

Yan, Zheng

> sage
> 
>>
>> Thanks!
>> Jianpeng Ma
>>
>> For sync_read/write, it may do multi stripe operations.If one of those
>> met erro, we return the former successed size rather than a error value.
>> There is a exception for write-operation met -EOLDSNAPC.If this occur,we
>> retry the whole write again.
>>
>> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
>> ---
>>  fs/ceph/file.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 69c4669..dd525c5 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -373,7 +373,7 @@ more:
>>  			goto more;
>>  	}
>>  
>> -	if (ret >= 0) {
>> +	if (read > 0) {
>>  		ret = read;
>>  		/* did we bounce off eof? */
>>  		if (pos + left > inode->i_size)
>> @@ -611,7 +611,8 @@ out:
>>  		if (check_caps)
>>  			ceph_check_caps(ceph_inode(inode), CHECK_CAPS_AUTHONLY,
>>  					NULL);
>> -	}
>> +	} else if (ret != -EOLDSNAPC && written > 0)
>> +		ret = written;
>>  	return ret;
>>  }
>>  
>> -- 
>> 1.8.1.2
>> N?????r??y????b?X????v?^?)??{.n?+???z?]z???{ay??????,j??f???h???z??w??????j:+v???w?j?m????????zZ+???????j"??!?i

